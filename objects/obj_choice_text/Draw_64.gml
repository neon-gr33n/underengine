if(live_call()) return live_result;

HEART.visible=true;

draw_ftext_transformed(loc_get_font(fnt_main_small), choiceSelection == 0 ? c_yellow : c_white, 
180, 365 + level*29, ""+displayChoices[0], 25, 180, 2,2, 0, 1)

draw_ftext_transformed(loc_get_font(fnt_main_small), choiceSelection == 1 ? c_yellow : c_white, 
180 + 190, 365 + level*29, ""+displayChoices[1], 25, 180, 2,2, 0, 1)

//draw_sprite_ext(spr_heart_sm, 0, choiceSelection == 1  ? displayChoiceOffsetX[1] - 150 : displayChoiceOffsetX[0] + 40, displayChoiceOffsetY - 6, 2, 2, 0, c_red,1)
HEART.x=displayChoiceOffsetX[choiceSelection];
HEART.y=380+level*29

if input.action_pressed {
	outputChoices[choiceSelection]();
	
	global.soulChosen = choiceSelection;
	global.realSoulChoice = true
	sfx_play(snd_menu_select,1,global.sfx_volume)
	instance_destroy(obj_text_box)
	instance_destroy()
}