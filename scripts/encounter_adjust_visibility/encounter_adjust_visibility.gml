function encounter_adjust_visiblity(slot_index, is_visible){
	///@desc Allows us to control the visibility of an enemy object
	///(best used for creative attacks that in involve the enemy directly going into the box e.g rolling, jumping on it, etc.)
	///@arg target
	///@arg visible
	var target = global.enc_slot[slot_index];
	with(target){
		visible = is_visible;
	}
}