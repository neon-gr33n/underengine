display_set_gui_size(global._game_res_width/2, global._game_res_height/2)

if(pressed("action")) 
{
	obj_text_writer.dialogue.dialogueText = "";
	instance_destroy();
}
switch state {
	case -1:
	
	break;
	case 0:
		stateExecutedOnce = false;
		
		// Reset previous state
		prevState = 0
		
		if(!instance_exists(obj_text_writer)){
			// Create the text writer
			instance_create_depth(0, 0, 0, obj_text_writer);
			with (obj_text_writer) {
				displayText = obj_text_writer.dialogue.dialogueText;
				obj_text_writer.dialogue.dialogueVoice = voiceSound;
				obj_text_writer.dialogue.dialogueSpeed = displaySpeed;
				//play = obj_text_writer.dialogueVoice;
			}
		} else {
				if (obj_text_writer.textFinished) {
					// Reset the face index
					displayFace = undefined;	
					displayFaceIndex = 0;
					textWritten = true;
				
					with(obj_text_writer){
						textFinished = false;
						dialoguePortrait  = undefined;
					}
				
					// Check if writer does not exist
					if (!instance_exists(obj_text_writer)) {
						state = -1;
					}
					displayText = WRITER.dialogue.dialogueText;
					displayFace = WRITER.dialogue.dialoguePortrait;
					with(obj_text_writer){
						textFinished = true;
						dialoguePortrait  = undefined;
					}
				}
		}
	break;
	
}