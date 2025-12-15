/// @desc Turn Preparation Start
_timer = 350;

// Adjust BOARD size for gentle rain (taller for falling space)
if (instance_exists(BOARD)) {
    BOARD.target_width = 300
    BOARD.target_height = 140;
}

HEART.state = HEART.stateSoulMovement();