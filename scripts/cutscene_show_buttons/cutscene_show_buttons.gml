///@desc Hides ALL battle buttons-
/// NOTE: Use "cutscene_show_button" instead if you want to only adjust a single button
function cutscene_show_buttons(){
	///@arg visible?
	with(obj_parent_battle_button){
		instance_destroy()
	}
	cutscene_end_action()
}