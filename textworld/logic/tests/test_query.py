from textworld.generator import KnowledgeBase
from textworld.logic import State, Proposition
from textworld.logic import query


def _make_state():
    state = State(KnowledgeBase.default().logic, [
        Proposition.parse("at(P, kitchen: r)"),
        Proposition.parse("at(key: o, study: r)"),
        Proposition.parse("in(knife: o, I)"),
        Proposition.parse("at(table: s, kitchen: r)"),
        Proposition.parse("on(book: o, table: s)"),
        Proposition.parse("at(fridge: c, kitchen: r)"),
        Proposition.parse("in(egg: f, fridge: c)"),
        Proposition.parse("in(milk: f, fridge: c)"),
        Proposition.parse("open(fridge: c)"),
        Proposition.parse("at(cabinet: c, kitchen: r)"),
        Proposition.parse("closed(cabinet: c)"),
        Proposition.parse("in(plate: o, cabinet: c)"),
        Proposition.parse("north_of(kitchen: r, study: r)"),
        Proposition.parse("south_of(study: r, kitchen: r)"),
        Proposition.parse("west_of(kitchen: r, bedroom: r)"),
    ])
    return state


def test_find_player_location():
    state = _make_state()
    assert query.find_player_location(state).name == "kitchen"


def test_find_exits_in_scope():
    state = _make_state()
    exits = query.find_exits_in_scope(state)
    assert len(exits) == 2
    assert set(e.name for e in exits) == {"south", "east"}


def test_find_entities_in_scope():
    state = _make_state()
    entities = query.find_entities_in_scope(state)
    assert set(e.name for e in entities) == {"knife", "table", "book", "fridge", "egg", "milk", "cabinet"}


def test_find_predicates_in_scope():
    state = _make_state()
    facts = query.find_predicates_in_scope(state)
    assert set(facts) == set([
        Proposition.parse("at(P, kitchen: r)"),
        Proposition.parse("in(knife: o, I)"),
        Proposition.parse("at(table: s, kitchen: r)"),
        Proposition.parse("on(book: o, table: s)"),
        Proposition.parse("at(fridge: c, kitchen: r)"),
        Proposition.parse("in(egg: f, fridge: c)"),
        Proposition.parse("in(milk: f, fridge: c)"),
        Proposition.parse("open(fridge: c)"),
        Proposition.parse("at(cabinet: c, kitchen: r)"),
        Proposition.parse("closed(cabinet: c)"),
    ])
