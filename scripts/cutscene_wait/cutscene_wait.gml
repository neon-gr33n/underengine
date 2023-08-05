function cutscene_wait(){
	///@description cutscene_wait
	///@arg seconds

	timer++;
	if (timer >= argument0 * global.__ute_frame_rate) {timer = 0; cutscene_end_action();}
}