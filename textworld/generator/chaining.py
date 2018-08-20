# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.


from textworld.generator import data
from textworld.logic import Proposition, Variable
from textworld.generator.vtypes import get_new, NotEnoughNounsError


def _hash_state(state):
    return frozenset(state.facts)


class ActionTree(object):

    def __init__(self, state, action=None, new_propositions=[]):
        self.action = action
        self.new_propositions = new_propositions
        self.children = []
        self.state = state
        self.hash = _hash_state(state)
        self.hashes = {self.hash}  # Set of seen hashes.
        self.parent = None
        self.depth = 0

    def set_parent(self, parent):
        self.parent = parent
        self.depth = parent.depth + 1

    def get_path(self):
        chain = [self]
        while chain[-1].parent is not None:
            chain.append(chain[-1].parent)

        return chain[::-1][1:]  # Do not include root.

    def traverse_preorder(self, subquests=False):
        """
        Generate chains from Actiontree. If subquests
        True yield all chains else only full chains from root to leaf.
        """
        chain = []
        to_visit = self.children[::-1]
        while len(to_visit) > 0:
            node = to_visit.pop()
            chain = chain + [node]
            to_visit += node.children[::-1]

            if subquests or len(node.children) == 0:
                yield chain

            # Backtrack chain
            while len(to_visit) > 0 and len(chain) > 0 and to_visit[-1] not in chain[-1].children:
                chain = chain[:-1]

    def to_networkx(self):
        import networkx as nx
        G = nx.Graph()
        labels = {}
        cpt = [0]

        def _recur(parent):
            for i, c in enumerate(parent.children):
                cpt[0] += 1
                c.no = str(cpt[0])
                G.add_edge(parent.no, c.no)
                params = ", ".join(map(str, c.action.variables))
                labels[c.no] = "{}({})".format(c.action.name, params)
                _recur(c)

        self.no = str(cpt[0])
        labels[self.no] = repr(self.action)  # Should be None.
        _recur(self)
        return G, labels


def get_failing_constraints(state):
    fail = Proposition("fail", [])

    failed_constraints = []
    constraints = state.all_applicable_actions(data.get_constraints().values())
    for constraint in constraints:
        if state.is_applicable(constraint):
            # Optimistically delay copying the state
            copy = state.copy()
            copy.apply(constraint)

            if copy.is_fact(fail):
                failed_constraints.append(constraint)

    return failed_constraints


def check_state(state):
    fail = Proposition("fail", [])
    debug = Proposition("debug", [])

    constraints = state.all_applicable_actions(data.get_constraints().values())
    for constraint in constraints:
        if state.is_applicable(constraint):
            # Optimistically delay copying the state
            copy = state.copy()
            copy.apply(constraint)

            if copy.is_fact(fail):
                return False

    return True


def maybe_instantiate_variables(rule, mapping, state, max_types_counts=None):
    types_counts = data.get_types().count(state)

    # Instantiate variables if needed
    try:
        for ph in rule.placeholders:
            if mapping.get(ph) is None:
                name = get_new(ph.type, types_counts, max_types_counts)
                mapping[ph] = Variable(name, ph.type)
    except NotEnoughNounsError:
        return None

    return rule.instantiate(mapping)


def _assignment_sort_key(assignment):
    rule, mapping = assignment

    # Can't directly compare Variable with None, so split the mapping
    absent = sorted(item for item in mapping.items() if item[1] is None)
    present = sorted(item for item in mapping.items() if item[1] is not None)

    return (rule.name, absent, present)


def _get_all_assignments(state, rules, partial=False, constrained_types=None, backward=False):
    assignments = []
    for rule in rules:
        if backward:
            rule = rule.inverse()
        for mapping in state.all_assignments(rule, data.get_types().constants_mapping, partial, constrained_types):
            assignments.append((rule, mapping))

    # Keep everything in a deterministic order
    return sorted(assignments, key=_assignment_sort_key)


def _is_navigation(action):
    return action.name.startswith("go/")


