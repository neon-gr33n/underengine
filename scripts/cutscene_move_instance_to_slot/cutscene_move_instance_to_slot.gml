
function cutscene_move_instance_to_slot(){
///@description cutscene_move_instance
///@arg obj
///@arg slot
///@arg spd

var obj = argument0, spd = argument1
    
if(x_dest == -1){x_dest = obj_ow_party.remx[25*argument1]; y_dest = obj_ow_party.remy[25*argument1];}
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
		dir = round(point_direction(x,y,xx,yy)/90)*90
		
	}
}

if variable_instance_exists(obj, "npc_moving")
{
	with(obj)
	{
		npc_moving = true
	}
}

}