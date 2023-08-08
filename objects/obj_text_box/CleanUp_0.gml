obj_ow_player.canMove = true;
if global._interacting != noone && global._interacting.canInteract == false {
	timer_setup("s",obj_timer_clear_interact,1);
}