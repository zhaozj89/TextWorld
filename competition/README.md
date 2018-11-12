# TextWorld Competition

## Should we run the agent multiple times on a same game?

### Pros

- score could better reflects the variance in an agent decision

### Cons

- take more time
- needs to make sure we reload the agent each time to avoid information leak across replays
  actually, the agent code might hide information on disk :(. So, reloading the whole docker.



## Do we allow the agent to play the game again when it dies/wins and there are still steps left?

### Pros

- agents can learn from their mistake

### Cons

- there is no reason why this should be needed since there is no traps in the test games





## Goals of the competition

- Zero-shot generalization to unseen recipes/layouts/words

## Stats about the games to report

- Min/Max/Avg #steps to win any games? (Which ones?)





# Motivation

From [Courville2018](https://openreview.net/pdf?id=HkezXnA9YX)
"""
A good model [agent] should be able to reason about all possible object combinations
despite being trained on a very small subset of them.
"""


Location dependent actions:
 - Prepare meal
 - Cook food: either kitchen (stove/oven) or backyard(BBQ)

What do we want to test: generalization to unseen recipes

To make sure of that, the unseen recipes are either composed of:
[new combinations]
- unseen food processing (e.g. never had to chopped a carrot)
- unseen adj-noun pairs (e.g. never seen a "red potato" before but have seen "red" and "potato")

[new words]
- unseen noun (e.g. never seen "watermelon")
- unseen adj (e.g. never seen "sweet" in "sweet potato")
- unseen adj-noun (e.g. never seen both "sweet" and "corn" in "sweet corn")
