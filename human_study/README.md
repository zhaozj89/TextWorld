
# Human study about playing text-based games

## Context
TODO: describe the standard setting of playing a text-based game (observation, goal, actions/comands, challenges, map drawing, priors).
TODO: talk about the high-level task of cooking/recipe.

We define *entity* as any interactable object, a room or a direction.

## Variations
Here we described the pertubations we are going to apply on a standard game.

### Highlight entities

*Motivation:* speed up experiments by reducing the cognitive load.
*Expectation:* the player will spend less time per screen since parsing the text for relevant should be easier.
*RL setting:* this corresponds in providing the list of entities relevant to the game.

### Replacing all entity names with made-up words

*Motivation:* remove prior information Humans have about the affordances of an entity based on its name.
*Expectation:* the player will have to spend more commands trying to figure out what entity corresponds to a knife when cutting is needed, and what entity corresponds to a heat source when cooking is needed.
*RL setting:* this corresponds to not using pre-trained word embeddings for the entities.

changing verbs in text
omitting words (verbs or nouns)
leaving blanks
replacing characters
inverting characters within words (I know human brain can read this ok)
random order of words in sentence
replacing the names of the commands (can still see the list of command from help but without explanation)
highlighting entity name in the text

- Change settings from room-to-room? I don't think that would work well.

Introduction/Tutorial to text-based games?

Limitation ?:
- Moves (less moves payoff, with a cliff first X moves are "free")
- Time (should fix)
- Deaths

Experiment
- Participants must finish a quest

What we want to monitor during playthrough:
- Command
- Time on each "screen"

Questions:
- What happens if a participant refreshes their browser? (Probably won't work)
- Is the tasks assignment managed by nodegame?
- Should the fake words be consistent across games? Yes (make sure they are unique)
- Always the same game? No

# Participants?
15$ / h
how much time?
how many games?

Ask Emery to test the games to get some sense of the duration.

Outro
- Words association

# What are the prior embeded into Human brings to a new task?
object permenance


## References

- https://arxiv.org/pdf/1802.10217.pdf