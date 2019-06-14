# Run the following command
# DEBUG="--debug" parallel < make_games.sh

DEBUG="--debug"

tw-make --third-party cooking.py tw-cooking --output tw_games/tutorial.z8 -f --cook --cut --open --go 1 --recipe 1 --take 1 --seed 20190410 $DEBUG

# No treatment (baseline)
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment0_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 $DEBUG

# Highlighting entities
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --highlight $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --highlight $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --highlight $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --highlight $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment1_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --highlight $DEBUG

# Replacing all entity names with made-up words
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --fake-entities $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --fake-entities $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --fake-entities $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --fake-entities $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment2_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --fake-entities $DEBUG

# Replacing all command verbs with made-up words
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment3_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --fake-commands $DEBUG

# Swapping all command verbs with each other
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --swap-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --swap-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --swap-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --swap-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment4_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --swap-commands $DEBUG

# Removing context around entities
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --entity-only $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --entity-only $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --entity-only $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --entity-only $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment5_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --entity-only $DEBUG

# Replacing all entity names and all command verbs with made-up words
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment6_1.z8 -f --cook --cut --open --go 1 --recipe 2 --take 1 --seed 201905107 --fake-entities --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment6_2.z8 -f --cook --cut --open --go 2 --recipe 2 --take 2 --seed 201905102 --fake-entities --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment6_3.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seed 201905108 --fake-entities --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment6_4.z8 -f --cook --cut --open --go 5 --recipe 3 --take 3 --seeds 2179 2019 06 13 --fake-entities --fake-commands $DEBUG
tw-make --third-party cooking.py tw-cooking --output tw_games/treatment6_5.z8 -f --cook --cut --open --go 8 --recipe 3 --take 3 --seed 201905108 --fake-entities --fake-commands $DEBUG
