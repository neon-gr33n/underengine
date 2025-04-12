if(live_call()) return live_result;

draw_ftext_transformed(fnt_main_small, choiceSelection == 0 ? c_yellow : c_white, 
180, displayChoiceOffsetY - 15, displayChoices[0], 25, 180, 2,2, 0, 1)

draw_ftext_transformed(fnt_main_small, choiceSelection == 1 ? c_yellow : c_white, 
180 + 190, displayChoiceOffsetY - 15, displayChoices[1], 25, 180, 2,2, 0, 1)

draw_sprite_ext(spr_heart_sm, 0, choiceSelection == 1  ? displayChoiceOffsetX[1] - 150 : displayChoiceOffsetX[0] + 40,
displayChoiceOffsetY - 6, 2, 2, 0, c_red,1)

if pressed("action") {
	global.soulChosen = choiceSelection;
	global.realSoulChoice = true
	sfx_playc(snd_menu_select,1,0.6)
	instance_destroy(obj_text_box)
	instance_destroy()
}