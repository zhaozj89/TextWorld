seeds=(56274 59970 84367 84976 78535 53564 81769 74846 89534 97971
       91348 73267 85684 86167 99909 62563 59836 82968 57663 85952)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/test/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/test/ --silent -f
done

#  65291 82340 66370 97317 99401 66726 62963 62963 74315 93595 66137 82125 93139 64303 77068 67632