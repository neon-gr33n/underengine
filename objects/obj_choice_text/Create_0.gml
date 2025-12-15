depth = -9991;
instance_create(x,y,obj_text_box)

player_freeze()

displayChoiceLabel = "* Get dunked on?"
displayChoices = [loc_gettext("choice.yes"),loc_gettext("choice.no")];
outputChoices = [function(){},function(){}];

displayChoiceOffsetX = [165, 165 + 190]
displayChoiceOffsetY = 332 + 35

choiceSelection = 0;

position = 0;
if !soul_exists()
	instance_create(PLAYER1.x,PLAYER1.y,HEART)
HEART.returning=0

global.soulChosen = 0;
global.realSoulChoice = false; // prevent dialogue from activating before choice is actually made 