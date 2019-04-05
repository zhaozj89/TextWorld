Version 1/190315 of the Fake Language by TextWorld begins here.

Use Fake Language translates as (- Constant Fake Language; -).

Part 1 - Overwriting commands

Section 1/0 - Declare new verbs

To {open} is a verb.
To {close} is a verb.
To {take} is a verb.
To {drop} is a verb.
To {put} is a verb.
To {insert} is a verb.
To {look} is a verb.
To {lock} is a verb.
To {unlock} is a verb.
To {inventory} is a verb.
To {examine} is a verb.
To {eat} is a verb.
To {drink} is a verb.
To {carry} is a verb.
To {go} is a verb.
To {mix} is a verb.

Section 1/1 - Declare new command aliases

Understand the command "{open}" as "open".
Understand the command "{close}" as "close".
Understand the command "{take}" as "take".
Understand the command "{drop}" as "drop".
Understand the command "{put}" as "put".
Understand the command "{insert}" as "insert".
Understand the command "{look}" as "look".
Understand the command "{lock}" as "lock".
Understand the command "{unlock}" as "unlock".
Understand the command "{inventory}" as "inventory".
Understand the command "{examine}" as "examine".
Understand the command "{eat}" as "eat".
Understand the command "{drink}" as "drink".
Understand the command "{go}" as "go".
Understand the command "{mix}" as "mix".

Section 1/2 - Forget old commands

Understand the command "open", "unwrap", "uncover" as something new.
Understand the command "close", "shut", "cover" as something new.
Understand the command "take", "carry", "hold" as something new.
Understand the command "get", "pick" as something new.
Understand the command "drop", "throw", "discard" as something new.
Understand the command "put" as something new.
Understand the command "insert" as something new.
Understand the command "inventory", "inv", "i" as something new.
Understand the command "look", "l" as something new.
Understand the command "examine", "x", "watch", "describe", "check" as something new.
Understand the command "eat" as something new.
Understand the command "drink", "swallow", "sip" as something new.
Understand the command "go", "walk", "run" as something new.
Understand the command "enter" as something new.
Understand the command "mix" as something new.
Understand the command "lock" as something new.
Understand the command "unlock" as something new.


Part 2 - Overwriting messages

Section 2/0 - Success messages

The reveal any newly visible interior rule response (A) is "[We] [{open}] [the noun], revealing ".
The standard report opening rule response (A) is "[We] [{open}] [the noun].".
The standard report opening rule response (B) is "[The actor] [{open}] [the noun].".
The standard report opening rule response (C) is "[The noun] [{open}].".
The standard report closing rule response (A) is "[We] [{close}] [the noun].".
The standard report closing rule response (B) is "[The actor] [{close}] [the noun].".
The standard report closing rule response (C) is "[The noun] [{close}].".
The standard report taking rule response (A) is "You [{take}] [the noun].".
The standard report taking rule response (B) is "[The actor] [{take}] [the noun].".
The standard report dropping rule response (A) is "[The actor] [{drop}] [the noun].".
The standard report dropping rule response (B) is "[The actor] [{drop}] [the noun].".
The standard report inserting rule response (A) is "[The actor] [{put}] [the noun] into [the second noun].".
The standard report putting rule response (A) is "[The actor] [{put}] [the noun] on [the second noun].".
The standard report eating rule response (A) is "[We] [{eat}] [the noun]. Not bad.".
The standard report eating rule response (B) is "[The actor] [{eat}] [the noun].".
The print empty inventory rule response (A) is "[We] [are] [present participle of the verb {carry}] nothing.".
The print standard inventory rule response (A) is "[We] [are] [present participle of the verb {carry}]:[line break]".

Section 2/1 - Error messages

The can't lock what's open rule response (A) is "First [we] [would have] to {close} [the noun].".
The can't open unless openable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] {open}.".
The can't open what's already open rule response (A) is "[regarding the noun][They're] already {open}.".
The can't close unless openable rule response (A) is "[regarding the noun][They] [aren't] something [we] [can] {close}.".
The can't close what's already closed rule response (A) is "[regarding the noun][They're] already {close}.".
The can't insert something into itself rule response (A) is "[We] [can't {put}] something inside itself.".
The can't put something on itself rule response (A) is "[We] [can't {put}] something on top of itself.".
The can't put onto what's not a supporter rule response (A) is "{put}ing things on [the second noun] [would achieve] nothing.".
The block drinking rule response (A) is "[There's] nothing suitable to [{drink}] here.".

Section 2/2 - Clarification messages

The can't go through closed doors rule response (A) is "(first [present participle of the verb {open}] [the door gone through])[command clarification break]".
The use player's holdall to avoid exceeding carrying capacity rule response (A) is "([present participle of the verb {put}] [the transferred item] into [the current working sack] to make room)[command clarification break]".


Part 3 - Overwriting TextWorld stuff

The can't go through door rule response (A) is "[We] have to [{open}] the [blocking door] first.".

To {cut} is a verb.
To {slice} is a verb.
To {dice} is a verb.
To {chop} is a verb.
Understand the command "{slice}" as "slice".
Understand the command "{dice}" as "dice".
Understand the command "{chop}" as "chop".

Understand the command "slice" as something new.
Understand the command "chop" as something new.
Understand the command "dice" as something new.
Understand the command "cut" as something new.

The generic cut not allowed rule response (A) is "You need to specify how you want to [{cut}] [the noun]. Either [{slice}], [{dice}], or [{chop}] it.".
The can only cut cuttable food rule response (A) is "Can only [{cut}] cuttable food.".
The can only cut with a sharp object rule response (A) is "[Present participle of the verb {cut}] something requires something sharp.".
The slicing stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The slicing stuff rule response (B) is "[We] [{slice}] the [food item].".
The dicing stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The dicing stuff rule response (B) is "[We] [{dice}] the [food item].".
The chopping stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The chopping stuff rule response (B) is "[We] [{chop}] the [food item].".

