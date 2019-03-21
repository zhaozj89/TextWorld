import json
import random
import fictionary

# Fix seed to be reproducible.
random.seed(1234)

with open("./vocab.txt") as f:
    words = f.read().strip().split()

# Genreate fake words.
fake_words = fictionary.words(
    num_words=len(words),
    min_length=4,
    max_length=8,
    dictionary=fictionary.DICT_ALL_KEY,
)

fake_words_mapping = dict(zip(words, fake_words))

with open("fake_words_mapping.json", "w") as f:
    json.dump(fake_words_mapping, f, indent=2, sort_keys=True)

