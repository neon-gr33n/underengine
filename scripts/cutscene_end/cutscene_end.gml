function cutscene_end(){
	global._interact = noone;
	if instance_exists(PLAYER1){
		player_unfreeze()
		PLAYER1.image_speed = 1;
		PLAYER1.dir = "undefined"
	}
	instance_destroy(obj_cutscene_handler);
	instance_destroy(obj_cutscene_handler_passive);
}