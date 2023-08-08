function cutscene_wait_for_dialogue(){
	///@description cutscene_wait_for_dialogue

	timer++;
	if !instance_exists(obj_text_box) {timer = 0;  cutscene_end_action() ;}
}