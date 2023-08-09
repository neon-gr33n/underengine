function cutscene_set_npc_idle(){
	///@arg target
	var target = argument0;
	with (target) {
		npc_moving = false;
	}
	cutscene_end_action()
}