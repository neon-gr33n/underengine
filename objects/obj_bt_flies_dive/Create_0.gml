/// @desc Init
event_inherited()

_stop_attacking = false;
_timer = 0;
_fly_count = 0
_fly_delay = 20;
_board = instance_find(obj_battle_box, 0);

event_user(0);

alarm[0] = 30;
alarm[1] = _fly_delay;