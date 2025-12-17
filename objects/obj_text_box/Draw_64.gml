if(live_call()) return live_result;
//if(displayOnTop == undefined && instance_exists(CAM.following))	
//	displayAlignWriterY = CAM.y > CAM.following.y ? 310 : 305
//else displayAlignWriterY = displayOnTop ? 305 : 310;

displayAlignWriterY = displayOnTop ? 110 : 105;

if(instance_exists(WRITER)){
	WRITER.dialogueYPosition = displayAlignWriterY;
}

drawTextBox = function(){
	// Draw the dialogue box
	if __DRAW_9SLICE_BOX_WITH_OPACITY
	{
		//draw_box(32, 10 + displayAlignWriterY, 606, 160 + displayAlignWriterY,0,spr_textborder_inner, __DRAW_BOX_OPACITY);
		d_height = window_get_fullscreen() ? window_get_height() : global._windowed_height
	
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,320,398,12,3,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,320,398,12,3,0,c_white,1)
	
		if (WRITER.typewriter_state == 1 && !instance_exists(obj_choice_text) && showCursor){
			// Draw cursor
			draw_sprite_ext(spr_soulcursor,0,570,440,cursor_xyscale,cursor_xyscale,0,c_white,1)
		}
		
		// Draw the dialogue face if there's one used
		if (displayFace != spr_blank)
			with(obj_text_writer){hasDialoguePortrait = true } 
			if __DRAW_9SLICE_BOX_WITH_OPACITY {
				switch(dialogueSpeaker){
					case "sans":
	                case "gen3":    
	                    draw_sprite_ext(displayFace, floor(talk_frame), 64, 250 + displayAlignWriterY, 3, 3, 0, c_white, 1);	
	                break;    
	                case "paps":    
						draw_sprite_ext(displayFace, floor(talk_frame), 80, 240 + displayAlignWriterY, 2.5, 2.5, 0, c_white, 1);	
					break;
				}
			}
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