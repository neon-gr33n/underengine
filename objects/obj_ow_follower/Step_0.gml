if(following){
	x = obj_ow_player.pos_x[record]
	y = obj_ow_player.pos_y[record]

	var inputMagnitude = 0;

	if x != xprevious or y != yprevious {inputMagnitude = 1;}

	
	if (inputMagnitude != 0)
	{
		direction = point_direction(x,y,obj_ow_player.x,obj_ow_player.y);
		sprite_index = spriteFollowerMove;
	}

	else {sprite_index = spriteFollowerIdle;}

	var _old_sprite = sprite_index;

	if (_old_sprite != sprite_index) local_frame = 0;

	player_animate_sprite();

	depth = -2000-y;
}