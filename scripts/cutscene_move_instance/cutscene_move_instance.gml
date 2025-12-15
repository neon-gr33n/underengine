
function cutscene_move_instance(){
///@description cutscene_move_instance
///@arg obj
///@arg x
///@arg y
///@arg relative?
///@arg spd
///@arg facing

var obj = argument0, relative = argument3, spd = argument4, facing = argument5;

if(x_dest == -1){if(!relative){x_dest = argument1; y_dest = argument2;}
else {x_dest = obj.x + argument1; y_dest = obj.y + argument2;}}

var xx = x_dest;
var yy = y_dest;

with(obj)
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

if variable_instance_exists(obj,"dir")
{
	with(obj) 
	{
		if obj == PLAYER1 {
			remdir[0]=facing
		} else {
			dir=facing;	
		}
	}
}

if variable_instance_exists(obj, "npc_moving")
{
	with(obj)
	{
		npc_moving = true
	}
}

if variable_instance_exists(obj, "party_moving")
{
	with(obj)
	{
		party_moving = true
	}
}

}