if(live_call()) return live_result;

// TOP SECTION  draws the Player Name, current LV, HP, and total G
// BOTTOM SECTION draws the options, with an optional flair ala, "Don't Forget" (RickyG)

#region TOP SECTION
// draw boxes

draw_sprite_ext(global.boxout,0,x+115,y+125,2.95,2,0,c_white,1)
draw_sprite_ext(global.boxin,0,x+115,y+125,2.95,2,0,c_white,__DRAW_BOX_OPACITY)

 switch _menu_active {
	case 1:
		draw_sprite_ext(global.boxout,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxout,0,x+330,y+229,6,6.5,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+229,6,6.5,0,c_white,__DRAW_BOX_OPACITY)
		if currentState=="itemAction" || (currentState == "itemOpened" && use_text != "") {
			draw_sprite_ext(global.boxout,0,x+330,y+426,6,2,0,c_white,1)
			draw_sprite_ext(global.boxin,0,x+330,y+426,6,2,0,c_white,__DRAW_BOX_OPACITY)
		}
		draw_set_halign(fa_center);
		draw_ftext(fnt_mars,c_white,330,60,1,1,0,activeSection+"   [press c]")
		draw_set_halign(fa_left)

		draw_ftext(loc_get_font(fnt_main_small),currentState=="itemAction"&&!_action_selction ? c_yellow : c_white,global.rounded_box ? 250:215,330,2,2,0,loc_gettext("ui.item.use"))
		// todo: add "info/inspect" option and functionality
		//draw_ftext(global.fnt_main_sm,c_white,global.rounded_box ? 300:287,330,2,2,0,loc_gettext("ui.item.inspect"))
		draw_ftext(loc_get_font(fnt_main_small),currentState=="itemAction"&&_action_selction ? c_yellow : c_white,global.rounded_box ? 350:287,330,2,2,0,loc_gettext("ui.item.drop"))
	break;
	
	case 2:
		draw_sprite_ext(global.boxout,0,x+366,y+263,7.5,8,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+366,y+263,7.5,8,0,c_white,__DRAW_BOX_OPACITY)
	break;

	case 3:
		draw_sprite_ext(global.boxout,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxout,0,x+330,y+229,6,6.5,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+229,6,6.5,0,c_white,__DRAW_BOX_OPACITY)
	
		draw_ftext(fnt_mars,c_white,265,60,1,1,0,"CONTACTS")
	break;
	
	case 4:
		draw_sprite_ext(global.boxout,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+67,6,0.67,0,c_white,1)
		draw_sprite_ext(global.boxout,0,x+330,y+229,6,6.5,0,c_white,1)
		draw_sprite_ext(global.boxin,0,x+330,y+229,6,6.5,0,c_white,__DRAW_BOX_OPACITY)
	
		draw_ftext(fnt_mars,c_white,265,60,1,1,0,"CONTACTS")
	break;
}

// draw text
draw_ftext(loc_get_font(fnt_main_small),c_white,63-x,83,2,2,0,string(member_get_attribute(party_get_leader(), "NAME")))
draw_ftext(fnt_crypt,c_white,62,113,1,1,0,"LV" + "  " + string(member_get_stat(party_get_leader(), "LV")))
draw_ftext(fnt_crypt,c_white,62,129,1,1,0,"HP" + "  " + string(member_get_stat(party_get_leader(), "HP")) 
+ "/" + string(member_get_stat(party_get_leader(), "MAX_HP")))
draw_ftext(fnt_crypt,c_white,62,146,1,1,0,"G" + "   " + string(party_get_stat("GOLD")))
#endregion

#region BOTTOM SECTION
// draw boxes

//draw_sprite_ext(global.boxout,0,x+115,y+230,2.95,2,0,c_white,1)
//draw_sprite_ext(global.boxin,0,x+115,y+230,2.95,2,0,c_white,__DRAW_BOX_OPACITY)
draw_sprite_ext(global.boxout,0,x+115,y+inven_get_item_by_name("CELL_PHONE") != noone ? 248 : 230 ,2.95,inven_get_item_by_name("CELL_PHONE") != noone ? 3:2,0,c_white,1)
draw_sprite_ext(global.boxin,0,x+115,y+inven_get_item_by_name("CELL_PHONE") != noone ? 248 : 230 ,2.95,inven_get_item_by_name("CELL_PHONE") != noone ? 3:2,0,c_white,__DRAW_BOX_OPACITY)

