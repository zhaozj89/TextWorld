seeds=(46985 47290 13592 10533 24155 12376 19320 44885 34524 31293
       41116 46884 44155 27933 27767 41488 13408 12762 45802 18425)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train+v2               --seed $tw_seed --output games/kg/valid/difficulty_level_1/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train+v2          --seed $tw_seed --output games/kg/valid/difficulty_level_2/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train+v2           --seed $tw_seed --output games/kg/valid/difficulty_level_3/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train+v2           --seed $tw_seed --output games/kg/valid/difficulty_level_4/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train+v2           --seed $tw_seed --output games/kg/valid/difficulty_level_5/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train+v2          --seed $tw_seed --output games/kg/valid/difficulty_level_6/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train+v2      --seed $tw_seed --output games/kg/valid/difficulty_level_7/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train+v2           --seed $tw_seed --output games/kg/valid/difficulty_level_8/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train+v2  --seed $tw_seed --output games/kg/valid/difficulty_level_9/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train+v2 --seed $tw_seed --output games/kg/valid/difficulty_level_10/ --silent -f
done
