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
To {examine} is a verb.
To {eat} is a verb.
To {drink} is a verb.
To {carry} is a verb.
To {go} is a verb.
To {prepare} is a verb.
[ To {mix} is a verb. ]

Section 1/1 - Declare temporary command aliases

Understand the command "open2" as "open".
Understand the command "close2" as "close".
Understand the command "take2" as "take".
Understand the command "drop2" as "drop".
Understand the command "put2" as "put".
Understand the command "insert2" as "insert".
Understand the command "look2" as "look".
Understand the command "lock2" as "lock".
Understand the command "unlock2" as "unlock".
Understand the command "examine2" as "examine".
Understand the command "eat2" as "eat".
Understand the command "drink2" as "drink".
Understand the command "go2" as "go".
[ Understand the command "mix2" as "mix". ]
Understand the command "prepare2" as "prepare".

Understand the command "slice2" as "slice".
Understand the command "dice2" as "dice".
Understand the command "chop2" as "chop".
Understand the command "cook2" as "cook".

Section 1/2 - Forget old commands

Understand the command "open", "unwrap", "uncover" as something new.
Understand the command "close", "shut", "cover" as something new.
Understand the command "take", "carry", "hold" as something new.
Understand the command "get", "pick" as something new.
Understand the command "drop", "throw", "discard" as something new.
Understand the command "put" as something new.
Understand the command "insert" as something new.
Understand the command "inv", "i" as something new.
Understand the command "look", "l" as something new.
Understand the command "examine", "x", "watch", "describe", "check" as something new.
Understand the command "eat" as something new.
Understand the command "drink", "swallow", "sip" as something new.
Understand the command "go", "walk", "run" as something new.
Understand the command "enter" as something new.
[ Understand the command "mix" as something new. ]
Understand the command "prepare" as something new.
Understand the command "lock" as something new.
Understand the command "unlock" as something new.

Understand the command "cook" as something new.
Understand the command "slice" as something new.
Understand the command "chop" as something new.
Understand the command "dice" as something new.
Understand the command "cut" as something new.

Understand the command "burn", "light" as something new.

Section 1/3 - Declare new command aliases

Understand the command "{open}" as "open2".
Understand the command "{close}" as "close2".
Understand the command "{take}" as "take2".
Understand the command "{drop}" as "drop2".
Understand the command "{put}" as "put2".
Understand the command "{insert}" as "insert2".
Understand the command "{look}" as "look2".
Understand the command "{lock}" as "lock2".
Understand the command "{unlock}" as "unlock2".
Understand the command "{examine}" as "examine2".
Understand the command "{eat}" as "eat2".
Understand the command "{drink}" as "drink2".
[ Understand the command "{mix}" as "mix2". ]
Understand the command "{prepare}" as "prepare2".
Understand the command "{slice}" as "slice2".
Understand the command "{dice}" as "dice2".
Understand the command "{chop}" as "chop2".
Understand the command "{cook}" as "cook2".

Section 1/4 - Remove dummy command aliases

Understand the command "open2" as something new.
Understand the command "close2" as something new.
Understand the command "take2" as something new.
Understand the command "drop2" as something new.
Understand the command "put2" as something new.
Understand the command "insert2" as something new.
Understand the command "look2" as something new.
Understand the command "lock2" as something new.
Understand the command "unlock2" as something new.
Understand the command "examine2" as something new.
Understand the command "eat2" as something new.
Understand the command "drink2" as something new.
Understand the command "slice2" as something new.
Understand the command "dice2" as something new.
Understand the command "chop2" as something new.
Understand the command "cook2" as something new.
[ Understand the command "mix2" as something new. ]
Understand the command "prepare2" as something new.

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
The standard report locking rule response (A) is "[We] [{lock}] [the noun].".
The standard report locking rule response (B) is "[The actor] [{lock}] [the noun].".
The standard report unlocking rule response (A) is "[We] [{unlock}] [the noun].".
The standard report unlocking rule response (B) is "[The actor] [{unlock}] [the noun].".

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
The block vaguely going rule response (A) is "You'll have to say which direction to {go} in.".
The can't go through undescribed doors rule response (A) is "[We] [can't {go}] that way.".
The can't go that way rule response (A) is "[We] [can't {go}] that way.".
The can't lock without a lock rule response (A) is "[regarding the noun][Those] [don't] seem to be something [we] [can] {lock}.".
The can't unlock without a lock rule response (A) is "[regarding the noun][Those] [don't] seem to be something [we] [can] {unlock}.".
The can't unlock what's already unlocked rule response (A) is "[regarding the noun][They're] [past participle of the verb {unlock}] at the [if story tense is present
				tense]moment[otherwise]time[end if].".
The can't open what's locked rule response (A) is "[regarding the noun][They] [seem] to be [past participle of the verb {lock}].".
The can't lock what's already locked rule response (A) is "[regarding the noun][They're] [past participle of the verb {lock}] at the [if story tense is present
				tense]moment[otherwise]time[end if].".

Section 2/2 - Clarification messages

The can't go through closed doors rule response (A) is "(first [present participle of the verb {open}] [the door gone through])[command clarification break]".
The use player's holdall to avoid exceeding carrying capacity rule response (A) is "([present participle of the verb {put}] [the transferred item] into [the current working sack] to make room)[command clarification break]".


Part 3 - Overwriting TextWorld stuff

[ The ingredients-topic is "{ingredients}". ]
The meal-topic is "{meal}".

