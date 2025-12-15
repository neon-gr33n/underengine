/// @desc Turn Preparation Start
_timer = 350;

if (!instance_exists(obj_battle_enemy_whimsun) || obj_battle_enemy_whimsun.spared == true){
BOARD.target_width = 150;
BOARD.target_height = 150;
}

HEART.state = HEART.stateSoulMovement();