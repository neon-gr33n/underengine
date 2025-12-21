if(live_call()) return live_result;
draw_sprite_ext(spr_game_over,0,320,_up,1,1,0,c_white,_alpha);
draw_sprite_ext(spr_game_over,1,320,_down,1,1,0,c_white,_alpha);

if _message != "" && _showMsg {
	if(!instance_exists(__writer)){
	__writer= instance_create_depth(60,330,-999999,obj_text_writer)
	}

	with(__writer){
		dialoguePosition = "none"
		dialogue.dialogueText =obj_gameover. _message
		dialogue.dialogueFont =obj_gameover. _font 
	}	
}

if _showChoices {
	outline_set_text();
			draw_ftext_transformed(fnt_main_small, c_white, 
	255, displayChoiceOffsetY - 60, ""+"Try again?", 25, 180, 2,2, 0, 1)
	outline_end();

		draw_ftext_transformed(fnt_main_small, _choice == 0 ? c_yellow : c_white, 
	180, displayChoiceOffsetY - 15, ""+displayChoices[0], 25, 180, 2,2, 0, 1)

	draw_ftext_transformed(fnt_main_small, _choice == 1 ? c_yellow : c_white, 
	180 + 240, displayChoiceOffsetY - 15, ""+displayChoices[1], 25, 180, 2,2, 0, 1)
	}