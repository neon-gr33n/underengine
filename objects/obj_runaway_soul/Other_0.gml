///@desc Get outta there!
mus_stop(global.currentmus[2]);
HEART.visible = false
fade_shape(spr_battle_soul_flee, 30)
instance_destroy(obj_battle_handler);
room_goto(flag_get(global.flags,"rm_r"));