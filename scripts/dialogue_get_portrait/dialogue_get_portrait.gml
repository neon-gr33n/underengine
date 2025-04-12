function dialogue_get_portrait(){
	///@arg speaker
	///@arg portrait
	var speaker = argument0
	var portrait = argument1
	switch(speaker){
		case "sans":
			if instance_exists(obj_text_writer) with (obj_text_writer){	
				dialoguePortrait = ds_map_find_value(global.sans,portrait)
			}
		break;
	}
}