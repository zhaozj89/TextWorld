import json
import random
import fictionary

# Fix seed to be reproducible.
random.seed(1234)

with open("./vocab.json") as f:
    vocab = json.load(f)
    words = vocab["actions"] + vocab["words"]

# Genreate fake words.
fake_words = fictionary.words(
    num_words=len(words),
    min_length=4,
    max_length=8,
    dictionary=fictionary.DICT_ALL_KEY,
)

new_mapping = dict(zip(words, fake_words))

fake_words_mapping = {"actions": {}, "words": {}}
for k in vocab["actions"]:
    fake_words_mapping["actions"][k] = new_mapping[k].title() if k.istitle() else new_mapping[k]

for k in vocab["words"]:
    fake_words_mapping["words"][k] = new_mapping[k].title() if k.istitle() else new_mapping[k]

with open("fake_words_mapping.json", "w") as f:
    json.dump(fake_words_mapping, f, indent=2, sort_keys=True)
