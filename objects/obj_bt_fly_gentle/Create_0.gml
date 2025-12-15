/// @desc Init
event_inherited()

_stop_attacking = false;
_timer = 0;
_fly_count = 0;
_board = instance_find(BOARD, 0);

event_user(0);

alarm[0] = 15;
alarm[1] = 8;