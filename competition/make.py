#!/usr/bin/env python
import pprint
import argparse
import warnings
import itertools
import multiprocessing
from subprocess import check_call

import numpy as np
from tqdm import tqdm

import textworld
from textworld.challenges.cooking import SKILLS as SORTED_SKILLS


SKILLS = [["recipe1", "recipe2", "recipe3"],
          ["take1", "take2", "take3"],
          ["cut"],
          ["cook"],
          ["open"],
          ["drop"],
          ["go6", "go9", "go12"],
         ]


def parse_args():
    description = "Make the games for the TextWorld Competition v1."
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument("--nb-games", type=float, default=1,
                        help="Number of games per skillset to generate. Default: %(default)s")
    parser.add_argument("--split", choices=["train", "valid", "valid2", "test"],
                        help="Which dataset split to generate games for.")
    parser.add_argument("--shuffle", action="store_true",
                        help="Shuffle the skillsets. Default: loop through them in order of difficulty.")
    parser.add_argument("--output", default="./tw_games/",
                        help="Output path (a folder).")
    parser.add_argument("--seed", type=int,
                        help="Random seed controlling the game generation process.")
    parser.add_argument("--nb-processes", type=int,
                        help="Number of games to generate in parallel."
                             " Default: as many as there are CPU cores.")
    parser.add_argument('--format', choices=["ulx", "z8"], default="ulx",
                        help="Which format to use when compiling the game. Default: %(default)s")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Activate verbose mode.")
    parser.add_argument("--dry", action="store_true",
                        help="Only print all the different difficulty settings.")
    return parser.parse_args()


def _gen_skills_to_combine():
    skills_to_combine = itertools.product(*SKILLS)
    for skills in skills_to_combine:
        yield skills


def _gen_skills():
    def _includes(name, skills):
        for skill in skills:
            if skill.startswith(name):
                return True

        return False

    seen = set()
    for skills_to_combine in _gen_skills_to_combine():
        for i in range(1, len(skills_to_combine) + 1):
            for skills in itertools.combinations(skills_to_combine, i):
                skills = tuple(sorted(skills))
                if skills in seen:
                    continue

                if "recipe1" not in skills and "recipe2" not in skills and "recipe3" not in skills and "recipe4" not in skills and "recipe5" not in skills:
                    continue  # Invalid game.

                if _includes("take", skills) and (
                    ("recipe1" in skills and "take1" not in skills) or  # Fixing recipeN == takeN
                    ("recipe2" in skills and "take2" not in skills) or  # Fixing recipeN == takeN
                    ("recipe3" in skills and "take3" not in skills) or  # Fixing recipeN == takeN
                    ("recipe4" in skills and "take1" in skills) or  # Fixing recipeN ~ takeN
                    ("recipe4" in skills and "take2" in skills) or  # Fixing recipeN ~ takeN
                    ("recipe4" in skills and "take5" in skills) or  # Fixing recipeN >= takeN
                    ("recipe5" in skills and "take1" in skills) or  # Fixing recipeN ~ takeN
                    ("recipe5" in skills and "take2" in skills) or  # Fixing recipeN ~ takeN
                    ("recipe5" in skills and "take3" in skills)):   # Fixing recipeN ~ takeN
                    continue

                if _includes("go", skills) and not _includes("take", skills) and "recipe3" not in skills:
                    continue  # When nothing to take and go is needed, force recipe3.

                if "open" in skills and not _includes("take", skills) and not _includes("go", skills):
                    continue  # Nothing *really* needs to be opened.

                if "drop" in skills and not _includes("take", skills) and "cut" not in skills:
                    continue  # Nothing *really* needs to be dropped.

                seen.add(skills)
                yield skills


def _generate_game(challenge_id, seed, file_format, output):
    command = ["tw-make", "challenge", challenge_id, "--seed", seed, "--format", file_format, "--output", output, "--silent"]
    check_call(command)


def main():
    args = parse_args()
    if args.split == "valid2":
        SKILLS[0] = ["recipe4"]
        SKILLS[1] = ["take3", "take4"]
    elif args.split == "test":
        SKILLS[0].extend(["recipe4", "recipe5"])
        SKILLS[1].extend(["take4", "take5"])

    if args.nb_processes is None:
        args.nb_processes = multiprocessing.cpu_count()

    challenge_ids = []
    for i, skills in enumerate(_gen_skills()):
        skills = sorted(skills, key=lambda skill: SORTED_SKILLS.index(skill.rstrip("0123456789")))
        challenge_id = "tw-cooking-" + "+".join(skills)
        challenge_ids.append(challenge_id)

    args.seed = args.seed or np.random.randint(65635)
    rng = np.random.RandomState(args.seed)

    specs = []

    # Sort commands according to the number of skills present in the game.
    challenge_ids = sorted(challenge_ids)
    challenge_ids = sorted(challenge_ids, key=lambda e: len(e.split("+")))

    if args.shuffle:
        rng.shuffle(challenge_ids)

    if args.dry:
        pprint.pprint([c for c in challenge_ids if "go" not in c])
        for go in ["go6", "go9", "go12"]:
            pprint.pprint([c for c in challenge_ids if go in c])

        return

    nb_games = int(args.nb_games * len(challenge_ids))
    for i in range(nb_games):
        seed = rng.randint(65635)
        challenge_id = challenge_ids[i % len(challenge_ids)]
        if args.split:
            challenge_id = challenge_id + "+{}".format(args.split)

        specs.append((challenge_id, str(seed)))

    print("Using {} processes.".format(args.nb_processes))
    desc = "Generating {} games with seed={}".format(nb_games, args.seed)
    pbar = tqdm(total=nb_games, desc=desc)

    if args.nb_processes > 1:
        pool = multiprocessing.Pool(args.nb_processes)
        for challenge_id, seed in specs:
            pool.apply_async(_generate_game, (challenge_id, seed, args.format, args.output), callback=lambda _: pbar.update())

        pool.close()
        pool.join()
        pbar.close()

    else:
        for challenge_id, seed in specs:
            _generate_game(challenge_id, seed, args.format, args.output)
            pbar.update()


if __name__ == "__main__":
    main()
