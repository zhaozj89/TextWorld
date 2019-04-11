# tw-make --third-party cooking.py tw-cooking --output games/ -f --go 12 --recipe 3 --take 3 --cook --cut --open --seed 1
# seq 1 10 | xargs -n1 -P4 tw-make --third-party cooking.py tw-cooking --format z8 --output games/ -f --go 12 --recipe 3 --take 3 --cook --cut --open --seed
tw-make --third-party cooking.py tw-cooking --output tw_games/tutorial.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 20190410

# No treatment (baseline)
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102

# Highlighting entities
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101 --highlight
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102 --highlight

# Replacing all entity names with made-up words
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101 --fake-entities
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102 --fake-entities

# Replacing all command verbs with made-up words
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101 --fake-commands
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102 --fake-commands

# Swapping all command verbs with each other
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101 --swap-commands
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102 --swap-commands

# Removing context around entities
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 2 --seed 201904101 --entity-only
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_2.z8 -f --cook --cut --open --go 6 --recipe 3 --take 2 --seed 201904102 --entity-only
