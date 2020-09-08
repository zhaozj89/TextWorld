# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.


# -*- coding: utf-8 -*-
import os
import re
import sys
import json
import textwrap

from typing import Mapping, Union, Tuple, List, Optional

import numpy as np

from io import StringIO

import textworld
from textworld.core import EnvInfos, GameState
from textworld.generator.game2 import Game, GameProgression
from textworld.logic.pddl_logic import GameLogic, State

import fast_downward


class PddlEnv(textworld.Environment):
    """
    Environment for playing games defined by a PDDL file.
    """

    def __init__(self, infos: Optional[EnvInfos] = None) -> None:
        """
        Arguments:
            infos: Information to be included in the game state. By
                       default, only the game's narrative is included.
        """
        super().__init__(infos)
        self.downward_lib = fast_downward.load_lib()

    @property
    def _replanning(self):
        return (
            self.infos.intermediate_reward
            or self.infos.policy_commands
            or "walkthrough" in self.infos.extras
        )

    def load(self, filename_or_data: Union[str, Mapping]) -> None:
        try:
            data = json.load(open(filename_or_data))
            self._gamefile = filename_or_data
        except TypeError:
            data = filename_or_data
            self._gamefile = None

        self._logic = GameLogic(domain=data["pddl_domain"], grammar=data["grammar"])
        self._state = State(self.downward_lib, data["pddl_problem"], self._logic)

        # self._walkthrough = data.get("walkthrough", [])
        self._plan = None

        self._game = Game(self._state)
        self._game.metadata["walkthrough"] = data.get("walkthrough", [])
        self._game_progression = None

    def plan_to_templated_actions(self, plan):
        # TODO: To remove since it's Alfred specific.
        templated_actions = []
        for step in plan:
            components = step.name.split()
            action = components[0]
            action_params = [a.name.replace('?','') for a in self._game_progression.state._actions[action].parameters]
            param_values = {str(param): self._game.infos[step.name.split()[i+1]].name
                            for i, param in enumerate(action_params)}
            template = self._logic.actions[action].template if action != 'gotolocation' else "go to {r}"
            template = template.format(**param_values)
            templated_actions.append(template)

        return templated_actions

    def _gather_infos(self):
        self.state["game"] = self._game
        self.state["command_templates"] = self._game.command_templates
        self.state["verbs"] = self._game.verbs
        self.state["entities"] = self._game.entity_names
        self.state["objective"] = self._game.objective
        self.state["max_score"] = self._game.max_score

        self.state["_game_progression"] = self._game_progression
        self.state["_facts"] = list(self._game_progression.state.facts)
        self.state["won"] = self._game_progression.state.check_goal()
        self.state["lost"] = False  # TODO: ask Downward if there's no solution.

        self.state["_winning_policy"] = self._current_winning_policy
        if self.infos.policy_commands:
            self.state["policy_commands"] = self.plan_to_templated_actions(self.state["_winning_policy"])

        if self.infos.intermediate_reward:
            self.state["intermediate_reward"] = 0
            if self.state["won"]:
                # The last action led to winning the game.
                self.state["intermediate_reward"] = 1

            elif self.state["lost"]:
                # The last action led to losing the game.
                self.state["intermediate_reward"] = -1

            elif self._previous_winning_policy is None:
                self.state["intermediate_reward"] = 0

            else:
                diff = len(self._previous_winning_policy) - len(self._current_winning_policy)
                self.state["intermediate_reward"] = int(diff > 0) - int(diff < 0)  # Sign function.

        # if self.infos.facts:
        #     self.state["facts"] = list(map(self._inform7.get_human_readable_fact, self.state["_facts"]))

        self.state["last_action"] = None
        self.state["_last_action"] = self._last_action
        # if self.infos.last_action and self._last_action is not None:
        #     self.state["last_action"] = self._inform7.get_human_readable_action(self._last_action)

        self.state["_valid_actions"] = self._game_progression.valid_actions

        mapping = {k: info.name for k, info in self._game.infos.items()}
        self.state["_valid_commands"] = []
        for action in self._game_progression.valid_actions:

            context = {
                "state": self._game_progression.state,
                "facts": list(self._game_progression.state.facts),
                "variables": {ph.name: self._game.infos[var.name] for ph, var in action.mapping.items()},
                "mapping": action.mapping,
                "entity_infos": self._game.infos,
            }
            action.command_template = self._game.state._logic.grammar.derive(action.command_template, context)
            self.state["_valid_commands"].append(action.format_command(mapping))

        # To guarantee the order from one execution to another, we sort the commands.
        # Remove any potential duplicate commands (they would lead to the same result anyway).
        self.state["admissible_commands"] = sorted(set(self.state["_valid_commands"]))

        if self.infos.moves:
            self.state["moves"] = self._moves

    def reset(self):
        self.prev_state = None
        self._game_progression = GameProgression(self._game, track_quests=False)
        self._last_action = None
        self._previous_winning_policy = None
        self._current_winning_policy = None

        if self._replanning:
            if self._game.metadata["walkthrough"]:
                self._previous_winning_policy = fast_downward.names2operators(self.downward_lib, self._game.metadata["walkthrough"])

            self._current_winning_policy = self._game_progression.state.replan(self._previous_winning_policy)

        self._moves = 0

        context = {
            "state": self._game_progression.state,
            "facts": list(self._game.state.facts),
            "variables": {},
            "mapping": {}, #dict(self._game.kb.types.constants_mapping),
            "entity_infos": self._game.infos,
        }

        self.state.feedback = self._game.state._logic.grammar.derive("#intro#", context)
        self.state.raw = self.state.feedback
        self._gather_infos()

        return self.state

    def step(self, command: str):
        command = command.strip()
        self.prev_state = self.state

        self.state = GameState()
        self.state.last_command = command
        self._previous_winning_policy = self._current_winning_policy

        self._last_action = None
        try:
            # Find the action corresponding to the command.
            idx = self.prev_state["_valid_commands"].index(command)
            self._last_action = self._game_progression.valid_actions[idx]
            # An action that affects the state of the game.
            self.state.effects = self._game_progression.update(self._last_action)
            self._current_winning_policy = None
            if self._replanning:
                self._current_winning_policy = self._game_progression.state.replan(self._previous_winning_policy)

            context = {
                "state": self._game_progression.state,
                "facts": list(self._game_progression.state.facts),
                "variables": {ph.name: self._game.infos[var.name] for ph, var in self._last_action.mapping.items()},
                "mapping": self._last_action.mapping,
                "entity_infos": self._game.infos,
            }

            self.state.feedback = self._game.state._logic.grammar.derive(self._last_action.feedback_rule, context)
            self._moves += 1
        except ValueError:
            # We assume nothing has happened in the game.
            # TODO: handle error messages
            self.state.effects = []
            self.state.feedback = "Nothing happens."

        self.state.raw = self.state.feedback
        self._gather_infos()
        self.state["score"] = self._game_progression.score
        self.state["done"] = self.state["won"] or self.state["lost"]
        return self.state, self.state["score"], self.state["done"]

    def copy(self) -> "TextWorldEnv":
        """ Return a soft copy. """
        env = PddlEnv()

        env.state = self.state
        env.infos = self.infos

        env._gamefile = self._gamefile
        env._game = self._game
        env._inform7 = self._inform7

        env.prev_state = self.prev_state
        env._last_action = self._last_action
        env._previous_winning_policy = self._previous_winning_policy
        env._current_winning_policy = self._current_winning_policy
        env._moves = self._moves
        env._game_progression = self._game_progression.copy()
        return env
