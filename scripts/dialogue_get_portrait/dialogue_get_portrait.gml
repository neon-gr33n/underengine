function dialogue_get_portrait(argument0,argument1){
	///@arg speaker
	///@arg portrait
	var speaker = argument0
	var portrait = argument1
	if global.characters[$ speaker].type == SPEAKER_TYPE.REGULAR && struct_exists(global.characters[$ speaker], "portraits") && instance_exists(obj_text_writer) with (obj_text_writer)
		dialoguePortrait = global.characters[$ speaker].portraits[$ portrait];
}