if UTE_ENABLE_DF_CMENU_CURSOR {
	switch _menu_active {
		case 0:			
			draw_sprite_ext(spr_cmenu_sel,0,x + 47,y+205+_menu_selection*32,2,1.5,0,c_red,1)
			draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_black,1)
			// draw text
			draw_ftext(loc_get_font(fnt_main_small),_menu_selection == 0 ? c_black : c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),_menu_selection == 1 ? c_black : c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
				draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_black : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
			break;
		
		case 1:		
			_invmain = "";
			_invcount = 0;
			_item_index = 0;
			
			array_foreach(party_get_attribute("INVENTORY"), function(_element, _index) {
				if (!_menu_item_section || item_get_category(_element) == index_to_category(_menu_item_section - 1)) {
					_invmain += (_invcount == _menu_item_selection ? (currentState == "itemAction" ? "[c_dkgray]" : "[c_black]") : "[c_white]") + item_get_attribute(_element, "NAME") + "[/c]#";
					_invcount++;
				}
				if (_invcount <= _menu_item_selection)
					_item_index++;
			});
			if (!_menu_item_section)
				repeat (inven_get_space_left())
					_invmain += "[c_grey]------------[/c]#"

			draw_sprite_ext(spr_cmenu_sel_longer,0,x+25,y+205+_menu_selection*32,2,1.5,0,c_yellow,1)
			
			if _invcount>0 {
				draw_sprite_ext(spr_cmenu_sel,0,x+198,y+88+_menu_item_selection*29,global.rounded_box ? 3.8:3.5,2,0,c_yellow,1)	
				draw_sprite_ext(spr_heart_sm,0,x+220,y+93+_menu_item_selection*29,2,2,0,c_black,1) // KEEP: Only draws for active item
			}
			
			if (!instance_exists(__invmain)) {
				__invmain = instance_create(235+20,30+54,obj_text_writer)
			}
				
			__invmain.dialogue.dialogueFont =loc_get_font("fnt_main");
			__invmain._speed = 0.95;
			__invmain.dialogue.dialogueText=_invmain
			__invmain.dialoguePosition="none"
			__invmain.typist.skip();
			if (currentState == "itemOpened" && use_text != "") {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont = loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText= "[scale, 1.5]" + use_text;
				__info.dialoguePosition="none";
			} else if currentState == "itemAction" {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont = loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText="[scale, 1.5]" + item_get_attribute(inven_get_item(_item_index), "DESCRIPTION");
				__info.dialoguePosition="none";
				__info.typist.skip();
			} else if currentState=="itemUsing" {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont =loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText= "[scale, 1.5]" + use_text;
				__info.dialoguePosition="none";
				//__info.typist.skip();
			} else if instance_exists(__info)
				instance_destroy(__info)
			
			// draw options
			draw_ftext(loc_get_font(fnt_main_small),c_black ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
					draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_black : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
			break;
			
		case 2:
			draw_sprite_ext(spr_cmenu_sel_longer,0,x+25,y+205+_menu_selection*32,2,1.5,0,c_red,1)
			draw_ftext(loc_get_font(fnt_main_small),c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),c_black,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
					draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_black : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
		
			if !instance_exists(__stat) { __stat = instance_create(215,30+60,obj_text_writer) }
		
			__stat.dialoguePosition = "none"
			__stat.dialogue.dialogueFont =loc_get_font("fnt_main")
			__stat.dialogue.dialogueText = chr(34) + string(member_get_attribute(party_get_leader(), "NAME")) + chr(34)
																	+ "#"
																	+"LV" + " " + string(member_get_stat(party_get_leader(), "LV"))
																	+ "#"
																	+"#"
																	+ "HP:" + " " + string(member_get_stat(party_get_leader(), "HP"))
																	+ "/" + string(member_get_stat(party_get_leader(), "MAX_HP"))
																	+ "#" 
																	+"#"
																	+"EXP:" + " " + string(member_get_stat(party_get_leader(), "EXP"))
																	+"#"
																	+"NEXT:" + " " + string(LV_get_exp_needed(member_get_stat(party_get_leader(), "LV") + 1) - member_get_stat(party_get_leader(), "EXP"))
																	+"#"
																	+"#"
																	+"WEAPON: "+string(item_get_attribute(member_get_stat(party_get_leader(), "WEAPON"), "NAME"))
																	+"#"
																	+"ARMOR: "+string(item_get_attribute(member_get_stat(party_get_leader(), "ARMOUR"), "NAME"))
																	+"#"											
																	+"#"
																	+"GOLD:" + " " + string(party_get_stat("GOLD"))
														
																
																
			__stat.typist.skip();
			if !instance_exists(__stat2) { __stat2 = instance_create(365,30+60,obj_text_writer) }
		
			__stat2.dialoguePosition = "none"
			__stat2.dialogue.dialogueFont = loc_get_font("fnt_main")
			__stat2.dialogue.dialogueText = 
																	"#"
																	+"#"
																	+"#"
																	+"ATK:" + " " + string(member_get_stat(party_get_leader(), "ATK"))
																	+" (" + string(item_get_attribute(member_get_stat(party_get_leader(), "WEAPON"), "ATK")) + ")"
																	+"#" 
																	+"DEF:" + " "+  string(member_get_stat(party_get_leader(), "DEF"))
																	+" (" + string(item_get_attribute(member_get_stat(party_get_leader(), "ARMOUR"), "DEF")) + ")"
																	+"#"
																	+"KILLS:" + " " +string(party_get_stat("KILLS")) 
																	+"#"
																	+"SPARES:" + " " + string(party_get_stat("SPARES"))
														
																
																
			__stat2.typist.skip();
		break;
		
		case 3:
		    draw_sprite_ext(spr_cmenu_sel_longer,0,x+25,y+205+_menu_selection*32,2,1.5,0,c_lime,1)
		    draw_sprite_ext(spr_cmenu_sel_longer,0,x+495,y+28+_menu_contact_selection*32+64,-3.5,1.8,0,c_lime,1)
    
		    draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos+150,y+33+_menu_contact_selection*32+64,2,2,0,c_black,1) // KEEP: Only draws for active contact
		    _contactslist = ""
    
		    for (var i=0;i<10;i++) {
		        _contactslist += (_menu_contact_selection == i ? "[c_black]" : "[c_white]") + 
		                        (10 > i ? 
		                            (array_length(_contacts) > i ? 
		                                global.CONTACTS[$ _contacts[i]][$ "NAME"] + "[scale,1][/c]" : 
		                                "[c_grey]------------[/c]"
		                            ) : 
		                            ""
		                        ) + "#"
		    }
    
		    if !instance_exists(__contacts) { __contacts = instance_create(255+20,30+58,obj_text_writer) }
    
		    __contacts.dialogue.dialogueFont = loc_get_font("fnt_main")
		    __contacts._speed = 0.95;
		    __contacts.dialogue.dialogueText = _contactslist
		    __contacts.dialoguePosition = "none"
		    __contacts.typist.skip();
    
		    // draw options
		    draw_ftext(loc_get_font(fnt_main_small), c_white, 98, 200, 2, 2, 0, loc_gettext("ui.item"))
		    draw_ftext(loc_get_font(fnt_main_small), c_white, 98, 232, 2, 2, 0, loc_gettext("ui.stat"))
		    if (inven_get_item_by_name("CELL_PHONE") != noone){
		        draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_black : c_white, 98, 264, 2, 2, 0, loc_gettext("ui.cell"))
		    }
		break;
		case 4:
		    draw_sprite_ext(spr_cmenu_sel_longer,0,x+25,y+205+_menu_selection*32,2,1.5,0,c_lime,1)
		    draw_sprite_ext(spr_cmenu_sel_longer,0,x+495,y+28+_menu_contact_choice_selection*29+64,-3.5,1.8,0,c_lime,1)
    
		    draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos+150,y+33+_menu_contact_choice_selection*29+64,2,2,0,c_black,1) // KEEP: Only draws for active contact choice
    
		    _contactchoices = ""
    
		    // Get the contact data first
		    var _contact_key = _contacts[_menu_contact_selection];
		    var _contact_data = global.CONTACTS[$ _contact_key];
		    
		    // Loop through available choices only
		    for (var i = 0; i < array_length(_contact_data.CHOICES); i++) {
		        var choice_text = _contact_data.CHOICES[i];
		        _contactchoices += (_menu_contact_choice_selection == i ? "[c_black]" : "[c_white]") + choice_text + "[scale,1][/c]#";
		    }
    
		    if !instance_exists(__contacts_call_choices) { __contacts_call_choices = instance_create(255+20,30+58,obj_text_writer) }
    
		    __contacts_call_choices.dialogue.dialogueFont = loc_get_font("fnt_main")
		    __contacts_call_choices._speed = 0.95;
		    __contacts_call_choices.dialogue.dialogueText=_contactchoices
		    __contacts_call_choices.dialoguePosition="none"
		    __contacts_call_choices.typist.skip();
    
		    // draw options
		    draw_ftext(loc_get_font(fnt_main_small),c_white ,98,200,2,2,0,loc_gettext("ui.item"))
		    draw_ftext(loc_get_font(fnt_main_small),c_white,98,232,2,2,0,loc_gettext("ui.stat"))
		    if (inven_get_item_by_name("CELL_PHONE") != noone){
		        draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_black : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
		    }
		break;
	}
} else {
	switch _menu_active {
		case 0:
			draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_red,1)
			draw_ftext(loc_get_font(fnt_main_small),_menu_selection == 0 ? c_yellow : c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),_menu_selection == 1 ? c_yellow : c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
				draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_yellow : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
			break;
		
		case 1:
			_invmain = "";
			_invcount = 0;
			_item_index = 0;
			
			array_foreach(party_get_attribute("INVENTORY"), function(_element, _index) {
				if (!_menu_item_section || item_get_category(_element) == index_to_category(_menu_item_section - 1)) {
					_invmain += (_invcount == _menu_item_selection ? (currentState == "itemAction" ? "[c_dkgray]" : "[c_yellow]") : "[c_white]") + item_get_attribute(_element, "NAME") + "[/c]#";
					_invcount++;
				}
				if (_invcount <= _menu_item_selection)
					_item_index++;
			});
			if (!_menu_item_section)
				repeat (inven_get_space_left())
					_invmain += "[c_grey]------------[/c]#"

			if _invcount>0 {
				draw_sprite_ext(spr_heart_sm,0,x+220,y+93+_menu_item_selection*29,2,2,0,c_red,1) // KEEP: Only draws for active item
			}
			
			if (!instance_exists(__invmain)) {
				__invmain = instance_create(235+20,30+54,obj_text_writer)
			}
				
			__invmain.dialogue.dialogueFont =loc_get_font("fnt_main");
			__invmain._speed = 0.95;
			__invmain.dialogue.dialogueText=_invmain
			__invmain.dialoguePosition="none"
			__invmain.typist.skip();
			if (currentState == "itemOpened" && use_text != "") {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont = loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText= "[scale, 1.5]" + use_text;
				__info.dialoguePosition="none";
			} else if currentState == "itemAction" {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont = loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText="[scale, 1.5]" + item_get_attribute(inven_get_item(_item_index), "DESCRIPTION");
				__info.dialoguePosition="none";
				__info.typist.skip();
			} else if currentState=="itemUsing" {
				if !instance_exists(__info) { __info = instance_create(210,385,obj_text_writer) }
				
				__info.dialogue.dialogueFont =loc_get_font("fnt_main_small");
				__info._speed = 0.95;
				__info.dialogue.dialogueText= "[scale, 1.5]" + use_text;
				__info.dialoguePosition="none";
			} else if instance_exists(__info)
				instance_destroy(__info)
			
			// draw options
			// REMOVED: draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_red,1)
			draw_ftext(loc_get_font(fnt_main_small),c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),_menu_selection == 1 ? c_yellow : c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
				draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_yellow : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
			break;
			
		case 2:
			// REMOVED: draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_red,1)
			draw_ftext(loc_get_font(fnt_main_small),c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),c_yellow,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
				draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_yellow : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
		
			if !instance_exists(__stat) { __stat = instance_create(215,30+60,obj_text_writer) }
		
			__stat.dialoguePosition = "none"
			__stat.dialogue.dialogueFont =loc_get_font("fnt_main")
			__stat.dialogue.dialogueText = chr(34) + string(member_get_attribute(party_get_leader(), "NAME")) + chr(34)
																	+ "#"
																	+"LV" + " " + string(member_get_stat(party_get_leader(), "LV"))
																	+ "#"
																	+"#"
																	+ "HP:" + " " + string(member_get_stat(party_get_leader(), "HP"))
																	+ "/" + string(member_get_stat(party_get_leader(), "MAX_HP"))
																	+"#"
																	+"EXP:" + " " + string(member_get_stat(party_get_leader(), "EXP"))
																	+"#"
																	+"NEXT:" + " " + string(LV_get_exp_needed(member_get_stat(party_get_leader(), "LV") + 1) - member_get_stat(party_get_leader(), "EXP"))
																	+"#"
																	+"#"
																	+"WEAPON: "+string(item_get_attribute(member_get_stat(party_get_leader(), "WEAPON"), "NAME"))
																	+"#"
																	+"ARMOR: "+string(item_get_attribute(member_get_stat(party_get_leader(), "ARMOUR"), "NAME"))
																	+"#"
																	+"#"
																	+"GOLD:" + " " + string(party_get_stat("GOLD"))
														
			__stat.typist.skip();
			if !instance_exists(__stat2) { __stat2 = instance_create(365,30+60,obj_text_writer) }
		
			__stat2.dialoguePosition = "none"
			__stat2.dialogue.dialogueFont = loc_get_font("fnt_main")
			__stat2.dialogue.dialogueText = 
																	"#"
																	+"#"
																	+"#"
																	+"ATK:" + " " + string(member_get_stat(party_get_leader(), "ATK"))
																	+" (" + string(item_get_attribute(member_get_stat(party_get_leader(), "WEAPON"), "ATK")) + ")"
																	+"#" 
																	+"DEF:" + " "+  string(member_get_stat(party_get_leader(), "DEF"))
																	+" (" + string(item_get_attribute(member_get_stat(party_get_leader(), "ARMOUR"), "DEF")) + ")"
																	+"#"
																	+"KILLS:" + " " +string(party_get_stat("KILLS")) 
																	+"#"
																	+"SPARES:" + " " + string(party_get_stat("SPARES"))
														
			__stat2.typist.skip();
		break;
		
		case 3:
			draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos+150,y+33+_menu_contact_selection*32+64,2,2,0,c_red,1) // KEEP: Only draws for active contact
			// REMOVED: draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_red,1)
			_contactslist = ""
    
		    for (var i=0;i<10;i++) {
		        _contactslist += (_menu_contact_selection == i ? "[c_yellow]" : "[c_white]") + 
		                        (10 > i ? 
		                            (array_length(_contacts) > i ? 
		                                global.CONTACTS[$ _contacts[i]][$ "NAME"] + "[scale,1][/c]" : 
		                                "[c_grey]------------[/c]"
		                            ) : 
		                            ""
		                        ) + "#"
		    }
    
		    if !instance_exists(__contacts) { __contacts = instance_create(255+20,30+58,obj_text_writer) }
    
		    __contacts.dialogue.dialogueFont = loc_get_font("fnt_main")
		    __contacts._speed = 0.95;
		    __contacts.dialogue.dialogueText = _contactslist
		    __contacts.dialoguePosition = "none"
		    __contacts.typist.skip();
    
		    // draw options
		    draw_ftext(loc_get_font(fnt_main_small), c_white, 98, 200, 2, 2, 0, loc_gettext("ui.item"))
		    draw_ftext(loc_get_font(fnt_main_small), c_white, 98, 232, 2, 2, 0, loc_gettext("ui.stat"))
		    if (inven_get_item_by_name("CELL_PHONE") != noone){
		        draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_yellow : c_white, 98, 264, 2, 2, 0, loc_gettext("ui.cell"))
		    }
		break;
		
		case 4:
			draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos+150,y+33+_menu_contact_choice_selection*29+64,2,2,0,c_red,1) // KEEP: Only draws for active contact choice
			// REMOVED: draw_sprite_ext(spr_heart_sm,0,x+selCursorXPos,y+208+_menu_selection*32,2,2,0,c_red,1)
			
			_contactchoices = ""
			
			// Get the contact data first
			var _contact_key = _contacts[_menu_contact_selection];
			var _contact_data = global.CONTACTS[$ _contact_key];
			
			// Loop through available choices only
			for (var i = 0; i < array_length(_contact_data.CHOICES); i++) {
			    var choice_text = _contact_data.CHOICES[i];
			    _contactchoices += (_menu_contact_choice_selection == i ? "[c_yellow]" : "[c_white]") + choice_text + "[scale,1][/c]#";
			}
			
			if !instance_exists(__contacts_call_choices) { __contacts_call_choices = instance_create(255+20,30+58,obj_text_writer) }
			
			__contacts_call_choices.dialogue.dialogueFont = loc_get_font("fnt_main")
			__contacts_call_choices._speed = 0.95;
			__contacts_call_choices.dialogue.dialogueText=_contactchoices
			__contacts_call_choices.dialoguePosition="none"
			__contacts_call_choices.typist.skip();
			
			// draw options
			draw_ftext(loc_get_font(fnt_main_small),c_white ,98,200,2,2,0,loc_gettext("ui.item"))
			draw_ftext(loc_get_font(fnt_main_small),c_white,98,232,2,2,0,loc_gettext("ui.stat"))
			if (inven_get_item_by_name("CELL_PHONE") != noone){
			    draw_ftext(loc_get_font(fnt_main_small), _menu_selection == 2 ? c_yellow : c_white,98,264,2,2,0,loc_gettext("ui.cell"))
			}
		break;
	}
}

#endregion