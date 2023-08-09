function cutscene_set_npc_dir(){
	///@arg target
	///@arg dir
	var target = argument0, _dir = argument1
	with (target) {
		dir = _dir;
	}
	cutscene_end_action()
}