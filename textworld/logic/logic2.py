
import json
import textwrap
from collections import Counter, defaultdict, deque
from functools import total_ordering, lru_cache
from typing import Callable, Dict, Iterable, List, Mapping, Optional, Set, Sequence

from tatsu.model import NodeWalker

import textworld.logic.model
from textworld.logic.model import GameLogicModelBuilderSemantics
from textworld.logic.parser import GameLogicParser


from textworld.textgen import TextGrammar


class _ModelConverter(NodeWalker):
    """
    Converts TatSu model objects to our types.
    """

    def __init__(self, logic=None):
        super().__init__()
        self._cache = {}
        self._logic = logic

    def _unescape(self, string):
        # Strip quotation marks
        return string[1:-1]

    def _unescape_block(self, string):
        # Strip triple quotation marks and dedent
        string = string[3:-3]
        return textwrap.dedent(string)

    def walk_list(self, l):
        return [self.walk(node) for node in l]

    # def _walk_variable_ish(self, node, cls):
    #     name = node.name
    #     result = cls(name, node.type)

    #     cached = self._cache.get(name)
    #     if cached:
    #         _check_type_conflict(name, cached.type, result.type)
    #         result = cached
    #     else:
    #         self._cache[name] = result

    #     return result

    # def _walk_action_ish(self, node, cls):
    #     self._cache.clear()

    #     pre = []
    #     post = []

    #     for precondition in node.preconditions:
    #         condition = self.walk(precondition.condition)
    #         pre.append(condition)
    #         if precondition.preserve:
    #             post.append(condition)

    #     post.extend(self.walk(node.postconditions))

    #     return cls(node.name, pre, post)

    # def walk_VariableNode(self, node):
    #     return self._walk_variable_ish(node, Variable)

    # def walk_SignatureNode(self, node):
    #     return Signature(node.name, node.types)

    # def walk_PropositionNode(self, node):
    #     return Proposition(node.name, self.walk(node.arguments))

    # def walk_ActionNode(self, node):
    #     return self._walk_action_ish(node, Action)

    # def walk_PlaceholderNode(self, node):
    #     return self._walk_variable_ish(node, Placeholder)

    # def walk_PredicateNode(self, node):
    #     return Predicate(node.name, self.walk(node.parameters))

    # def walk_RuleNode(self, node):
    #     return self._walk_action_ish(node, Rule)

    # def walk_AliasNode(self, node):
    #     return Alias(self.walk(node.lhs), self.walk(node.rhs))

    # def walk_PredicatesNode(self, node):
    #     for pred_or_alias in self.walk(node.predicates):
    #         if isinstance(pred_or_alias, Signature):
    #             self._logic._add_predicate(pred_or_alias)
    #         else:
    #             self._logic._add_alias(pred_or_alias)

    # def walk_RulesNode(self, node):
    #     for rule in self.walk(node.rules):
    #         self._logic._add_rule(rule)

    # def walk_ReverseRuleNode(self, node):
    #     self._logic._add_reverse_rule(node.lhs, node.rhs)

    # def walk_ReverseRulesNode(self, node):
    #     self.walk(node.reverse_rules)

    # def walk_ConstraintsNode(self, node):
    #     for constraint in self.walk(node.constraints):
    #         self._logic._add_constraint(constraint)

    # def walk_Inform7TypeNode(self, node):
    #     name = self._type.name
    #     kind = self._unescape(node.kind)
    #     definition = self._unescape(node.definition) if node.definition else None
    #     self._logic.inform7._add_type(Inform7Type(name, kind, definition))

    # def walk_Inform7PredicateNode(self, node):
    #     return Inform7Predicate(self.walk(node.predicate), self._unescape(node.source))

    # def walk_Inform7PredicatesNode(self, node):
    #     for i7pred in self.walk(node.predicates):
    #         self._logic.inform7._add_predicate(i7pred)

    # def walk_Inform7CommandNode(self, node):
    #     return Inform7Command(node.rule, self._unescape(node.command), self._unescape(node.event))

    # def walk_Inform7CommandsNode(self, node):
    #     for i7cmd in self.walk(node.commands):
    #         self._logic.inform7._add_command(i7cmd)

    # def walk_Inform7CodeNode(self, node):
    #     code = self._unescape_block(node.code)
    #     self._logic.inform7._add_code(code)

    # def walk_Inform7Node(self, node):
        # self.walk(node.parts)

    def walk_ActionTypeNode(self, node):
        action = Action(
            name=node.name,
            template=self._unescape(node.template.template),
            feedback_rule=self._unescape(node.feedback.name),
            pddl=self._unescape_block(node.pddl.code) if node.pddl else "",
            text=self._unescape_block(node.text.code) if node.text else "{}"
        )

        return action

    def walk_Document2Node(self, node):
        actions = {}
        grammar = {}
        for part in node.parts:
            if isinstance(part, textworld.logic.model.ActionTypeNode):
                action = self.walk(part)
                actions[action.name] = action
                grammar.update(json.loads(action.text))
            elif isinstance(part, textworld.logic.model.ActionTextNode):
                grammar.update(json.loads(self._unescape_block(part.code)))

        grammar = TextGrammar.parse(json.dumps(grammar))
        return actions, grammar


