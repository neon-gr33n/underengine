if(live_call()) return live_result;

// TOP SECTION  draws the Player Name, current LV, HP, and total G
// BOTTOM SECTION draws the options, with an optional flair ala, "Don't Forget" (RickyG)

#region TOP SECTION
// draw boxes

draw_sprite_ext(spr_px,0,x+50,y+75,131,6,0,c_white,1)
draw_sprite_ext(spr_px,0,x+55,y+75,101,6,-90,c_white,1)
draw_sprite_ext(spr_px,0,x+183,y+75,101,6,-90,c_white,1)
draw_sprite_ext(spr_px,0,x+50,y+170,132,6,0,c_white,1)

draw_sprite_ext(spr_px,0,x+55,y+80,122,90,0,c_black,1)

if _menu_active == 1 {
	draw_sprite_ext(spr_px,0,x+190,y+75,259,6,0,c_white,1)
	draw_sprite_ext(spr_px,0,x+196,y+75,313,6,-90,c_white,1)
	draw_sprite_ext(spr_px,0,x+449,y+75,313,6,-90,c_white,1)
	draw_sprite_ext(spr_px,0,x+190,y+384,259,6,0,c_white,1)

	draw_sprite_ext(spr_px,0,x+195,y+80,248,304,0,c_black,1)


	if UTE_ENABLE_FF_CHOICE_LINE == true {
		draw_sprite_ext(spr_px,0,x+210,y+320,220,3,0,c_white,1)
		draw_sprite_ext(spr_px,0,x+210,y+370,220,3,0,c_white,1)
		draw_ftext(fnt_main_small,c_white,215,330,2,2,0,loc_gettext("ui.item.use"))
		draw_ftext(fnt_main_small,c_white,255,330,2,2,0,"  |")
		draw_ftext(fnt_main_small,c_white,287,330,2,2,0,loc_gettext("ui.item.inspect"))
		draw_ftext(fnt_main_small,c_white,345,330,2,2,0,"  |")
		draw_ftext(fnt_main_small,c_white,375,330,2,2,0,loc_gettext("ui.item.drop"))
	} else {
		draw_ftext(fnt_main_small,c_white,215,340,2,2,0,loc_gettext("ui.item.use"))
		draw_ftext(fnt_main_small,c_white,287,340,2,2,0,loc_gettext("ui.item.inspect"))
		draw_ftext(fnt_main_small,c_white,375,340,2,2,0,loc_gettext("ui.item.drop"))
	}
}

// draw text
draw_ftext(fnt_main_small,c_white,63-x,81,2,2,0,"Frisk")
draw_ftext(fnt_crypt,c_white,62,113,1,1,0,"LV" + "  9")
draw_ftext(fnt_crypt,c_white,62,129,1,1,0,"HP" + "  20/20")
draw_ftext(fnt_crypt,c_white,62,146,1,1,0,"G" + "   331")
#endregion

#region BOTTOM SECTION
// draw boxes

draw_sprite_ext(spr_px,0,x+55,y+180,123,138,0,c_black,1)

draw_sprite_ext(spr_px,0,x+49,y+182,135,6,0,c_white,1)
draw_sprite_ext(spr_px,0,x+55,y+188,130,6,-90,c_white,1)
draw_sprite_ext(spr_px,0,x+184,y+188,130,6,-90,c_white,1)
draw_sprite_ext(spr_px,0,x+49,y+311,132,7,0,c_white,1)

if UTE_ENABLE_DF_CMENU_CURSOR == true {
	if(_menu_active == 1){
			draw_sprite_ext(spr_cmenu_sel,0,x+190,y+selCursorYPos-115,3.5,1.5,0,c_yellow,1)	
			draw_sprite_ext(spr_heart_sm,0,x+230,y+selCursorYPos-112,2,2,0,c_black,1)
			var _invSize = ds_list_size(global.player_inventory);
	
			for (var i = 0; i < _invSize; i++){
				var _item = global.player_inventory[| i].longName;	
		
				var _y = 30 * i;
				draw_ftext_transformed(fnt_main_small,c_white,235+30, _y+85,string(_item),0,240,2,2,0,1)
				if _menu_item_selection == 0 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+55,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 1 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+85,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 2 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+115,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 3 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+145,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 4 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+175,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 5 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+205,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 6 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+235,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 7 {
					draw_ftext_transformed(fnt_main_small,c_black,235+30, 30+265,string(_item),0,240,2,2,0,1)
				}
			}
			// draw text
			draw_ftext(fnt_main_small,c_silver ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(fnt_main_small,c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			draw_ftext(fnt_main_small,  c_white,98,264,2,2,0,loc_gettext("ui.cell"))
	}
	if(!_activeSel){
	draw_sprite_ext(spr_cmenu_sel,0,x+49,y+selCursorYPos,2,1.5,0,c_red,1)
	draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+selCursorYPos+3,2,2,0,c_black,1)
	}
	if(_menu_active == 0){
		// draw text
		draw_ftext(fnt_main_small,_menu_selection == 0 ? c_black : c_white ,98,200,2,2,0,loc_gettext("ui.item"))
		draw_ftext(fnt_main_small,_menu_selection == 1 ? c_black : c_white,98,232,2,2,0,loc_gettext("ui.stat"))
		draw_ftext(fnt_main_small, _menu_selection == 2 ? c_black : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
	}
} else {
	if(!_activeSel){
	draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+selCursorYPos+3,2,2,0,c_red,1)	
	}
			var _invSize = ds_list_size(global.player_inventory);
	
			for (var i = 0; i < _invSize; i++){
				var _item = global.player_inventory[| i].longName;	
		
				var _y = 30 * i;
				draw_ftext_transformed(fnt_main_small,c_white,235+30, _y+85,string(_item),0,240,2,2,0,1)
				if _menu_item_selection == 0 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+55,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 1 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+85,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 2 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+115,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 3 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+145,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 4 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+175,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 5 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+205,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 6 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+235,string(_item),0,240,2,2,0,1)
				}
				if _menu_item_selection == 7 {
					draw_ftext_transformed(fnt_main_small,c_yellow,235+30, 30+265,string(_item),0,240,2,2,0,1)
				}
			}
	// draw text
	draw_ftext(fnt_main_small,_menu_selection == 0 ? c_yellow : c_white ,98,200,2,2,0,loc_gettext("ui.item"))
	draw_ftext(fnt_main_small,_menu_selection == 1 ? c_yellow : c_white,98,232,2,2,0,loc_gettext("ui.stat"))
	draw_ftext(fnt_main_small, _menu_selection == 2 ? c_yellow : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
}

#endregion

//draw_sprite_ext(spr_px,0,x+30,y+15,150,12,-90,c_white,1)
//draw_sprite_ext(spr_px,0,x+30,y+153,210,12,0,c_white,1)