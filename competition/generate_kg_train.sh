seeds=(6916)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_1/difficulty_level_1/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_1/difficulty_level_2/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_1/difficulty_level_3/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_1/difficulty_level_4/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_1/difficulty_level_5/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_1/difficulty_level_6/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_1/difficulty_level_7/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_1/difficulty_level_8/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_1/difficulty_level_9/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_1/difficulty_level_10/ --silent -f
done

# 7573 -> 3058
seeds=(3058 8514 3109 1702 5819 9361 7880 2268 3507 8782
       1758 6738 8097 8933 8891 2230 5767 7527 6973)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_20/difficulty_level_1/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_20/difficulty_level_2/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_20/difficulty_level_3/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_20/difficulty_level_4/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_20/difficulty_level_5/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_20/difficulty_level_6/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_20/difficulty_level_7/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_20/difficulty_level_8/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_20/difficulty_level_9/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_20/difficulty_level_10/ --silent -f
done

seeds=(9160 4942 7073 3222 9779 1871 6648 4603 4158 3782 6564
       3385 5830 3985 3308 5539 2079 9993 6840 6673 5884 8269
       1589 9861 6909 5199 2388 5730 6137 7751 8686 1410 9746
       8087 1872 7841 6588 9601 3675 3404 5955 3203 6693 9251
       2346 9078 6050 1025 2937 5536 9458 4809 7552 9827 3349
       2577 4876 3384 8140 5561 2640 9472 5679 9505 9114 8241
       2536 2518 9674 3989 9921 9846 7129 1934 7465 7733 6012
       7348 6699 3081)
for tw_seed in "${seeds[@]}"
do
    echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_100/difficulty_level_1/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_100/difficulty_level_2/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_100/difficulty_level_3/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_100/difficulty_level_4/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_100/difficulty_level_5/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_100/difficulty_level_6/  --silent -f
    echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_100/difficulty_level_7/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_100/difficulty_level_8/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_100/difficulty_level_9/  --silent -f
    echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_100/difficulty_level_10/ --silent -f
done

# seeds=(3058)
# for tw_seed in "${seeds[@]}"
# do
#     echo tw-make challenge tw-cooking-recipe1+take1+open+train               --seed $tw_seed --output games/kg/train_over/difficulty_level_1/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe1+take1+cook+open+train          --seed $tw_seed --output games/kg/train_over/difficulty_level_2/  --silent -f
#     echo tw-make challenge tw-cooking-recipe1+take1+cut+open+train           --seed $tw_seed --output games/kg/train_over/difficulty_level_3/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe1+take1+go6+open+train           --seed $tw_seed --output games/kg/train_over/difficulty_level_4/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe1+take1+go9+open+train           --seed $tw_seed --output games/kg/train_over/difficulty_level_5/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe1+take1+go12+open+train          --seed $tw_seed --output games/kg/train_over/difficulty_level_6/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe1+take1+cook+cut+open+train      --seed $tw_seed --output games/kg/train_over/difficulty_level_7/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe3+take3+go6+open+train           --seed $tw_seed --output games/kg/train_over/difficulty_level_8/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe3+take3+go6+cook+cut+open+train  --seed $tw_seed --output games/kg/train_over/difficulty_level_9/  --silent -f
#     # echo tw-make challenge tw-cooking-recipe3+take3+cook+cut+open+go12+train --seed $tw_seed --output games/kg/train_over/difficulty_level_10/ --silent -f
# done

####
# Post processing
##

# Remove .ni and .ulx files.
# rm -f games/kg/*/*/*.ulx
# rm -f games/kg/*/*/*.ni

# Replace tw-cooking-recipe1+take1+open-l3V9CZk9tPXLupdXIqKN and tw-cooking-recipe1+take1+open-eg2Qsaogs0vMip2aTKRv with
# rm games/kg/train_20/difficulty_level_1/tw-cooking-recipe1+take1+open-l3V9CZk9tPXLupdXIqKN.*
# mv games/kg/train_over/difficulty_level_1/tw-cooking-recipe1+take1+open-eg2Qsaogs0vMip2aTKRv.* games/kg/train_20/difficulty_level_1/

# Replace tw-cooking-recipe1+take1+cut+open-l3V9CZk9tPXLupdXIqKN with tw-cooking-recipe1+take1+cut+open-eg2Qsaogs0vMip2aTKRv
# rm -f games/kg/train_20/difficulty_level_3/tw-cooking-recipe1+take1+cut+open-l3V9CZk9tPXLupdXIqKN.*
# mv games/kg/train_over/difficulty_level_3/tw-cooking-recipe1+take1+cut+open-eg2Qsaogs0vMip2aTKRv.* games/kg/train_20/difficulty_level_3/

# Copy train_1 in train_20
# cp games/kg/train_1/difficulty_level_1/*  games/kg/train_20/difficulty_level_1/
# cp games/kg/train_1/difficulty_level_2/*  games/kg/train_20/difficulty_level_2/
# cp games/kg/train_1/difficulty_level_3/*  games/kg/train_20/difficulty_level_3/
# cp games/kg/train_1/difficulty_level_4/*  games/kg/train_20/difficulty_level_4/
# cp games/kg/train_1/difficulty_level_5/*  games/kg/train_20/difficulty_level_5/
# cp games/kg/train_1/difficulty_level_6/*  games/kg/train_20/difficulty_level_6/
# cp games/kg/train_1/difficulty_level_7/*  games/kg/train_20/difficulty_level_7/
# cp games/kg/train_1/difficulty_level_8/*  games/kg/train_20/difficulty_level_8/
# cp games/kg/train_1/difficulty_level_9/*  games/kg/train_20/difficulty_level_9/
# cp games/kg/train_1/difficulty_level_10/* games/kg/train_20/difficulty_level_10/

# Copy train_20 in train_100
# cp games/kg/train_20/difficulty_level_1/*  games/kg/train_100/difficulty_level_1/
# cp games/kg/train_20/difficulty_level_2/*  games/kg/train_100/difficulty_level_2/
# cp games/kg/train_20/difficulty_level_3/*  games/kg/train_100/difficulty_level_3/
# cp games/kg/train_20/difficulty_level_4/*  games/kg/train_100/difficulty_level_4/
# cp games/kg/train_20/difficulty_level_5/*  games/kg/train_100/difficulty_level_5/
# cp games/kg/train_20/difficulty_level_6/*  games/kg/train_100/difficulty_level_6/
# cp games/kg/train_20/difficulty_level_7/*  games/kg/train_100/difficulty_level_7/
# cp games/kg/train_20/difficulty_level_8/*  games/kg/train_100/difficulty_level_8/
# cp games/kg/train_20/difficulty_level_9/*  games/kg/train_100/difficulty_level_9/
# cp games/kg/train_20/difficulty_level_10/* games/kg/train_100/difficulty_level_10/

# Make zip archive
# cd games/; zip -r rl.0.2.zip kg/; cd ..
