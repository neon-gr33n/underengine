function cutscene_end(){
	if instance_exists(obj_ow_player) 
	{
		obj_ow_player.canMove = true; 
		obj_ow_player.image_speed = 1;
		if instance_exists(obj_ow_follower){
			var count = obj_ow_follower.record
		}
		var reversecount = 0;
		
		if instance_exists(obj_ow_follower){
			for (i=count;i>-1;i--)
			{
				obj_ow_player.pos_x[i] = obj_ow_follower.x + (((PLAYER.x - obj_ow_follower.x)/count)*reversecount)
				obj_ow_player.pos_y[i] = obj_ow_follower.y + (((PLAYER.y - obj_ow_follower.y)/count)*reversecount)
				reversecount += 1;
			}
		}
		
	}
	
	if instance_exists(obj_ow_follower) {obj_ow_follower.image_speed = 1;}
	instance_destroy(obj_cutscene_handler);
	instance_destroy(obj_cutscene_handler_passive);
}