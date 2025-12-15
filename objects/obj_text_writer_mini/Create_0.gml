depth = -99999;
if(instance_number(object_index)>1){
    instance_destroy();
    show_debug_message("There can only be one");
}

dialogue = {
	dialogueText: "",
	dialogueFont: "",
	dialogueVoice: "",
	dialogueSpeed: 0.55,
	dialoguePortrait: undefined
}

dialoguePosition = "bottom";
dialogueXOffset = 0;
dialogueXPosition = x//190;
dialogueYPosition  = y//260;
hasDialoguePortrait = false;
canSkip = false;
textFinished = false;

selectedChoice  = 0;

typist = scribble_typist();
typist.in(dialogue.dialogueSpeed,0);
typewriter_state = 0;