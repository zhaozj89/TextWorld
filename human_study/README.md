
# Human study about playing text-based games

## What we want to show

- Which priors do we need to remove to make the Human perfomance comparable to an RL agent?
- Which priors are more important?

## What are the prior embeded into Human brings to a new task?

- object permenance

## Standard games

We are going to use games from the First TextWorld Competition. The goal in those games is to find the recipe, read it, gather the ingredient, and process them according to the recipe.

- Nb. rooms: 12
- Recipe: 3 ingredients
- Doors/containers are initially closed
- Player will have to slice/dice/chop and cook ingredients.

Questions:

- Do we limit the number of moves or simply have time limit?

## Study methodology

Definitions:

- *entity*: any interactable object, a room or a direction.
- *fake word*: a sequence of characters that looks like English

Fake words should be consistent across the games played by one annotator.

Questions:

- how much time per game?
- how much time overall?
- how many games per annotator?

## Variations

Here we described the pertubations/treatments we are going to apply on standard games.

### Highlighting entities

- *Motivation:* speed up experiments by reducing the cognitive load.
- *Expectation:* the player will spend less time per screen since parsing the text for relevant should be easier.
- *RL setting:* this corresponds in providing the list of entities relevant to the game.

### Replacing all entity names with made-up words

- *Motivation:* remove prior information Humans have about the affordances of an entity based on its name.
- *Expectation:* the player will have to spend more commands trying to figure out what entity corresponds to a knife when cutting is needed, and what entity corresponds to a heat source when cooking is needed.
- *RL setting:* this corresponds to not using pre-trained word embeddings for the entities.

### Removing context around entities

- *Motivation:* check if the context's words are essential to understand it when entities are provided.
- *Expectation:* I believe Human can infer a lot from the entities.
- *RL setting:*

### Replacing the names of the commands

*The list of commands will still be visible in the help but without any explanation.

- *Motivation:* remove prior Humans have about the effect commands have.
- *Expectation:* players will have to spend more time understanding the feedback information in order to figure out what happen and what a particular command does.
- *RL setting:* this corresponds to not using pre-trained word embeddings for the words found in text commands.

### Random order of words in sentence

*I'm not sure about this one. Unless we have a smart way of randomizing the words so it creates ambiguity, I don't see the point in doing that.

- *Motivation:*
- *Expectation:*
- *RL setting:*

### Player force to make a map on paper vs. a mental one

- *Motivation:*
- *Expectation:* human with access to paper to draw a map will be more efficient at exploring the world and coming back to previously visited room.
- *RL setting:* use explicit memory (we the hope it will be used to keep track of the rooms layout).

### Replacing characters or inverting characters within words

*Since we are focusing on word-level language model, I don't think it makes sense to change characters.

## Information to provide/ask the annotators

- Introduction/Tutorial to text-based games?

- The nature of the experiment

  - Quest oriented

- What are the limitation:

  - Moves (less moves payoff, with a cliff first X moves are "free")
  - Time (should fix)
  - Deaths

- What information we are going to capture during playthrough:

  - Command
  - Time on each "screen"

Outro:

- Words association

### From a discussion with Akshay Krishnamurthy

Relation to ICML paper [Investigating Human Priors for Playing Video Games][1]. We should replace all words with made-up ones.
Our experiments might be able to show that human priors are more "important" in text-based games than video games. Reversely, RL agents have to learn more to be able to performance decently on text-based games.

For instance, even if we change the textures, human can still easily locate their agent since only a small part of the screen might change in response to an action. On top of that, since there are only a few actions a human can try, the mapping phase (action-reaction) is easier and faster to build.

Adam: maybe translating the words to a new language would be better as it would keep some structure.

## TODO

- Ask Emery to test the games to get some sense of the duration.

[1]: https://arxiv.org/pdf/1802.10217.pdf
