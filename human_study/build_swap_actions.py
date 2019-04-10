import json
import random

# Fix seed to be reproducible.
random.seed(1234)

with open("./vocab.json") as f:
    vocab = json.load(f)
    words = vocab["actions"] + vocab["words"]

fake_words_mapping = {"actions": {}, "words": {}}
actions = list(vocab["actions"])
random.shuffle(actions)
for k, new_action in zip(vocab["actions"], actions):
    fake_words_mapping["actions"][k] = new_action.title() if k.istitle() else new_action.lower()

for k in vocab["words"]:
    fake_words_mapping["words"][k] = k

with open("swap_words_mapping.json", "w") as f:
    json.dump(fake_words_mapping, f, indent=2, sort_keys=True)