def _try_instantiation(rule, mapping, parent, allow_parallel_chains, max_types_counts, backward):
    action = maybe_instantiate_variables(rule, mapping, parent.state, max_types_counts=max_types_counts)
    if not action:
        return None

    new_state = parent.state.copy()

    new_propositions = []
    for prop in action.preconditions:
        if not new_state.is_fact(prop):
            if all(parent.state.has_variable(var) for var in prop.arguments):
                # Don't allow creating new predicates without any new variables
                return None
            new_state.add_fact(prop)
            new_propositions.append(prop)

    # Make sure new_state still respect the constraints.
    if not check_state(new_state):
        return None # Invalid state detected

    parent_hashes = parent.hashes | {_hash_state(new_state)}

    new_state.apply(action)

    # Some debug checks.
    assert check_state(new_state)

    if backward:
        action = action.inverse()
    child = ActionTree(new_state, action, new_propositions)

    if child.hash in parent_hashes:
        return None  # Cycle detected.

    # Keep track of all previous hashes.
    child.hashes |= parent_hashes

    # Discard parallel_chains if needed.
    last_action_before_navigation = parent
    while last_action_before_navigation.action is not None and _is_navigation(last_action_before_navigation.action):
        # HACK: Going through a door is consider always as navigation unless the previous action was to open that door.
        if last_action_before_navigation.parent.action is not None and last_action_before_navigation.parent.action.name == "open/d":
            break
        if backward and action.name == "open/d":
            break

        last_action_before_navigation = last_action_before_navigation.parent

    if last_action_before_navigation.action is not None and not allow_parallel_chains and not _is_navigation(action):
        parent_rhs = parent.action.postconditions if not backward else action.postconditions
        parent_lhs = parent.action.preconditions if not backward else action.preconditions
        recent_changes = set(parent_rhs) - set(parent_lhs)
        last_action_before_navigation_rhs = last_action_before_navigation.action.postconditions if not backward else action.postconditions
        last_action_before_navigation_lhs = last_action_before_navigation.action.preconditions if not backward else action.preconditions
        action_lhs = action.preconditions if not backward else last_action_before_navigation.action.preconditions
        changes_before_navigation = set(last_action_before_navigation_rhs) - set(last_action_before_navigation_lhs)
        if len(recent_changes & set(action_lhs)) == 0 or len(changes_before_navigation & set(action_lhs)) == 0:
            return None # Parallel chain detected.

    return child


def _get_chains(state, root=None, max_depth=1,
                    allow_parallel_chains=False, allow_partial_match=False,
                    rng=None, exceptions=[], max_types_counts=None,
                    rules_per_depth={}, backward=False):

    root = ActionTree(state) if root is None else root

    openset = [root]
    while len(openset) > 0:
        parent = openset.pop()

        rules = rules_per_depth.get(parent.depth, data.get_rules().values())
        assignments = _get_all_assignments(parent.state, rules=rules, partial=allow_partial_match, constrained_types=exceptions, backward=backward)
        if rng is not None:
            rng.shuffle(assignments)

        for rule, mapping in assignments:
            child = _try_instantiation(rule, mapping, parent, allow_parallel_chains, max_types_counts, backward)
            if child:
                child.set_parent(parent)
                parent.children.append(child)

        if len(parent.children) == 0:
            yield parent.get_path()

        if parent.depth + 1 < max_depth:
            openset += parent.children[::-1]
        else:
            for child in parent.children:
                yield child.get_path()


def get_chains(state, max_depth=1, allow_parallel_chains=False, allow_partial_match=False,
                   exceptions=[], max_types_counts=None, rules_per_depth={}, backward=False):
    root = ActionTree(state)
    for _ in _get_chains(state, root, max_depth, allow_parallel_chains, allow_partial_match,
                             exceptions=exceptions, max_types_counts=max_types_counts,
                             rules_per_depth=rules_per_depth, backward=backward):
        pass

    return root


