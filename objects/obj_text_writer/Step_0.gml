if(dialogue.dialoguePortrait != undefined){
	hasDialoguePortrait = true;
} else {
	hasDialoguePortrait = false;	
}

_scene=instance_exists(obj_cutscene_handler) ? obj_cutscene_handler.scene : noone;

//show_debug_message(dialogue.dialogueVoice)

//if is_array(dialogue.dialogueText) && dialogue.dialogueText[t_c][1]=="" && t_c<array_length(dialogue.dialogueText)-1 {
//	t_c++;
//}
