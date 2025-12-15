if !variable_instance_exists(self,"persistant") {persistant = false}
with(PLAYER1) {
	var _si = sprite_index;
	var _ii = image_index;
	
	sprite_index=spr_frisk_hitbox;
	image_index=0;
}

if place_meeting(x, y, PLAYER1) {       
    switch flag_func {
        case "exists":
            if !global.flags[? flag] {
                create_cutscene(scene_info);
                inInteraction = true;
                global.flags[? flag] = 1;
            }
            break;
            
        case "increment":
            create_cutscene(scene_info[global.flags[? flag]]);
            inInteraction = true;
            if global.flags[? flag] < array_length(scene_info) - 1 {
                global.flags[? flag]++;
            }
            break;
            
        case "manual":
            create_cutscene(scene_info[global.flags[? flag]]);
            inInteraction = true;
            break;
            
        default:
            create_cutscene(scene_info);
            inInteraction = true;
            break;
    }
}

with(PLAYER1) {
	sprite_index=_si;
	image_index=_ii;
}