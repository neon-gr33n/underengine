if(live_call()) return live_result;
typewriter_state = self.typist.get_state();
if dialogue.dialoguePortrait == spr_blank {
	dialogueXPosition = 52;	
} else if dialoguePosition == "top"{
	dialogueXPosition = 180;	
}

if dialoguePosition ==  "battle_generic" {
		dialogueXPosition = 52;	
		dialogueYPosition = 255;
}

#region UNDERTALE STYLE BOX SPECIFIC Y PARAMS
if __DRAW_CLASSIC_UNDERTALE_BOX 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 340;	
		dialogueXPosition = 190;
	} else {
		dialogueYPosition = 50;	
	} 
}
#endregion

#region 9SLICED SPRITE BOX + OPACITY SPECIFIC Y PARAMS
if __DRAW_9SLICE_BOX_WITH_OPACITY 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 350;	
		dialogueXPosition = 190;
	} else if dialoguePosition == "top" {
		dialogueXPosition = 190;
		dialogueYPosition = 50;	
	}
}
#endregion

if dialoguePosition ==  "none" {
		dialogueXPosition = x;
		dialogueYPosition = y;
}

var scribble_object = scribble(dialogue.dialogueText)
	.starting_format(dialogue.dialogueFont,c_white)
	.wrap(640 - dialogueXPosition + dialogueYPosition);
	
if visible
scribble_object.draw(dialogueXPosition,dialogueYPosition,typist);

typist.sound_per_char([dialogue.dialogueVoice],true,1,1,);

if(input.cancel_pressed){
		self.typist.skip();
		__paused = false;
}