To say (v - type of cutting):
	if v is uncut:
		say "non-coupe";
	else if v is chopped:
		say "hache";
	else if v is sliced:
		say "tranche";
	else if v is diced:
		say "cube";

To {cook} is a verb.
Understand the command "{cook}" as "cook".
Understand the command "cook" as something new.
The cooking requires a source of heat rule response (A) is "[Present participle of the verb {cook}] requires a source of heat.".
The cook only cookable things rule response (A) is "Can only [infinitive of the verb {cook}] food.".

To {burn} is a verb.
The cook carried food rule response (A) is "[We] [past participle of the verb {burn}] the [food item]!"

To {fry} is a verb.
To {roast} is a verb.
To {grill} is a verb.
The cook carried food rule response (B) is "[We] [{fry}] the [food item]."
The cook carried food rule response (C) is "[We] [{roast}] the [food item]."
The cook carried food rule response (D) is "[We] [{grill}] the [food item]."

The mentioned the type of cooking rule response (A) is "cru ".
The mentioned the type of cooking rule response (B) is "brule ".

To say Present participle of (V - verb):
	say "[present participle of V]" in title case.

To say (v - type of cooking):
	if v is roasted:
		say "roti";
	else if v is grilled:
		say "grille";
	else if v is fried:
		say "frite";

The taking something from the ground rule response (A) is "[The actor] [{take}] [the noun] from the ground.".
The taking something from somewhere rule response (A) is "[The actor] [{take}] [the noun] from [the previous locale].".
The dropping something on the ground rule response (A) is "[The actor] [{drop}] [the noun] on the ground.".
The you need to take it first rule response (B) is "[We] need to [{take}] the [target] first.".

To say adjective of (V - a verb):
	if the verb {open} is V:
		say "[past participle of the verb {open}]";
	else if the verb {close} is V:
		say "[past participle of the verb {close}]";
	else if the verb {lock} is V:
		say "[past participle of the verb {lock}]";


Part 4 - Display the list of commands

Carry out displaying help message (this is the new displaying help message rule):
	say "[fixed letter spacing]Available commands:[line break]";
	say "  {chop} ... with ...   [line break]";
	say "  {close} ...           [line break]";
	say "  {cook} ... with ...   [line break]";
	say "  {dice} ... with ...   [line break]";
	say "  {drink} ...           [line break]";
	say "  {drop} ...            [line break]";
	say "  {eat} ...             [line break]";
	say "  {examine} ...         [line break]";
	say "  {go} ...              [line break]";
	say "  {insert} ... into ... [line break]";
	say "  {inventory}           [line break]";
	say "  {lock} ... with ...   [line break]";
	say "  {look}                [line break]";
	say "  {mix} ...             [line break]";
	say "  {open} ...            [line break]";
	say "  {put} ... on ...      [line break]";
	say "  {slice} ... with ...  [line break]";
	say "  {take} ... from ...   [line break]";
	say "  {take} ...            [line break]";
	say "  {unlock} ... with ... [line break]";
	stop.

The new displaying help message rule is listed first in carry out displaying help message.

Part 5 - Disabling all remaining English commands

Understand the command "stand" as something new.
Understand the command "remove" as something new.
Understand the command "shed" as something new.
Understand the command "doff" as something new.
Understand the command "disrobe" as something new.
Understand the command "wear" as something new.
Understand the command "don" as something new.
Understand the command "give" as something new.
Understand the command "pay", "offer", "feed" as something new.
Understand the command "show", "present", "display" as something new.
Understand the command "consult" as something new.
Understand the command "enter", "cross" as something new.
Understand the command "sit" as something new.
Understand the command "exit", "leave", "out" as something new.
Understand the command "read" as something new.
Understand the command "search" as something new.
Understand the command "wave" as something new.
Understand the command "set", "adjust" as something new.
Understand the command "pull", "drag" as something new.
Understand the command "push", "move", "shift", "clear", "press" as something new.
Understand the command "turn", "rotate", "twist", "unscrew", "screw" as something new.
Understand the command "switch" as something new.
Understand the command "attack", "break", "smash", "hit", "fight", "torture", "wreck" as something new.
Understand the command "crack", "destroy", "murder", "kill", "punch" as something new.
Understand the command "answer", "say", "shout", "speak" as something new.
Understand the command "tell" as something new.
Understand the command "ask" as something new.
Understand the command "sleep", "nap" as something new.
Understand the command "climb", "scale" as something new.
Understand the command "buy", "purchase" as something new.
Understand the command "squeeze", "squash" as something new.
Understand the command "swing" as something new.
Understand the command "wake", "awake", "awaken" as something new.
Understand the command "kiss" as something new.
Understand the command "embrace", "hug" as something new.
Understand the command "think" as something new.
Understand the command "smell", "sniff" as something new.
Understand the command "listen", "hear" as something new.
Understand the command "taste" as something new.
Understand the command "touch", "feel" as something new.
Understand the command "rub", "shine", "polish", "sweep", "clean", "dust", "wipe" and "scrub" as something new.
Understand the command "tie", "attach", "fasten" as something new.
Understand the command "burn", "light" as something new.
Understand the command "jump", "skip", "hop" as something new.
Understand the command "verify" as something new.
Understand the command "version" as something new.
Understand the command "script", "transcript" as something new.
Understand the command "superbrief", "short" as something new.
Understand the command "verbose", "long" as something new.
Understand the command "brief", "normal" as something new.
Understand the command "nouns", "pronouns" as something new.
Understand the command "notify" as something new.

The Fake Language end here.