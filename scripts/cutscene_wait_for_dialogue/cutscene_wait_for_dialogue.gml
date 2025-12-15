function cutscene_wait_for_dialogue(){
	///@description cutscene_wait_for_dialogue

	timer++;
	if (obj_text_writer.dialogue.dialogueText==""&&obj_text_writer.typist.get_state()==1) {timer = 0;  cutscene_end_action() ;}
}