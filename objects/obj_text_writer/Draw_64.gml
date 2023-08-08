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
if __DRAW_CLASSIC_UNDERTALE_BOX == true 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 340;	
	} else {
		dialogueYPosition = 50;	
	}
}

if __DRAW_9SLICE_BOX_WITH_OPACITY == true 
{
		if dialoguePosition == "bottom"  {
		dialogueYPosition = 350;	
	} else {
		dialogueYPosition = 50;	
	}
}

var scribble_object = scribble(dialogue.dialogueText)
	.starting_format(dialogue.dialogueFont,c_white)
	.wrap(640 - dialogueXPosition + dialogueYPosition);
	
scribble_object.draw(dialogueXPosition,dialogueYPosition,typist);

typist.sound([dialogue.dialogueVoice],true,1,1,);

if(inputdog_pressed("cancel")){
		self.typist.skip();
		__paused = false;
}