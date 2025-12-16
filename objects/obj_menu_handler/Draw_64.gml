if(live_call()) return live_result;
switch(state){
	case "menuPre":
		draw_sprite_ext(spr_logo,0,logoPosX,logoPosY,3,3,0,c_white,1)
	break;
	case "menuMain":
		execute_tween(self,"logoPosY",6,easetype.easeInOutElastic,2)
		execute_tween(self,"alpha",1,easetype.easeInOutElastic,2)
		execute_tween(HEART,"image_alpha",1,easetype.easeInOutElastic,2)
		//draw_sprite_ext(spr_cmenu_sel_longer,0,227,155+_menuSelection*40,-2.670588,1.875,0,c_red,alpha)
		draw_sprite_ext(spr_logo,0,logoPosX,logoPosY,3,3,0,c_white,alpha)
		draw_set_alpha(alpha)
		draw_text_scribble(_menuSelection==0 ? x-370 : x-390,y+118, _menuSelection == 0 ? "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_yellow] "+loc_gettext("ui.title.start")+"[/c]" :  "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1]    "+loc_gettext("ui.title.start"))
		draw_text_scribble(x-390,y+160, (!(file_exists("file0")||file_exists("file1")||file_exists("file2")) ? "["+ loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_grey]    "+loc_gettext("ui.title.load")+"[/c]" : (_menuSelection == 1 ?  "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_yellow]    "+loc_gettext("ui.title.load")+"[/c]" : "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1]    "+loc_gettext("ui.title.load"))))
		draw_text_scribble(x-390,y+198,_menuSelection == 2 ? "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_yellow]    "+loc_gettext("ui.title.extras")+"[/c]" :  "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1]    "+loc_gettext("ui.title.extras"))
		draw_text_scribble(x-390,y+238,_menuSelection == 3 ? "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_yellow]    "+loc_gettext("ui.title.settings")+"[/c]" : "[" + loc_get_font("fnt_main_bt") +"]"+ "[scale,1.1]    "+loc_gettext("ui.title.settings"))
		draw_text_scribble(x-390,y+278,_menuSelection == 4 ? "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1][c_yellow]    "+loc_gettext("ui.title.quit")+"[/c]" :  "[" + loc_get_font("fnt_main_bt") +"]"+"[scale,1.1]    "+loc_gettext("ui.title.quit"))

		draw_text_scribble(x-400,y+370, "[fnt_crypt][scale,1][c_white]" + GAME_NAME + " V" + GAME_VERSION +"[/c]")
		draw_text_scribble(x-408,y+385, "[fnt_crypt][scale,1][c_white] UNDERTALE (C) 2015[/c]")
		draw_text_scribble(x-408,y+400, "[fnt_crypt][scale,1][c_white] DELTARUNE (C) 2018[/c]")
		draw_text_scribble(x-408,y+415, "[fnt_crypt][scale,1][c_white]" + " " + GAME_NAME + " (C) 2025 [/c]")
	break;
}
