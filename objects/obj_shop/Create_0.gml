/// @description Init
_itemSelection = 0;
_choiceSelection = 0;
_menuSelection = 0;
_menuItemSelection = 0;
_menuSellSelection = 0;
_menuTalkSelection = 0;
currentState = "hub"
canSellItems = false; // If false, the player will NOT be allowed to sell items
showItemInfo = true;

__color = "c_white"
__outline_color = c_black;
__text="* Hello, traveler!#* How may I help you?"
__shopkeeperText="* Hello, traveler!#* How may I help you?"
__talkText="* What do you wish#\tto discuss?"
__exitText="* Come back anytime!"
dialogueKey = "";
dialogueIndex = 0;

talk_options = [
	"Say hello",
	"What to do here",
	"Town history",
	"Your life",
	"Exit"
]

talkDialogue = {
	OPT_A: [
		"* Hiya! Welcome#  to Snowdin!#* I can't remember#  the last time#  I saw a fresh#  face around here.",
		"* Where did you#  come from?#* The capital?"
	],
	OPT_B: [
		"* get out."
	],
	OPT_C: [
		"too lazy to add#more dialogue#sorry."
	],
	OPT_D: [
		"too lazy to add#more dialogue#sorry."
	]
}

talkPortraits = [
	["neutral", "neutral"],
	["evil"],
	["neutral"],
	["neutral"]
]

character = "shopkeep_1";

__buyText="* Thank you for#  your purchase!"
__buyFailText="* You don't#  have enough money#  for that!#* Come back later!"
__buyNoSpaceText="* You don't#  have enough space#  for that!#"
__sellNoItemsText="* You don't#  have any items#  to sell!"
__text2="What would#you like#to buy?"
_speed = 1.5;
_alpha = 1;
_voiceSound = global.characters[$ character].voice;
__font = global.characters[$ character].font;

typist = scribble_typist();
typist.in(_speed,0.1);
typewriter_state = 0;

typist2 = scribble_typist();
typist2.in(_speed,0.1);


selCursorYPos = 205;
selCursorXPos = 72;

buy_options = [
	"- Half Quiche",
	"- Quiche",
	"- Bad Apple",
	"- Faded Ribbon"
]

buy_type = [
	"CONSUMABLE",
	"CONSUMABLE",
	"CONSUMABLE",
	"ARMOR",
	""
]

buy_desc = [
	"Healing item",
	"Healing item",
	"Healing item",
	"Defensive charm",
	""
]

buy_bonus_a = [
	"+35 HP",
	"+40 HP",
	"+20 HP",
	"+3 DF",
	""
]

buy_bonus_b = [
	"+1 MP",
	"+3 MP",
	"+30 MP",
	""
]
add_options = [
	"HALF_QUICHE",
	"FULL_QUICHE",
	"BAD_APPLE",
	"FADED_RIBBON",
]

gold_options = [
	"25G",
	"35G",
	"45G",
	"15G",
	"Exit"
]

gold_cost = [
	25,
	35,
	45,
	15
]