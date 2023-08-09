depth = -9991;
instance_create(x,y,obj_text_box)

PLAYER1.state = PLAYER1.stateCutsceneStasis();

displayChoiceLabel = "* Get dunked on?"
displayChoices = ["Yes","No"];

displayChoiceOffsetX = [180-70, 180 + 220 + 70 + 95]
displayChoiceOffsetY = 332 + 35

choiceSelection = 0;

global.soulChosen = 0;
global.realSoulChoice = false; // prevent dialogue from activating before choice is actually made 