def sample_quest(state, rng, max_depth, nb_retry=200,
                 allow_parallel_chains=False, allow_partial_match=False,
                 exceptions=[], max_types_counts=None,
                 rules_per_depth={}, backward=False):

    root = None
    chain_gen = _get_chains(state, root, max_depth, allow_parallel_chains, allow_partial_match, rng,
                                exceptions=exceptions, max_types_counts=max_types_counts,
                                rules_per_depth=rules_per_depth, backward=backward)

    best_chain = []
    for i, chain in enumerate(chain_gen):
        if i >= nb_retry:
            break

        if backward:
            chain = chain[::-1]

        # Chain shouldn't end with a navigation action unless it contains only navigation actions.
        # HACK: Because we don't generate quest using backward chaining yet,
        #       rstrip actions if navigation.
        if not all(_is_navigation(c.action) for c in chain):
            while _is_navigation(chain[-1].action):
                chain.pop()

        if len(chain) > len(best_chain):
            best_chain = chain

        if len(best_chain) >= max_depth:
            break

    return best_chain


def print_chains(chains, verbose=False, backward=False):
    for i, c in enumerate(chains):
        if backward:
            c = c[::-1]

        print("\n{}.\t{}".format(i + 1, c[0].action))
        for node in c[1:]:
            print("\t{}".format(node.action))


from collections import Counter
from functools import total_ordering
from numpy.random import RandomState
from typing import Iterable, Mapping, Optional, Sequence

from textworld.generator.data import get_logic
from textworld.generator.game import Quest
from textworld.logic import Action, GameLogic, Placeholder, Rule, State, Variable


class Chain:
    """
    An initial state and a chain of actions forming a quest.

    Attributes:
        initial_state: The initial state from which the actions start.
        actions: The sequence of actions forming this quest.
    """

    def __init__(self, initial_state: State, actions: Sequence[Action], subquest_ids: Sequence[Action]):
        self.initial_state = initial_state
        self.actions = actions
        self.subquest_ids = subquest_ids

    def __str__(self):
        string = "Chain([\n"
        for action in self.actions:
            string += "    " + str(action) + ",\n"
        string += "])"
        return string


class ChainingOptions:
    """
    Options for customizing the behaviour of chaining.

    Attributes:
        backward:
            Whether to run chaining forwards or backwards.  Forward chaining
            produces a sequence of actions that start at the provided state,
            while backward chaining produces a sequence of actions that end up
            at the provided state.
        min_depth:
            The minimum depth (length) of the generated quests.
        max_depth:
            The maximum depth of the generated quests.
        min_breadth:
            The minimum breadth of the generated quests.  When this is higher
            than 1, the generated quests will have multiple parallel subquests.
            In this case, min_depth and max_depth limit the length of these
            independent subquests, not the total size of the quest.
        max_breadth:
            The maximum breadth of the generated quests.
        create_variables:
            Whether new variables may be created during chaining.
        rng:
            If provided, randomize the order of the quests using this random
            number generator.
        logic:
            The rules of the game.
    """

    def __init__(self):
        self.backward = False
        self.min_depth = 1
        self.max_depth = 1
        self.min_breadth = 1
        self.max_breadth = 1
        self.subquests = False
        self.create_variables = False
        self.fixed_mapping = data.get_types().constants_mapping
        self.rng = None
        self.logic = data.get_logic()

    def get_rules(self, depth: int) -> Iterable[Rule]:
        """
        Get the relevant rules for this depth.

        Args:
            logic: The rules of the game.
            depth: The current depth in the chain.

        Returns:
            The rules that may be applied at this depth in the chain.
        """

        return self.logic.rules.values()

    def check_action(self, state: State, action: Action) -> bool:
        """
        Check if an action should be allowed in this state.

        The default implementation disallows actions that would create new facts
        that don't mention any new variables.

        Args:
            state: The current state.
            action: The action being applied.

        Returns:
            Whether that action should be allowed.
        """

        for prop in action.preconditions:
            if not state.is_fact(prop):
                if all(state.has_variable(var) for var in prop.arguments):
                    # Don't allow creating new predicates without any new variables
                    return False

        return True

    def check_new_variable(self, state: State, var: Variable) -> bool:
        """
        Check if a new variable should be allowed to be created in this state.

        Args:
            state: The current state.
            var: The variable being created.

        Returns:
            Whether that variable should be allowed to be created.
        """

        return True


