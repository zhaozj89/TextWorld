#!/usr/bin/env python

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.


import argparse
import traceback

import textworld
import textworld.agents


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("games", metavar="game", nargs="+")
    parser.add_argument("-v", "--verbose", action="store_true")
    return parser.parse_args()


def main():
    args = parse_args()
    agent = textworld.agents.WalkthroughAgent()

    for i, game in enumerate(args.games, start=1):
        try:
            print("{}. Testing {} ...".format(i, game))
            log = ""
            env = textworld.start(game)
            env.activate_state_tracking()
            agent.commands = env.game.metadata.get("walkthrough")
            agent.reset(env)
            game_state = env.reset()

            if args.verbose:
                env.render()
            else:
                log += env.render(mode="text")

            reward = 0
            done = False
            while not done:
                command = agent.act(game_state, reward, done)

                # assert command in game_state.admissible_commands
                game_state, reward, done = env.step(command)

                if args.verbose:
                    env.render()
                else:
                    log += env.render(mode="text")

        except Exception as e:
            print(traceback.format_exc())
            from ipdb import set_trace; set_trace()


if __name__ == "__main__":
    main()
