function cutscene_end(){
	global._interact = noone;
	if instance_exists(PLAYER1) 
	{
		PLAYER1.state = PLAYER1.statePlayerMoveGeneric() 
		PLAYER1.image_speed = 1;
		if instance_exists(FOLLOWER){
			var count = FOLLOWER.record
		}
		var reversecount = 0;
		
		if instance_exists(FOLLOWER){
			for (i=count;i>-1;i--)
			{
				PLAYER1.pos_x[i] = FOLLOWER.x + (((FOLLOWER.x - FOLLOWER.x)/count)*reversecount)
				PLAYER1.pos_y[i] = FOLLOWER.y + (((FOLLOWER.y - FOLLOWER.y)/count)*reversecount)
				reversecount += 1;
			}
		}
		
	}
	
	if instance_exists(FOLLOWER) {FOLLOWER.image_speed = 1;}
	instance_destroy(obj_cutscene_handler);
	instance_destroy(obj_cutscene_handler_passive);
}