@total_ordering
class _PartialAction:
    """
    A rule and (partial) assignment for its placeholders.
    """

    def __init__(self, rule, mapping):
        self.rule = rule
        self.mapping = mapping

        # Can't directly compare Variable with None, so split the mapping
        absent = sorted((ph, var) for ph, var in mapping.items() if var is None)
        present = sorted((ph, var) for ph, var in mapping.items() if var is not None)
        self._sort_key = (rule.name, absent, present)

    def __lt__(self, other):
        if isinstance(other, _PartialAction):
            return self._sort_key < other._sort_key
        else:
            return NotImplemented


class _ChainNode:
    """
    A node in a chain being generated.

    Each node is aware of its position (depth, breadth) in the dependency tree
    induced by the chain.  For generating parallel quests, the backtracks field
    holds actions that can be use to go up the dependency tree and start a new
    chain.

    For example, taking the action node.backtracks[i][j] will produce a new node
    at depth (i + 1) and breadth (self.breadth + 1).  To avoid duplication, in
    trees like this:

         root
         / | \
        A  B  C
        |  |  |
        .......

    A.backtracks[0] will be [B, C], B.backtracks[0] will be [C], and
    C.backtracks[0] will be [].
    """

    def __init__(self, parent, state, action, backtracks, depth, breadth):
        self.parent = parent
        self.state = state
        self.action = action
        self.backtracks = backtracks
        self.depth = depth
        self.breadth = breadth


