if(live_call()) return live_result;
currentInput = keyboard_string
draw_ftext(fnt_main_jp,c_white,x+52,y+6,0.7,0.7,0,"INPUT:")
draw_ftext(fnt_main_jp,c_white,x+55,y+190,0.7,0.7,0,"SPEAKER:")
draw_ftext(fnt_main_jp,c_white,x+225,y+190,0.7,0.7,0,currentSpeaker) // 0 by Default, meaning "generic" speaker with no portrait
draw_ftext(fnt_main_jp,c_white,x+55,y+240,0.7,0.7,0,"BOX STYLE:")
// Toggle for box styles because why not lol
draw_ftext(fnt_main_jp,c_white,x+155,y+240,0.7,0.7,0,global.rounded_box ? "ROUNDED (F3 - SWITCH TO CLASSIC TEXTBOX)" : "CLASSIC (F3 - SWITCH TO ROUNDED TEXTBOX)")
draw_sprite_ext(spr_textborder,0,325,80,10,2,0,c_white,1)
draw_ftext(fnt_main_bt,c_white,x+64,y+35,0.5,0.5,0,currentInput)
switch(currentSpeaker) {
	case "gen":
		draw_sprite_ext(spr_blank,0,x+450,175,2,2,0,c_white,1)
	break;	
	case "sans":
		currentPortExpression = speakersProperties.sans.port[currentPortExpressionIndex];
		draw_ftext(fnt_main_jp,c_white,x+390,y+210,0.7,0.7,0,"EXPRESSION:")	
		draw_sprite_ext(currentPortExpression,0,x+450,175,2,2,0,c_white,1)
	break;
}