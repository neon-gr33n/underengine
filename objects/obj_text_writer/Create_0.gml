depth = -9999;

dialogue = {
	dialogueText: "",
	dialogueFont: "",
	dialogueVoice: "",
	dialogueSpeed: 0.55,
	dialoguePortrait: undefined
}

dialoguePosition = "bottom";
dialogueXOffset = 0;
dialogueXPosition = 0;
dialogueYPosition  = 260;
dialogueCurrentIndex = 0;
hasDialoguePortrait = false;
canSkip = false;

selectedChoice  = 0;

typist = scribble_typist();
typist.in(dialogue.dialogueSpeed,0);
typewriter_state = 0;