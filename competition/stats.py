#!/usr/bin/env python

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

import os
import sys
import json
import argparse
from collections import defaultdict, Counter
from pprint import pprint

import numpy as np
from tqdm import tqdm

from textworld.generator import Game
from textworld.generator.logger import GameLogger


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="View statistics of generated games.")
    parser.add_argument("games", metavar="game", nargs="+",
                        help="JSON files containing infos about a game.")
    parser.add_argument("--output", default="stats.json",
                        help="Path to the output file where to save the stats (JSON).")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Print stats.")
    parser.add_argument("-f", "--force", action="store_true",
                        help="Overwrite existing output file.")
    args = parser.parse_args()

    if os.path.isfile(args.output) and not args.force:
        print("{} already exists. Use -f to overwrite it.".format(args.output))
        sys.exit(1)

    objectives = {}
    names = set()

    stats = {
        "ingredients": defaultdict(int),
        "foods": defaultdict(int),
        "unused_foods": defaultdict(int),
        "cutting": defaultdict(int),
        "cooking": defaultdict(int),
        "skills": defaultdict(int),
        "walkthroughs": [],
    }

    for game_filename in tqdm(args.games):
        try:
            game = Game.load(game_filename.replace(".ulx", ".json"))
        except Exception as e:
            print("Cannot load {}.".format(game))
            if args.verbose:
                print(e)

            continue

        walkthrough = game.metadata.get("walkthrough", [])
        stats["walkthroughs"].append(walkthrough)

        for k, v in game.metadata["skills"].items():
            if v is True:
                stats["skills"][k] += 1
            else:
                stats["skills"]["{}{}".format(k, v)] += 1

        ingredients = game.metadata["ingredients"]
        for food, cooking, cutting in ingredients:
            stats["ingredients"][food] += 1
            stats["cooking"][cooking] += 1
            stats["cutting"][cutting] += 1

        for k, v in game.infos.items():
            if v.type != "f":
                continue

            stats["foods"][v.name] += 1

    stats["unused_foods"] = sorted([food for food in stats["foods"] if food not in stats["ingredients"]])

    # Compute stats on walkthroughs.
    walkthroughs = stats["walkthroughs"]
    walkthrough_lengths = list(map(len, walkthroughs))
    stats["walkthroughs"] = {
        "length": {
            "min": min(walkthrough_lengths),
            "max": max(walkthrough_lengths),
            "avg": np.mean(walkthrough_lengths),
        }
    }

    with open(args.output, "w") as f:
        json.dump(stats, f, sort_keys=True, indent=2)

    if args.verbose:
        # Replace defaultdict with dict using json.dumps.
        stats = json.dumps(stats, sort_keys=True, indent=2)
        print(stats)
