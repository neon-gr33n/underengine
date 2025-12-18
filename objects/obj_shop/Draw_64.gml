if(live_call()) return live_result;

switch(currentState){
	#region Draw Shop Hub
	case "hub":
			// Draw left side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,162,359,7.3,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,162,359,7.3,5.2,0,c_white,1)

		// Draw right side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,486,359,6.6,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,486,359,6.6,5.2,0,c_white,1)

		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 0 ? c_yellow : c_white, 
			400, 320 - 60, "Buy", 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 1 ? c_yellow : c_white,
			400, 360 - 60, "Sell", 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 2 ? c_yellow : c_white,
			400, 400 - 60, "Talk", 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 3 ? c_yellow : c_white,
			400, 440 - 60, "Exit", 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
			360, 480 - 60, string(player_get_gold()) + "G", 25, 180, 2,2, 0, 1)
			
		draw_sprite_ext(spr_heart_sm,0,x+360,y+265+_menuSelection*40,2,2,0,c_red,1)
		
		var scribble_object = scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", __text))
		    .starting_format(global.characters[$ character].font, __color)
		    .wrap(640 - x + y);
	
		if visible {
		    scribble_object.draw(30, 260, typist);
		}

		if _voiceSound != undefined {
		    typist.sound_per_char([_voiceSound], true, 1, 1);
		}
		
		// Draw player GOLD balance
		draw_ftext_transformed(fnt_main_small, c_white,
			360, 480 - 60, string(party_get_stat("GOLD")) + "G", 25, 180, 2,2, 0, 1)
			
		// Draw player inv space
			draw_ftext_transformed(fnt_dotumche, c_white,
			440, 488 - 60, "Space: "+string(inven_get_space_left())+"/"+string(party_get_attribute("MAXINVSIZE")), 25, 180, 1,1, 0, 1)

	break;
	#endregion
	#region Draw Shop Items
	case "shopItem":
				// Draw left side
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,162,359,7.3,5.2,0,c_white, __DRAW_BOX_OPACITY)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,162,359,7.3,5.2,0,c_white,1)

			// Draw right side
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,486,359,6.6,5.2,0,c_white, __DRAW_BOX_OPACITY)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,486,359,6.6,5.2,0,c_white,1)
			
			// Draw item info (Deltarune QOL port)
			if (showItemInfo){
				if (_menuItemSelection < 4) {
				draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,486,125,6.6,5,0,c_white, __DRAW_BOX_OPACITY)
				draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,486,125,6.6,5,0,c_white,1)
				}
				
				outline_set_text();
				if (_menuItemSelection < 4) {
			            draw_ftext_transformed(loc_get_font(fnt_main_small), c_yellow,
			                420, 95 - 60, buy_type[_menuItemSelection],25, 220, 2,2, 0, 1)
			            draw_set_halign(fa_center)
			            draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
			                490, 130 - 60, buy_desc[_menuItemSelection], 25, 220, 2,2, 0, 1)
			            draw_set_halign(fa_left)
			            draw_ftext_transformed(loc_get_font(fnt_main_small), c_lime,
			                430, 180 - 60, buy_bonus_a[_menuItemSelection], 25, 220, 3,3, 0, 1)
			            draw_ftext_transformed(loc_get_font(fnt_main_small), c_lime,
			                460, 230 - 60, buy_bonus_b[_menuItemSelection], 25, 220, 2,2, 0, 1)
			        }
				outline_end();
			}
			
			// Draw item and prices list
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuItemSelection == 0 ? c_yellow : c_white,
			70, 320 - 60, gold_options[0] + buy_options[0], 25, 180, 2,2, 0, 1)
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuItemSelection == 1 ? c_yellow : c_white,
			70, 360 - 60, gold_options[1] + buy_options[1], 25, 180, 2,2, 0, 1)
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuItemSelection == 2 ? c_yellow : c_white,
			70, 400 - 60, gold_options[2] + buy_options[2], 25, 180, 2,2, 0, 1)
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuItemSelection == 3 ? c_yellow : c_white,
			70, 440 - 60, gold_options[3] + buy_options[3], 25, 180, 2,2, 0, 1)
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuItemSelection == 4 ? c_yellow : c_white,
			70, 480 - 60, gold_options[4], 25, 180, 2,2, 0, 1)
			
			draw_sprite_ext(spr_heart_sm,0,x+30,y+265+_menuItemSelection*40,2,2,0,c_red,1)
			
			// Draw other text
			var scribble_object2 = scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", __text2))
				.starting_format(global.characters[$ character].font, __color)
				.wrap(640 - x + y);
	
		if visible {
			scribble_object2.draw(360, 260, typist2);
		}

		if _voiceSound != undefined {
		    typist.sound_per_char([_voiceSound], true, 1, 1);
		}
		
		// Draw player GOLD balance
		draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
			360, 480 - 60, string(party_get_stat("GOLD")) + "G", 25, 180, 2,2, 0, 1)
			
		// Draw player inv space
			draw_ftext_transformed(fnt_dotumche, c_white,
			440, 488 - 60, "Space: "+string(inven_get_space_left())+"/"+string(party_get_attribute("MAXINVSIZE")), 25, 180, 1,1, 0, 1)
	break;
	#endregion
	#region Draw Shop Sell Screen
	case "shopSell":
				// Draw left side
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,311,359,13.8,5.2,0,c_white, __DRAW_BOX_OPACITY)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,311,359,13.8,5.2,0,c_white,1)
		
			// Draw item and prices list
			for (var i=0; i < array_length(party_get_attribute("INVENTORY")); i++;){
						var cx = i < 4 ? 70 : 360;  // Left side for 0-3, right side for 4-7
						var cy = 320 - 60 + (i % 4) * 40;  // 320, 360, 400, 440 for each column
						draw_item_safe(i, cx, cy);
						
						// Draw heart sprite next to selected slot
					    if (_menuSellSelection == i) {
					        var heart_x = cx - 40;  // Position heart to the left of the text
					        var heart_y = cy + 5;   // Adjust vertically to align with text
        
					        draw_sprite_ext(spr_heart_sm, 0, heart_x, heart_y, 2, 2, 0, c_red, 1);
					    }
			}
			draw_ftext_transformed(fnt_main_small, c_gray,
			70, 480 - 60, "Press X to " + gold_options[4], 25, 180, 2,2, 0, 1)
		
		// Draw player GOLD balance
		draw_ftext_transformed(fnt_main_small, c_yellow,
			490, 480 - 60, "(" + string(party_get_stat("GOLD")) + "G" +")", 25, 180, 2,2, 0, 1)
	break;
	#endregion
	#region Draw Shop Talk Screen
	case "shopTalk":
			// Draw left side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,162,359,7.3,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,162,359,7.3,5.2,0,c_white,1)

		// Draw right side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,486,359,6.6,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,486,359,6.6,5.2,0,c_white,1)

		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 0 ? c_yellow : c_white, 
			400, 320 - 60, talk_options[0], 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 1 ? c_yellow : c_white,
			400, 360 - 60, talk_options[1], 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 2 ? c_yellow : c_white,
			400, 400 - 60, talk_options[2], 25, 180, 2,2, 0, 1)
	
		draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 3 ? c_yellow : c_white,
			400, 440 - 60, talk_options[3], 25, 180, 2,2, 0, 1)
			
			draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 4 ? c_yellow : c_white,
			400, 480 - 60, talk_options[4], 25, 180, 2,2, 0, 1)
	
		draw_sprite_ext(spr_heart_sm,0,x+360,y+265+_menuTalkSelection*40,2,2,0,c_red,1)
		if _voiceSound != undefined {
		    typist.sound_per_char([_voiceSound], true, 1, 1);
		}
	break;
	case "shopTalkLock":
			// Draw left side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,162,359,7.3,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,162,359,7.3,5.2,0,c_white,1)

		// Draw right side
		draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,486,359,6.6,5.2,0,c_white, __DRAW_BOX_OPACITY)
		draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,486,359,6.6,5.2,0,c_white,1)
		
		// In draw event
		var dialogueKey = "";
		switch (_menuTalkSelection) {
		    case 0: dialogueKey = "OPT_A"; break;
		    case 1: dialogueKey = "OPT_B"; break;
		    case 2: dialogueKey = "OPT_C"; break;
			case 3: dialogueKey = "OPT_D"; break;
		    // Add more cases as needed
		}

		if (dialogueKey != "") {
		    var currentText = "No dialogue available";
    
		    // Check if the key exists and get the text
		    if (variable_struct_exists(talkDialogue, dialogueKey)) {
		        var dialogueArray = talkDialogue[$ dialogueKey];
        
		        if (is_array(dialogueArray) && array_length(dialogueArray) > 0) {
		            // Get the current index for this dialogue key
		            if (!variable_global_exists("dialogueIndex_" + dialogueKey)) {
		                global[$ "dialogueIndex_" + dialogueKey] = 0;
		            }
            
		            var dialogueIndex = global[$ "dialogueIndex_" + dialogueKey];
		            currentText = dialogueArray[dialogueIndex];
		        }
		    }
    
		    var scribble_object =  scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", currentText))
		        .starting_format(global.characters[$ character].font, __color) 
		        .wrap(640 - x + y);
    
		    // YOU NEED TO ACTUALLY DRAW THE SCRIBBLE OBJECT
		    if (visible) {
		        scribble_object.draw(30, 260, typist); // Adjust x, y positions as needed
		    }
		}
	break;
	#endregion
	}