The can't go through door rule response (A) is "[We] have to [{open}] the [blocking door] first.".

To {cut} is a verb.
To {slice} is a verb.
To {dice} is a verb.
To {chop} is a verb.

The generic cut not allowed rule response (A) is "You need to specify how you want to [{cut}] [the noun]. Either [{slice}], [{dice}], or [{chop}] it.".
The can only cut cuttable food rule response (A) is "Can only [{cut}] cuttable food.".
The can only cut with a sharp object rule response (A) is "[Present participle of the verb {cut}] something requires something sharp.".
The slicing stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The slicing stuff rule response (B) is "[We] [{slice}] the [food item].".
The dicing stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The dicing stuff rule response (B) is "[We] [{dice}] the [food item].".
The chopping stuff rule response (A) is "The [food item] has already been [past participle of the verb {cut}]".
The chopping stuff rule response (B) is "[We] [{chop}] the [food item].".

The taking something from the ground rule response (A) is "[The actor] [{take}] [the noun] from the ground.".
The taking something from somewhere rule response (A) is "[The actor] [{take}] [the noun] from [the previous locale].".
The dropping something on the ground rule response (A) is "[The actor] [{drop}] [the noun] on the ground.".
The you need to take it first rule response (B) is "[We] need to [{take}] the [target] first.".

[The before preparing meal rule response (A) is "Can only [infinitive of the verb {mix}] the ingredients in the [cooking location of the recipe].".]
The before preparing meal rule response (A) is "Can only [infinitive of the verb {prepare}] the {meal} in the [cooking location of the recipe].".
The before preparing meal rule response (B) is "The {recipe} requires [a ingredient].".
The before preparing meal rule response (C) is "The {recipe} requires [a ingredient].".
The before preparing meal rule response (D) is "The {recipe} requires [a ingredient].".
[The before preparing meal rule response (E) is "I don't know how to [infinitive of the verb {mix}] [topic understood].".]
The before preparing meal rule response (E) is "I don't know how to [infinitive of the verb {prepare}] [topic understood].".
The can't eat inedible raw food rule response (A) is "[We] [should {cook}] [the target] first.".
The can’t drink unless drinkable rule response (A) is "[We] [can't {drink}] [the noun].".
The report drinking rule response (A) is "[We] [{drink}] [the noun]. Not bad".
The report drinking rule response (B) is "[The person asked] just [{drink}] [the noun].".

To say (v - type of cutting):
	if v is uncut:
		say "{uncut}";
	else if v is chopped:
		say "[adjective of the verb {chop}]";
	else if v is sliced:
		say "[adjective of the verb {slice}]";
	else if v is diced:
		say "[adjective of the verb {dice}]";

To {cook} is a verb.
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

The mentioned the type of cooking rule response (A) is "{raw} ".
The mentioned the type of cooking rule response (B) is "[adjective of the verb {burn}] ".

To say Present participle of (V - verb):
	say "[present participle of V]" in title case.

To say (v - type of cooking):
	if v is roasted:
		say "[adjective of the verb {roast}]";
	else if v is grilled:
		say "[adjective of the verb {grill}]";
	else if v is fried:
		say "[adjective of the verb {fry}]";

To say adjective of (V - a verb):
	say "[past participle of V]";

Understand "{take} all" as taking all.
Understand "{take} each" as taking all.
Understand "{take} everything" as taking all.

Part 4 - Display the list of commands

Carry out displaying help message (this is the new displaying help message rule):
	say "[fixed letter spacing]Available commands:[line break]";
	say "  inventory             [line break]";
	say "  {chop} ... with ...   [line break]";
	say "  {close} ...           [line break]";
	say "  {cook} ... with ...   [line break]";
	say "  {dice} ... with ...   [line break]";
	say "  {drink} ...           [line break]";
	say "  {drop} ...            [line break]";
	say "  {eat} ...             [line break]";
	say "  {enter} ...           [line break]";
	say "  {examine} ...         [line break]";
	say "  {go} ...              [line break]";
	say "  {insert} ... into ... [line break]";
	say "  {lock} ... with ...   [line break]";
	say "  {look}                [line break]";
	[ say "  {mix} ...             line break"; ]
	say "  {prepare} ...         [line break]";
	say "  {open} ...            [line break]";
	say "  {put} ... on ...      [line break]";
	say "  {slice} ... with ...  [line break]";
	say "  {take} ... from ...   [line break]";
	say "  {take} ...            [line break]";
	say "  {unlock} ... with ... [line break]";
	stop.

The new displaying help message rule is listed first in carry out displaying help message.

Part 5 - Replacing compass directions

Understand "s", "south" as a mistake ("That's not a verb I recognise.").
Understand "n", "north" as a mistake ("That's not a verb I recognise.").
Understand "w", "west" as a mistake ("That's not a verb I recognise.").
Understand "e", "east" as a mistake ("That's not a verb I recognise.").
Understand "sw", "southwest" as a mistake ("That's not a verb I recognise.").
Understand "se", "southeast" as a mistake ("That's not a verb I recognise.").
Understand "nw", "northwest" as a mistake ("That's not a verb I recognise.").
Understand "ne", "northeast" as a mistake ("That's not a verb I recognise.").
Understand "u", "up" as a mistake ("That's not a verb I recognise.").
Understand "d", "down" as a mistake ("That's not a verb I recognise.").
Understand "in", "out" as a mistake ("That's not a verb I recognise.").

Understand "{go} [direction]" as going.


Part 6 - Disabling all remaining English commands

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