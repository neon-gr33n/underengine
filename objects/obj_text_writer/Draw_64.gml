if(live_call()) return live_result;
typewriter_state = self.typist.get_state();
if(gui){
	// to-do: add dialog box	
}
if hasDialoguePortrait == false {
	dialogueXPosition = 52;	
} else {
	dialogueXPosition = 180;	
}
if dialoguePosition == "bottom" {
	dialogueYPosition = 340;	
} else {
	dialogueYPosition = 50;	
}

var scribble_object = scribble(dialogue.dialogueText)
	.starting_format(dialogue.dialogueFont,c_white)
	.wrap(640 - dialogueXPosition + dialogueYPosition);
	
if(dialoguePosition=="top"){
	draw_text_scribble(dialogueXPosition-dialogueXOffset, dialogueYPosition, dialogue.dialogueText)
} else if(dialoguePosition=="bottom"){
		scribble_object.draw(dialogueXPosition,dialogueYPosition,typist);
}

typist.sound([dialogue.dialogueVoice],true,1,1,);

if canSkip == true {
	if(inputdog_pressed("select")){
		self.typist.skip();
	}
}