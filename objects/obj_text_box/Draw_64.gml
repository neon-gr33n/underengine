if(live_call()) return live_result;

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
	
		var __top = WRITER.actual_position == "top" 
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,320,__top ? 75 : 398,12,3,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,320,__top ? 75 : 398,12,3,0,c_white,1)
	
		if (WRITER.typewriter_state == 1 && !instance_exists(obj_choice_text) && showCursor && global.menu_qol_enabled ){
			// Draw cursor
			draw_sprite_ext(spr_soulcursor,0,570,440,cursor_xyscale,cursor_xyscale,0,c_white,1)
		}
		
		// Draw the dialogue face if there's one used
		if (displayFace != spr_blank)
			with(obj_text_writer){hasDialoguePortrait = true } 
			if __DRAW_9SLICE_BOX_WITH_OPACITY {
				var __bottom = WRITER.actual_position == "bottom" 
				switch(dialogueSpeaker){
					case "sans":
	                    draw_sprite_ext(displayFace, floor(talk_frame), 80, 250 + (__bottom ? displayAlignWriterY : 20 - 235), 3, 3, 0, c_white, 1);	
	                break;    
	                case "paps":    
						draw_sprite_ext(displayFace, floor(talk_frame), 80, 240 + (__bottom ? displayAlignWriterY : 20 - 235), 2.5, 2.5, 0, c_white, 1);	
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