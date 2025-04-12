if(live_call()) return live_result;

draw_ftext(fnt_mars,c_white,x+20,y+365,2,2,0, string(global.partyname[0]))
draw_ftext(fnt_mars,c_white,x+180,y+365,2,2,0,"LV " + string(global.partylv[0]))

draw_sprite_ext(spr_battle_ui_hp,0,x+312,y+369,1.5,1.5,0,c_white,1)

//todo: add flag to show/hide KR 
draw_sprite_ext(spr_battle_ui_kr,0,x+405,y+369,1.5,1.5,0,c_white,1)

draw_sprite_ext(spr_px,0,x+360,y+365,30,24,0,c_red,1)
draw_sprite_ext(spr_px,0,x+360,y+365,30,24,0,c_yellow,1)

draw_ftext(fnt_mars,c_white,x+520,y+365,2,2,0,string(global.partyhp[0]._curr) + "/" + string(global.partyhp[0]._full))