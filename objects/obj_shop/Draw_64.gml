// obj_shop Draw GUI Event
// Skip if in initialization state
if (currentState == "initializing") {
    // Draw loading message
    draw_set_font(fnt_main);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_color(room_width / 2, room_height / 2, "Loading shop...", c_white, c_white, c_white, c_white, 1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    return;
}

// Live mode check
if (live_call()) return live_result;

switch (currentState) {
    #region Draw Shop Hub
    case "hub":
        // Draw left side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 162, 359, 7.3, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 162, 359, 7.3, 5.2, 0, c_white, 1);
        
        // Draw right side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 486, 359, 6.6, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 486, 359, 6.6, 5.2, 0, c_white, 1);
        
        // Draw menu options
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 0 ? c_yellow : c_white,
            400, 320 - 60, "Buy", 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 1 ? c_yellow : c_white,
            400, 360 - 60, "Sell", 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 2 ? c_yellow : c_white,
            400, 400 - 60, "Talk", 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSelection == 3 ? c_yellow : c_white,
            400, 440 - 60, "Exit", 25, 180, 2, 2, 0, 1);
        
        // Draw gold amount
        draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
            360, 480 - 60, string(player_get_gold()) + "G", 25, 180, 2, 2, 0, 1);
        
        // Draw cursor
        draw_sprite_ext(spr_heart_sm, 0, x + 360, y + 265 + _menuSelection * 40, 2, 2, 0, c_red, 1);
        
        // Draw dialogue text
        var scribble_object = scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", __text))
            .starting_format(global.characters[$ character].font, __color)
            .wrap(640 - x + y);
        
        if (visible) {
            scribble_object.draw(30, 260, typist);
        }
        
        if (_voiceSound != undefined) {
            typist.sound_per_char([_voiceSound], true, 1, 1);
        }
        
        // Draw player inventory space
        draw_ftext_transformed(fnt_dotumche, c_white,
            440, 488 - 60, "Space: " + string(inven_get_space_left()) + "/" + string(party_get_attribute("MAXINVSIZE")), 25, 180, 1, 1, 0, 1);
        break;
    #endregion
    
    #region Draw Shop Items
	case "shopItem":
	    var shop = ShopGetCurrent();
	    var available_items = shop ? shop.get_available_items() : [];
    
	    // Draw left side
	    draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 162, 359, 7.3, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
	    draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 162, 359, 7.3, 5.2, 0, c_white, 1);
    
	    // Draw right side
	    draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 486, 359, 6.6, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
	    draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 486, 359, 6.6, 5.2, 0, c_white, 1);
    
	    // Draw item info panel - ONLY if item is NOT sold out
	    if (showItemInfo && _menuItemSelection < array_length(available_items) && global.menu_qol_enabled == true) {
	        var selected_item = available_items[_menuItemSelection];
	        var is_sold_out = selected_item.can_sell_out && selected_item.current_stock == 0;
        
	        // Only show info panel if item is NOT sold out
	        if (!is_sold_out) {
	            draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 486, 125, 6.6, 5, 0, c_white, __DRAW_BOX_OPACITY);
	            draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 486, 125, 6.6, 5, 0, c_white, 1);
            
	            outline_set_text();
            
	            // Draw item type/category
	            draw_ftext_transformed(loc_get_font(fnt_main_small), c_yellow,
	                420, 95 - 60, selected_item.category, 25, 220, 2, 2, 0, 1);
            
	            // Draw item description (centered)
	            draw_set_halign(fa_center);
	            draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
	                490, 130 - 60, shop_find_category_subtitle(selected_item.category), 25, 220, 2, 2, 0, 1);
	            draw_set_halign(fa_left);
            
	            // Draw bonuses if they exist
	            if (selected_item.bonus_a != "") {
	                draw_ftext_transformed(loc_get_font(fnt_main_small), c_lime,
	                    430, 180 - 60, selected_item.bonus_a, 25, 220, 3, 3, 0, 1);
	            }
            
	            if (selected_item.bonus_b != "") {
	                draw_ftext_transformed(loc_get_font(fnt_main_small), c_lime,
	                    460, 230 - 60, selected_item.bonus_b, 25, 220, 2, 2, 0, 1);
	            }
            
	            outline_end();
	        }
	    }
    
	    // Draw item list
	    var yPos = 320 - 60;
	    for (var i = 0; i < array_length(available_items) + 1; i++) {
	        var color = _menuItemSelection == i ? c_yellow : c_white;
	        var displayText = "";
	        var is_sold_out = false;
        
	        if (i == array_length(available_items)) {
	            // Exit option
	            displayText = "Exit";
	        } else {
	            var item = available_items[i];
            
	            // Check if item is sold out
	            is_sold_out = item.can_sell_out && item.current_stock == 0;
            
	            if (is_sold_out) {
	                displayText = "-- SOLD OUT --";
	            } else {
	                displayText = string(item.price) + "G " + item.name;
	            }
	        }
        
	        // Draw the text with appropriate color
	        if (is_sold_out) {
	            // Sold out items are always gray, even when selected
	            draw_ftext_transformed(loc_get_font(fnt_main_small), c_gray,
	                70, yPos + (i * 40), displayText, 25, 180, 2, 2, 0, 1);
	        } else {
	            draw_ftext_transformed(loc_get_font(fnt_main_small), color,
	                70, yPos + (i * 40), displayText, 25, 180, 2, 2, 0, 1);
	        }
	    }
    
	    // Draw cursor - but NOT on sold out items
	    var current_item = _menuItemSelection;
	    if (current_item < array_length(available_items)) {
	        var item = available_items[current_item];
	        var is_sold_out = item.can_sell_out && item.current_stock == 0;
        
	        // Only draw cursor if item is NOT sold out (or it's the Exit option)
	        if (!is_sold_out) {
	            draw_sprite_ext(spr_heart_sm, 0, x + 30, y + 265 + current_item * 40, 2, 2, 0, c_red, 1);
	        }
	    } else {
	        // Draw cursor on Exit option
	        draw_sprite_ext(spr_heart_sm, 0, x + 30, y + 265 + current_item * 40, 2, 2, 0, c_red, 1);
	    }
    
	    // Draw shop prompt text
	    var scribble_object2 = scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", __text2))
	        .starting_format(global.characters[$ character].font, __color)
	        .wrap(640 - x + y);
    
	    if (visible) {
	        scribble_object2.draw(360, 260, typist2);
	    }
    
	    if (_voiceSound != undefined) {
	        typist.sound_per_char([_voiceSound], true, 1, 1);
	    }
    
	    // Draw player gold
	    draw_ftext_transformed(loc_get_font(fnt_main_small), c_white,
	        360, 480 - 60, string(party_get_stat("GOLD")) + "G", 25, 180, 2, 2, 0, 1);
    
	    // Draw player inventory space
	    draw_ftext_transformed(fnt_dotumche, c_white,
	        440, 488 - 60, "Space: " + string(inven_get_space_left()) + "/" + string(party_get_attribute("MAXINVSIZE")), 25, 180, 1, 1, 0, 1);
	    break;
	#endregion
    
    #region Draw Shop Sell Screen
    case "shopSell":
        // Draw left side (wider for inventory display)
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 311, 359, 13.8, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 311, 359, 13.8, 5.2, 0, c_white, 1);
        
        // Draw inventory items
        var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
        for (var i = 0; i < array_length(inventory); i++) {
            var cx = i < 4 ? 70 : 360;  // Left side for 0-3, right side for 4-7
            var cy = 320 - 60 + (i % 4) * 40;  // 320, 360, 400, 440 for each column
            
            // Draw item
            draw_item_safe(i, cx, cy);
            
            // Draw heart sprite next to selected slot
            if (_menuSellSelection == i) {
                var heart_x = cx - 40;  // Position heart to the left of the text
                var heart_y = cy + 5;   // Adjust vertically to align with text
                
                draw_sprite_ext(spr_heart_sm, 0, heart_x, heart_y, 2, 2, 0, c_red, 1);
            }
        }
        
        // Draw exit hint
        draw_ftext_transformed(fnt_main_small, c_gray,
            70, 480 - 60, "Press X to Exit", 25, 180, 2, 2, 0, 1);
        
        // Draw player gold with highlight
        draw_ftext_transformed(fnt_main_small, c_yellow,
            490, 480 - 60, "(" + string(party_get_stat("GOLD")) + "G" + ")", 25, 180, 2, 2, 0, 1);
        break;
    #endregion
    
    #region Draw Shop Talk Screen
    case "shopTalk":
        // Draw left side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 162, 359, 7.3, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 162, 359, 7.3, 5.2, 0, c_white, 1);
        
        // Draw right side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 486, 359, 6.6, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 486, 359, 6.6, 5.2, 0, c_white, 1);
        
        // Draw talk options
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 0 ? c_yellow : c_white,
            400, 320 - 60, talk_options[0], 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 1 ? c_yellow : c_white,
            400, 360 - 60, talk_options[1], 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 2 ? c_yellow : c_white,
            400, 400 - 60, talk_options[2], 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 3 ? c_yellow : c_white,
            400, 440 - 60, talk_options[3], 25, 180, 2, 2, 0, 1);
        draw_ftext_transformed(loc_get_font(fnt_main_small), _menuTalkSelection == 4 ? c_yellow : c_white,
            400, 480 - 60, talk_options[4], 25, 180, 2, 2, 0, 1);
        
        // Draw cursor
        draw_sprite_ext(spr_heart_sm, 0, x + 360, y + 265 + _menuTalkSelection * 40, 2, 2, 0, c_red, 1);
        
        if (_voiceSound != undefined) {
            typist.sound_per_char([_voiceSound], true, 1, 1);
        }
        break;
        
    case "shopTalkLock":
        // Draw left side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 162, 359, 7.3, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 162, 359, 7.3, 5.2, 0, c_white, 1);
        
        // Draw right side
        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 486, 359, 6.6, 5.2, 0, c_white, __DRAW_BOX_OPACITY);
        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 486, 359, 6.6, 5.2, 0, c_white, 1);
        
        // Get current dialogue
        var dialogueKey = "";
        switch (_menuTalkSelection) {
            case 0: dialogueKey = "OPT_A"; break;
            case 1: dialogueKey = "OPT_B"; break;
            case 2: dialogueKey = "OPT_C"; break;
            case 3: dialogueKey = "OPT_D"; break;
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
            
            var scribble_object = scribble(string_concat("[speed,0.2][scale,", global.characters[$ character].font_scale, "][", string(_alpha), "]", currentText))
                .starting_format(global.characters[$ character].font, __color)
                .wrap(640 - x + y);
            
            // Draw the dialogue text
            if (visible) {
                scribble_object.draw(30, 260, typist);
            }
        }
        break;
    #endregion
}