class _Chainer:
    """
    Helper class for the chaining implementation.
    """

    def __init__(self, state, options):
        self.state = state
        self.options = options
        self.backward = options.backward
        self.max_depth = options.max_depth
        self.max_breadth = options.max_breadth
        self.create_variables = options.create_variables
        self.fixed_mapping = options.fixed_mapping
        self.rng = options.rng
        self.constraints = options.logic.constraints.values()

    def root(self) -> _ChainNode:
        """Create the root node for chaining."""
        return _ChainNode(None, self.state, None, [], 0, 1)

    def chain(self, node: _ChainNode) -> Iterable[_ChainNode]:
        """
        Perform direct forward/backward chaining.
        """

        if node.depth >= self.max_depth:
            return

        rules = self.options.get_rules(node.depth)

        assignments = self.all_assignments(node.state, rules)
        if self.rng:
            self.rng.shuffle(assignments)

        partials = []
        actions = []
        states = []
        for partial in assignments:
            action = self.try_instantiate(node.state, partial)
            if not action:
                continue

            if not self.check_action(node, action):
                continue

            state = self.apply(node, action)
            if not state:
                continue

            partials.append(partial)
            actions.append(action)
            states.append(state)

        for i, action in enumerate(actions):
            # Only allow backtracking into later actions, to avoid duplication
            remaining = partials[i+1:]
            backtracks = node.backtracks + [remaining]
            yield _ChainNode(node, states[i], action, backtracks, node.depth + 1, node.breadth)

    def backtrack(self, node: _ChainNode) -> Iterable[_ChainNode]:
        """
        Backtrack to earlier choices to generate parallel quests.
        """

        if node.breadth >= self.max_breadth:
            return

        for i, partials in enumerate(node.backtracks):
            backtracks = node.backtracks[:i]

            for j, partial in enumerate(partials):
                action = self.try_instantiate(node.state, partial)
                if not action:
                    continue

                state = self.apply(node, action)
                if not state:
                    continue

                remaining = partials[j+1:]
                new_backtracks = backtracks + [remaining]
                yield _ChainNode(node, state, action, new_backtracks, i + 1, node.breadth + 1)

    def all_assignments(self, state: State, rules: Iterable[Rule]) -> Iterable[_PartialAction]:
        """
        Compute all possible assignments for instantiating the given rules.
        """

        assignments = []
        for rule in rules:
            if self.backward:
                rule = rule.inverse()

            for mapping in state.all_assignments(rule, self.fixed_mapping, self.create_variables):
                assignments.append(_PartialAction(rule, mapping))

        # Keep everything in a deterministic order
        return sorted(assignments)

    def try_instantiate(self, state: State, partial: _PartialAction) -> Optional[Action]:
        """
        Try to instantiate a partial action, by creating new variables if
        necessary.
        """

        rule, mapping = partial.rule, partial.mapping

        if self.create_variables:
            type_counts = Counter({ph.type: len(state.variables_of_type(ph.type)) for ph in rule.placeholders})

        for ph in rule.placeholders:
            if mapping.get(ph) is None:
                var = self.create_variable(state, ph, type_counts)
                if var:
                    mapping[ph] = var
                else:
                    return None

        return rule.instantiate(mapping)

    def create_variable(self, state, ph, type_counts):
        """Create a new variable of the given type."""

        count = type_counts[ph.type]
        name = "{}_{}".format(ph.type, count)
        var = Variable(name, ph.type)
        while state.has_variable(var):
            name += "'"
            var = Variable(name, type)

        if self.options.check_new_variable(state, var):
            type_counts[ph.type] += 1
            return var
        else:
            return None

    def check_action(self, node: _ChainNode, action: Action) -> bool:
        # Find the last action before a navigation action
        # TODO: Fold this behaviour into ChainingOptions.check_action()
        nav_parent = node
        while nav_parent.action is not None and _is_navigation(nav_parent.action):
            # HACK: Going through a door is always considered navigation unless the previous action was to open that door.
            parent = nav_parent.parent
            if parent.action is not None and parent.action.name == "open/d":
                break
            if self.backward and action.name == "open/d":
                break
            nav_parent = parent

        if nav_parent.action is not None and not _is_navigation(action):
            if self.backward:
                recent = action.inverse()
                pre_navigation = recent
                post_navigation = nav_parent.action.inverse()
            else:
                recent = node.action
                pre_navigation = nav_parent.action
                post_navigation = action

            relevant = set(post_navigation.preconditions)

            if len(recent.added & relevant) == 0 or len(pre_navigation.added & relevant) == 0:
                return False

        return self.options.check_action(node.state, action)

    def apply(self, node: _ChainNode, action: Action) -> Optional[State]:
        """Attempt to apply an action to the given state."""

        new_state = node.state.copy()
        for prop in action.preconditions:
            new_state.add_fact(prop)

        # Make sure new_state still respects the constraints
        if not self.check_state(new_state):
            return None

        new_state.apply(action)

        # Some debug checks
        assert self.check_state(new_state)

        # Detect cycles
        state = new_state.copy()
        state.apply(action.inverse())
        while node.action:
            state.apply(node.action.inverse())
            if new_state == state:
                return None
            node = node.parent

        return new_state

    def check_state(self, state: State) -> bool:
        """Check that a state satisfies the constraints."""

        fail = Proposition("fail", [])

        constraints = state.all_applicable_actions(self.constraints)
        for constraint in constraints:
            if state.is_applicable(constraint):
                # Optimistically delay copying the state
                copy = state.copy()
                copy.apply(constraint)

                if copy.is_fact(fail):
                    return False

        return True

    def make_chain(self, node):
        """Create an entire Chain object from a node."""

        actions = []
        parent = node
        subquest_ids = []
        while parent.action:
            if self.backward:
                action = parent.action.inverse()
            else:
                action = parent.action
            actions.append(action)
            subquest_ids.append(parent.breadth)
            parent = parent.parent

        state = node.state.copy()
        if not self.backward:
            for action in actions:
                state.apply(action.inverse())
            actions = actions[::-1]
            subquest_ids = subquest_ids[::-1]

        return Chain(state, actions, subquest_ids)


def chain(state: State, options: ChainingOptions) -> Iterable[Chain]:
    """
    Generates chains of actions (quests) starting from or ending at the given
    state.

    Args:
        state:
            The initial state for chaining.

    Returns:
        All possible quests according to the constraints.
    """

    chainer = _Chainer(state, options)

    stack = [chainer.root()]
    while stack:
        node = stack.pop()

        no_children = True
        for child in chainer.chain(node):
            stack.append(child)
            no_children = False

        if no_children or options.subquests:
            for child in chainer.backtrack(node):
                stack.append(child)

            if node.depth >= options.min_depth and node.breadth >= options.min_breadth:
                yield chainer.make_chain(node)