_PARSER = GameLogicParser(semantics=GameLogicModelBuilderSemantics(), parseinfo=True)


def _parse_and_convert(*args, **kwargs):
    model = _PARSER.parse(*args, **kwargs)
    return _ModelConverter().walk(model)


class Action:
    def __init__(self, name, template, pddl, text, feedback_rule):
       self.name = name
       self.feedback_rule = feedback_rule
       self.template = template
       self.pddl = pddl
       self.text = text


class GameLogic:
    """
    The logic for a game (types, rules, etc.).
    """

    def __init__(self):
        self._document = ""
        # self.types = TypeHierarchy()
        # self.predicates = set()
        # self.aliases = {}
        # self.rules = {}
        # self.reverse_rules = {}
        # self.constraints = {}
        # self.inform7 = Inform7Logic()

    # def _add_predicate(self, signature: Signature):
    #     if signature in self.predicates:
    #         raise ValueError("Duplicate predicate {}".format(signature))
    #     if signature in self.aliases:
    #         raise ValueError("Predicate {} is also an alias".format(signature))
    #     self.predicates.add(signature)

    # def _add_alias(self, alias: Alias):
    #     sig = alias.pattern.signature
    #     if sig in self.aliases:
    #         raise ValueError("Duplicate alias {}".format(alias))
    #     if sig in self.predicates:
    #         raise ValueError("Alias {} is also a predicate".format(alias))
    #     self.aliases[sig] = alias

    # def _add_rule(self, rule: Rule):
    #     if rule.name in self.rules:
    #         raise ValueError("Duplicate rule {}".format(rule))
    #     self.rules[rule.name] = rule

    # def _add_reverse_rule(self, rule_name, reverse_name):
    #     if rule_name in self.reverse_rules:
    #         raise ValueError("Duplicate reverse rule {}".format(rule_name))
    #     if reverse_name in self.reverse_rules:
    #         raise ValueError("Duplicate reverse rule {}".format(reverse_name))
    #     self.reverse_rules[rule_name] = reverse_name
    #     self.reverse_rules[reverse_name] = rule_name

    # def _add_constraint(self, constraint: Rule):
    #     if constraint.name in self.constraints:
    #         raise ValueError("Duplicate constraint {}".format(constraint))
    #     self.constraints[constraint.name] = constraint

    def _parse(self, document: str, path: Optional[str] = None):
        model = _PARSER.parse(document, filename=path, rule_name="start2")
        _ModelConverter().walk(model)
        self._document += document + "\n"

    # def _initialize(self):
    #     self.aliases = {sig: self._expand_alias(alias) for sig, alias in self.aliases.items()}

    #     self.rules = {name: self.normalize_rule(rule) for name, rule in self.rules.items()}
    #     self.constraints = {name: self.normalize_rule(rule) for name, rule in self.constraints.items()}

    #     for name, rule in self.rules.items():
    #         r_name = self.reverse_rules.get(name)
    #         if r_name:
    #             rule.reverse_rule = self.rules[r_name]

    #     self.inform7._initialize(self)

    # def _expand_alias(self, alias):
    #     return Alias(alias.pattern, self._expand_alias_recursive(alias.replacement, set()))

    # def _expand_alias_recursive(self, predicates, used):
    #     result = []

    #     for pred in predicates:
    #         sig = pred.signature

    #         if sig in used:
    #             raise ValueError("Cycle of aliases involving {}".format(sig))

    #         alias = self.aliases.get(pred.signature)
    #         if alias:
    #             expansion = alias.expand(pred)
    #             used.add(pred.signature)
    #             result.extend(self._expand_alias_recursive(expansion, used))
    #             used.remove(pred.signature)
    #         else:
    #             result.append(pred)

    #     return result

    # def normalize_rule(self, rule: Rule) -> Rule:
    #     pre = self._normalize_predicates(rule.preconditions)
    #     post = self._normalize_predicates(rule.postconditions)
    #     return Rule(rule.name, pre, post)

    # def _normalize_predicates(self, predicates):
    #     result = []
    #     for pred in predicates:
    #         alias = self.aliases.get(pred.signature)
    #         if alias:
    #             result.extend(alias.expand(pred))
    #         else:
    #             result.append(pred)
    #     return result

    @classmethod
    @lru_cache(maxsize=128, typed=False)
    def parse(cls, document: str) -> "GameLogic":
        result = cls()
        result._parse(document)
        # result._initialize()
        return result

    # @classmethod
    # def load(cls, paths: Iterable[str]):
    #     result = cls()
    #     for path in paths:
    #         with open(path, "r") as f:
    #             result._parse(f.read(), path=path)
    #     result._initialize()
    #     return result

    # @classmethod
    # def deserialize(cls, data: str) -> "GameLogic":
    #     return cls.parse(data)

    # def serialize(self) -> str:
    #     return self._document

