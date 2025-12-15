function cutscene_end_and_change_room()
{
	///@description cutscene_end_and_change_room
	///@arg room
	
	if instance_exists(obj_ow_party) {obj_ow_party.canMove = true; obj_ow_party.image_speed = 1;}
	//if instance_exists(obj_ow_follower) {obj_ow_follower.image_speed = 1;}
	
	room = argument0;
	
	instance_destroy(obj_cutscene_handler);
	instance_destroy(obj_cutscene_handler_passive);
}