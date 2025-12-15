///@desc Turn Preperation Start
// Inherit the parent event
event_inherited();

_timer = 450; // Longer duration for crying effect

// Set board size
BOARD.target_width = 300;
BOARD.target_height = 250;

HEART.state = HEART.stateSoulMovement();