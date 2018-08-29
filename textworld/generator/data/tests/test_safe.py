from os.path import join as pjoin

import textworld

from textworld import g_rng  # Global random generator.
from textworld import GameMaker
from textworld.utils import make_temp_directory


def test_safe():
    # Make the generation process reproducible.
    g_rng.set_seed(20180829)

    M = GameMaker()
    bank = M.new_room("Bank")
    M.set_player(bank)

    money = M.new("o", name="gold bar")
    safe = M.new("safe", name="safe")
    M.add_fact("closed", safe)
    bank.add(safe)
    safe.add(money)

    lock_combination = M.new(type="number", name="1234")
    M.add_fact("combination", safe, lock_combination)

    with make_temp_directory(prefix="test_safe") as tmpdir:
        game_file = M.compile(pjoin(tmpdir, "game.ulx"))
        env = textworld.start(game_file)
        env.activate_state_tracking()
        env.reset()

        game_state, _, _ = env.step("open safe")
        assert "opens only when turned to the correct combination" in game_state.feedback

        game_state, _, _ = env.step("spin safe to 4321")
        assert "Click! and nothing else happens." in game_state.feedback

        assert "spin safe to 1234" in game_state.admissible_commands
        game_state, _, _ = env.step("spin safe to 1234")
        assert "spin safe to 1234" not in game_state.admissible_commands
        assert "Clonk! and the safe door swings slowly open, revealing a gold bar." in game_state.feedback

        game_state, _, _ = env.step("take gold bar from safe")
        assert "gold bar" in game_state.inventory

        game_state, _, _ = env.step("close safe")
        game_state, _, _ = env.step("open safe")
        assert "opens only when turned to the correct combination" in game_state.feedback
