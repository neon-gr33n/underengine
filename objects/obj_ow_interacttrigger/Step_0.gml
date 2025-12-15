//if !variable_instance_exists(self,"persistant") {persistant = false}

//if collision_line(PLAYER1.x,PLAYER1.y-10,PLAYER1.x+lengthdir_x(preferredDistance,PLAYER1.direction),PLAYER1.y-10+lengthdir_y(preferredDistance,PLAYER1.direction),id,true,false) && input.action_pressed && canInteract && !inInteraction && !instance_exists(obj_cutscene_handler)
//{
//	create_cutscene(scene_info);
//	inInteraction = true; // We're now interacting
//	if persistant = false {instance_destroy();}
//}

//if !instance_exists(obj_cutscene_handler) {
//	inInteraction = false;
//}


if collision_line(PLAYER1.x,PLAYER1.y-10,PLAYER1.x+lengthdir_x(preferredDistance,PLAYER1.direction),PLAYER1.y-10+lengthdir_y(preferredDistance,PLAYER1.direction),id,true,false) && input.action_pressed && canInteract && !inInteraction && !instance_exists(obj_cutscene_handler)
{
	switch flag_func {
		case "exists":
			if !global.flags[? flag] {
				create_cutscene(scene_info);
				inInteraction = true; // We're now interacting
				global.flags[? flag]=1
			}
		break;
		
		case "increment":
			create_cutscene(scene_info[global.flags[? flag]]);
			inInteraction = true; // We're now interacting
			if global.flags[? flag] < array_length(scene_info)-1
				global.flags[? flag]++
		break;
		
		case "manual":
			create_cutscene(scene_info[global.flags[? flag]]);
			inInteraction = true; // We're now interacting
		break;
		
		default:
			create_cutscene(scene_info);
			inInteraction = true; // We're now interacting
		break;
	}
}

if !instance_exists(obj_cutscene_handler) {
	inInteraction = false;
}
