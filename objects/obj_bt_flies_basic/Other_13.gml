/// @desc Turn End
if (instance_exists(obj_bt_butterfly_circle)) with (obj_bt_butterfly_circle){
	event_user(3);
}
instance_destroy(obj_bullet_fly)
battle_set_menu_state("menuBegin")
BOARD.reset();
instance_destroy();