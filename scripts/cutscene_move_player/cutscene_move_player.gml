function cutscene_move_player(){
///@description cutscene_move_player
///@arg x
///@arg y
///@arg relative?
///@arg spd
///@arg facing

	var relative = argument2, spd = argument3, facing = argument4;

	if(x_dest == -1){if(!relative){x_dest = argument0; y_dest = argument1;}
	else {x_dest = PLAYER1.x + argument0; y_dest = PLAYER1.y + argument1;}}

	var xx = x_dest;
	var yy = y_dest;

	with(PLAYER1)
	{ 
		if(point_distance(x,y,xx,yy) >= spd)
		{
			var _dir = point_direction(x,y,xx,yy);
			var ldirx = lengthdir_x(spd,_dir);
			var ldiry = lengthdir_y(spd,_dir);
			inputdirection = point_direction(x,y,xx,yy); 
			inputmagnitude = 2;
			x += ldirx;
			y += ldiry;

		}
		else
		{
			x = xx;
			y = yy;
			inputmagnitude = 0;
			with(other) {x_dest = -1; y_dest = -1; cutscene_end_action();}
		}
	}

	PLAYER1.dir=facing

	if variable_instance_exists(PLAYER1, "party_moving")
	{
		with(PLAYER1)
		{
			party_moving = true
		}
	}
}