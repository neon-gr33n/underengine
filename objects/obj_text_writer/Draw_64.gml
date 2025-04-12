if(live_call()) return live_result;
typewriter_state = self.typist.get_state();
if(gui){
	// to-do: add dialog box	
}
if dialogue.dialoguePortrait == spr_blank {
	dialogueXPosition = 52;	
} else if dialoguePosition == "top"{
	dialogueXPosition = 180;	
}

if dialoguePosition ==  "battle_generic" {
		dialogueYPosition = 260;
}

#region UNDERTALE STYLE BOX SPECIFIC Y PARAMS
if __DRAW_CLASSIC_UNDERTALE_BOX == true 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 340;	
	} else {
		dialogueYPosition = 50;	
	} 
}
#endregion

#region 9SLICED SPRITE BOX + OPACITY SPECIFIC Y PARAMS
if __DRAW_9SLICE_BOX_WITH_OPACITY == true 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 350;	
	} else if dialoguePosition == "top" {
		dialogueYPosition = 50;	
	}
}
#endregion

var scribble_object = scribble(dialogue.dialogueText)
	.starting_format(dialogue.dialogueFont,c_white)
	.wrap(640 - dialogueXPosition + dialogueYPosition);
	
scribble_object.draw(dialogueXPosition,dialogueYPosition,typist);

typist.sound([dialogue.dialogueVoice],true,1,1,);

if(pressed("cancel")){
		self.typist.skip();
		__paused = false;
}