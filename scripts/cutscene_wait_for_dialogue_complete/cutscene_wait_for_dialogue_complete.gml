function cutscene_wait_for_dialogue_complete(){
	///@description cutscene_wait_for_dialogue

	timer++;
	if instance_exists(obj_text_writer)&&obj_text_writer.typist.get_state()==1 {timer = 0;  cutscene_end_action() ;}
}