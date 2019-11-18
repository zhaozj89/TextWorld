seeds=(6916)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_1/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_1/ --silent -f
done

[7366, 7370, 3058, 5841, 7118, 8533, 6091, 7920, 7370, 9399, 3058, 4866, 7997]

seeds=(7573 8514 3109 1702 5819 9361 7880 2268 3507 8782
       1758 6738 8097 8933 8891 2230 5767 3081 7527 6973)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_20/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_20/ --silent -f
done

seeds=(9160 4942 7073 3222 9779 1871 6648 4603 4158 3782 6564
       3385 5830 3985 3308 5539 2079 9993 6840 6673 5884 8269
       1589 9861 6909 5199 2388 5730 6137 7751 8686 1410 9746
       8087 1872 7841 6588 9601 3675 3404 5955 3203 6693 9251
       2346 9078 6050 1025 2937 5536 9458 4809 7552 9827 3349
       2577 4876 3384 8140 5561 2640 9472 5679 9505 9114 8241
       2536 2518 9674 3989 9921 9846 7129 1934 7465 7733 6012
       7348 6699)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_100/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_100/ --silent -f
done



seeds=(4249 2232 0346 8237 6465 8539 0833 3955 4068)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_over/ --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_over/ --silent -f
done
