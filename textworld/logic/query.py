from copy import deepcopy
from collections import OrderedDict
from typing import Iterable, List

from textworld.logic import State, Proposition, Variable
from textworld.logic import Rule, Action


def find_player_location(state: State) -> Variable:
    rule = Rule.parse("query :: at(P, r) -> result(r)")
    action = next(state.all_instantiations(rule), None)
    if action is None:
        raise ValueError("The player cannot be found in the state.")

    return action.postconditions[0].arguments[0]


def find_exits_in_scope(state: State) -> List[Variable]:
    rules = [
        Rule.parse("query :: at(P, r) & south_of(r, r') -> north()"),
        Rule.parse("query :: at(P, r) & north_of(r, r') -> south()"),
        Rule.parse("query :: at(P, r) & east_of(r, r') -> west()"),
        Rule.parse("query :: at(P, r) & west_of(r, r') -> east()"),
    ]
    actions = state.all_applicable_actions(rules)
    return [action.postconditions[0] for action in actions]


def find_entities_in_scope(state: State) -> List[Variable]:
    rules = [
        Rule.parse("query :: in(o, I) -> result(o)"),
        Rule.parse("query :: at(P, r) & at(o, r) -> result(o)"),
        Rule.parse("query :: at(P, r) & at(d, r) -> result(d)"),
        Rule.parse("query :: at(P, r) & at(s, r) -> result(s)"),
        Rule.parse("query :: at(P, r) & at(c, r) -> result(c)"),
        Rule.parse("query :: at(P, r) & at(s, r) & on(o, s) -> result(o)"),
        Rule.parse("query :: at(P, r) & at(c, r) & open(c) & in(o, c) -> result(o)"),
    ]
    actions = state.all_applicable_actions(rules)
    return [action.postconditions[0].arguments[0] for action in actions]


def find_predicates_in_scope(state: State) -> List[Proposition]:
    rules = [
        Rule.parse("query :: at(P, r) -> at(P, r)"),
        Rule.parse("query :: in(o, I) -> in(o, I)"),
        Rule.parse("query :: at(P, r) & at(o, r) -> at(o, r)"),
        Rule.parse("query :: at(P, r) & at(d, r) -> at(d, r)"),
        Rule.parse("query :: at(P, r) & at(s, r) -> at(s, r)"),
        Rule.parse("query :: at(P, r) & at(c, r) -> at(c, r)"),
        Rule.parse("query :: at(P, r) & at(s, r) & on(o, s) -> on(o, s)"),
        Rule.parse("query :: at(P, r) & at(c, r) & open(c) -> open(c)"),
        Rule.parse("query :: at(P, r) & at(c, r) & closed(c) -> closed(c)"),
        Rule.parse("query :: at(P, r) & at(c, r) & open(c) & in(o, c) -> in(o, c)"),
    ]
    actions = state.all_applicable_actions(rules)
    return [action.postconditions[0] for action in actions]

