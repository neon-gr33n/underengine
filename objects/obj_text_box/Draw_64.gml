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
	draw_box(32, 10 + displayAlignWriterY, 608, 160 + displayAlignWriterY);
	
	// Draw the dialogue face if there's one used
	if (displayFace != undefined)
		draw_sprite_ext(displayFace, displayFaceIndex, 100, 75 + displayAlignWriterY, 2, 2, 0, c_white, 1);
}

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