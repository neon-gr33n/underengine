if(live_call()) return live_result;
if(displayOnTop == undefined && instance_exists(CAM.cam1.follow))	
	displayAlignWriterY = CAM.y > CAM.cam1.follow.y ? 310 : 305
else displayAlignWriterY = displayOnTop ? 305 : 310;

switch(displayOnTop){
	case true:
		displayAlignWriterY = 310;
	break;
	case false:
		displayAlignWriterY = 305;
	break;
}

if(instance_exists(WRITER)){
	WRITER.dialogueYPosition = displayAlignWriterY;
}

drawTextBox = function(){
	// Draw the dialogue box
	if __DRAW_CLASSIC_UNDERTALE_BOX == true 
	{
		draw_box(32, 10 + displayAlignWriterY, 608, 160 + displayAlignWriterY);
	}
	if __DRAW_9SLICE_BOX_WITH_OPACITY == true
	{
		//draw_box(32, 10 + displayAlignWriterY, 606, 160 + displayAlignWriterY,0,spr_textborder_inner, __DRAW_BOX_OPACITY);
		draw_sprite_ext(spr_textborder_inner,0,320,398,12,3,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(spr_textborder_outer,0,320,398,12,3,0,c_white,1)
	}
	
	// Draw the dialogue face if there's one used
	if (displayFace != spr_blank)
		with(obj_text_writer){hasDialoguePortrait = true } 
		if __DRAW_CLASSIC_UNDERTALE_BOX == true {
			draw_sprite_ext(displayFace, displayFaceIndex, 100, 75 + displayAlignWriterY, 2, 2, 0, c_white, 1);
		}
		if __DRAW_9SLICE_BOX_WITH_OPACITY == true {
			draw_sprite_ext(displayFace, displayFaceIndex, 110, 90 + displayAlignWriterY, 2, 2, 0, c_white, 1);
		}
}
			drawTextBox();
switch state {
	case -1:
		if(prevState == 0){
			prevState = -1;	
		}
		
		// Check if the state has not already been execute once
		if(!stateExecutedOnce){
			// Draw the text box
			drawTextBox();
			
			stateExecutedOnce = true;
		}
	break;
	case 0:
			// Draw the text box
			drawTextBox();
			
			// Text writing is handled internally, see "obj_text_writer" and JujuAdams' Scribble for reference
	break;
}