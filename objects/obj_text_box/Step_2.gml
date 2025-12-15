global.lang_ls = "100%"
if(WRITER.typist.get_state()==1)  && room != rm_dialog_tester
{
	if input.action_pressed {
		if is_array(WRITER.dialogue.dialogueText) && WRITER.t_c+1<array_length(WRITER.dialogue.dialogueText) {
			WRITER.t_c++;
		} else
			WRITER.dialogue.dialogueText = "";
	}
	if !instance_exists(obj_cutscene_handler)||obj_cutscene_handler.scene==_scene&&(obj_cutscene_handler.scene_info[obj_cutscene_handler.scene][0]!=cutscene_wait_for_dialogue&&obj_cutscene_handler.scene_info[obj_cutscene_handler.scene][0]!=cutscene_wait_for_dialogue_complete) instance_destroy();
}
_scene=instance_exists(obj_cutscene_handler) ? obj_cutscene_handler.scene : noone;
switch state {
	case -1:
	
	break;
	case 0:
		stateExecutedOnce = false;
		
		// Reset previous state
		prevState = 0
		
		if(!instance_exists(WRITER)){
			// Create the text writer
			instance_create_depth(0, 0, 0, WRITER);
			with (WRITER) {
				displayText = WRITER.dialogue.dialogueText;
				WRITER.dialogue.dialogueVoice = voiceSound;
				WRITER.dialogue.dialogueSpeed = displaySpeed;
				//play = WRITER.dialogueVoice;
			}
		} else {
				if (WRITER.textFinished) {
					// Reset the face index
					displayFace = undefined;	
					displayFaceIndex = 0;
					textWritten = true;
				
					with(WRITER){
						textFinished = false;
						dialoguePortrait  = undefined;
					}
				
					// Check if writer does not exist
					if (!instance_exists(WRITER)) {
						state = -1;
					}
					displayText = WRITER.dialogue.dialogueText;
					displayFace = WRITER.dialogue.dialoguePortrait;
					with(WRITER){
						textFinished = true;
						dialoguePortrait  = undefined;
					}
				}
		}
	break;
	
}