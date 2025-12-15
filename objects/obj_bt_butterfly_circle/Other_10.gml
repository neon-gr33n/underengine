/// @desc Turn Preperation Start
event_inherited();

BOARD.target_width = 250;
BOARD.target_height = 250;

_timer = 300;

HEART.state = HEART.stateSoulMovement();