if(live_call()) return live_result;
refresh_save_slot_data()
HEART.visible=true;

switch(state){
	#region Select Save Slot
	case "selectFile":
		outline_set_text();
		draw_ftext(loc_get_font(fnt_main_small),c_white,x-328,y,2,2,0,loc_gettext("file_select_instructions"))
		draw_ftext(loc_get_font(fnt_main_small),_menued == 3 ? c_yellow : c_white,x-332,y+390,2,2,0,loc_gettext("copy_button"))
		draw_ftext(loc_get_font(fnt_main_small),_menued == 4 ? c_yellow : c_white,x-140,y+390,2,2,0,loc_gettext("erase_button"))
		draw_ftext(loc_get_font(fnt_main_small),_menued == 5 ? c_yellow : c_white,x+20,y+390,2,2,0,loc_gettext("end_program_button"))
		draw_set_colour(c_white)
		outline_end();
    
		for(var i = 0; i < 3; ++i){
			var is_selected = (i == _menued);
    
		    // Determine opacities
		    var inner_alpha = is_selected ? _slotOpacityBG : 0.3;
		    var outer_alpha = is_selected ? _slotOpacity : 0.2;
			
			// Get party name from pre-loaded array
		    var party_name = global.party_names[i];
			
			var playtime_display = global.party_times[i];
			 var room_name_display = global.party_rooms[i];
    
		    // Load full party data only if this slot is selected AND file exists
		    if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
		        var buf = buffer_load("PARTYINFO" + string(i));
		        var json = buffer_read(buf, buffer_text);
		        global.PARTY_INFO = json_parse(json);
		        buffer_delete(buf);
		    }
    
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,310,170*i/1.5+120,10,2.3,0,c_white,inner_alpha)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,310,170*i/1.5+120,10,2.3,0,c_white,outer_alpha)
		   draw_set_alpha(outer_alpha)
		   draw_text_transformed(110+6+20+20,20*i*5.8+87,string_upper(party_name),2,2,0)
		   draw_text_transformed(110+6+20+20,20*i*5.8+130,room_name_display,2,2,0)
		   draw_text_transformed(392+4+20+20,20*i*5.8+87,playtime_display,2,2,0)
		   draw_set_alpha(1)
		   
		     if (_menued < 3){
		   	draw_sprite_ext(spr_heart_sm,0,x-280,y+80+_menued*110,2,2,0,c_red,1)
			 } else {
				 switch(_menued){
						case 3:
							draw_sprite_ext(spr_heart_sm,0,x-705+_menued*115,y+398,2,2,0,c_red,1)
						break;
						case 4:
							draw_sprite_ext(spr_heart_sm,0,x-705+_menued*135,y+398,2,2,0,c_red,1)
						break;
						case 5:
							draw_sprite_ext(spr_heart_sm,0,x-705+_menued*140,y+398,2,2,0,c_red,1)
						break;
				 }
				 
			 }
		}
	break;
	#endregion
	
	#region Confirm Choice
	case "confirmChoice":
	    outline_set_text();
		   // Draw different instruction based on mode
	    if (reset_mode) {
	        draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, 
	                   loc_gettext("reset_mode_prompt"))
	    } else {
	        draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, 
	                   loc_gettext("file_select_instructions"))
	    }
			draw_set_alpha(0.5)
	    draw_ftext(loc_get_font(fnt_main_small),c_gray, x-332, y+390, 2, 2, 0, loc_gettext("copy_button"))
	    draw_ftext(loc_get_font(fnt_main_small),c_gray, x-140, y+390, 2, 2, 0, loc_gettext("erase_button"))
	    draw_ftext(loc_get_font(fnt_main_small),c_gray, x+20, y+390, 2, 2, 0, loc_gettext("end_program_button"))
	    draw_set_alpha(1)
		draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
        
	        // Determine opacities
	        var inner_alpha = is_selected ? _slotOpacityBG : 0.3;
	        var outer_alpha = is_selected ? _slotOpacity : 0.2;
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // SHOW ROOM NAME FOR NON-SELECTED SLOTS, HIDE FOR SELECTED
	        if (is_selected) {
	            // Hide room name for selected slot (show nothing or dashes)
	            room_name_display = "";  // Or "------------" if you prefer dashes
	        } else {
	            // Show room name for non-selected slots
	            // (room_name_display already has the value from global.party_rooms[i])
	        }
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 310, 170*i/1.5+120, 10, 2.3, 0, c_white, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 310, 170*i/1.5+120, 10, 2.3, 0, c_white, outer_alpha)
	        draw_set_alpha(outer_alpha)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
        
	        // Only draw room name if not selected AND not empty
	        if (!is_selected && room_name_display != "") {
	            draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        }
			
				 // Draw options
	        if(is_selected && file_exists("file"+string(_menued_cache))){
	            if (reset_mode) {
	                // Reset mode: RESET (red), CONTINUE (white), BACK (white)
	                var reset_colour = _menued == 0 ? c_yellow : c_red;
	                var back_colour = _menued == 1 ? c_yellow : c_gray;
                
	                draw_ftext(loc_get_font(fnt_main_small), reset_colour, 
	                            x-190, 20*i*5.8+130, 2, 2, 0, loc_gettext("reset_button"))
	                draw_ftext(loc_get_font(fnt_main_small), back_colour, 
	                           x-15, 20*i*5.8+130, 2, 2, 0, loc_gettext("back_button"))
	            } else {
	                // Normal mode: CONTINUE (white), BACK (white)
	                draw_ftext(loc_get_font(fnt_main_small), _menued == 0 ? c_yellow : c_gray, 
	                           x-190, 20*i*5.8+130, 2, 2, 0, loc_gettext("continue_button"))
	                draw_ftext(loc_get_font(fnt_main_small), _menued == 1 ? c_yellow : c_gray, 
	                           x-15, 20*i*5.8+130, 2, 2, 0, loc_gettext("back_button"))
	            }
	            draw_set_colour(c_white)
	        } else if(is_selected && !file_exists("file"+string(_menued_cache))){
	            // New game slot (unchanged)
	            draw_ftext(loc_get_font(fnt_main_small), _menued == 0 ? c_yellow : c_gray, 
	                       x-190, 20*i*5.8+130, 2, 2, 0, loc_gettext("start_button"))
	            draw_ftext(loc_get_font(fnt_main_small), _menued == 1 ? c_yellow : c_gray, 
	                       x-15, 20*i*5.8+130, 2, 2, 0, loc_gettext("back_button"))
	            draw_set_colour(c_white)
	        }
			    
	        draw_text_transformed(392+4+20+20, 20*i*5.8+87, playtime_display, 2, 2, 0)
	        draw_set_alpha(1)
	    }
	break;
	#endregion
	
	#region Initiate Save Copying
	case "copySave":
		outline_set_text();
		draw_ftext(loc_get_font(fnt_main_small),c_white,x-328,y,2,2,0,loc_gettext("choose_file_to_copy"))
		draw_ftext(loc_get_font(fnt_main_small),_menued == 3 ? c_yellow : c_white,x-332,y+390,2,2,0,loc_gettext("cancel_button"))
		draw_set_colour(c_white)
		outline_end();
    
		for(var i = 0; i < 3; ++i){
			var is_selected = (i == _menued);
    
		    // Determine opacities
		    var inner_alpha = is_selected ? _slotOpacityBG : 0.3;
		    var outer_alpha = is_selected ? _slotOpacity : 0.2;
			
			// Get party name from pre-loaded array
		    var party_name = global.party_names[i];
			
			var playtime_display = global.party_times[i];
			 var room_name_display = global.party_rooms[i];
    
		    // Load full party data only if this slot is selected AND file exists
		    if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
		        var buf = buffer_load("PARTYINFO" + string(i));
		        var json = buffer_read(buf, buffer_text);
		        global.PARTY_INFO = json_parse(json);
		        buffer_delete(buf);
		    }
    
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,310,170*i/1.5+120,10,2.3,0,c_white,inner_alpha)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,310,170*i/1.5+120,10,2.3,0,c_white,outer_alpha)
		   draw_set_alpha(outer_alpha)
		   draw_text_transformed(110+6+20+20,20*i*5.8+87,string_upper(party_name),2,2,0)
		   draw_text_transformed(110+6+20+20,20*i*5.8+130,room_name_display,2,2,0)
		   draw_text_transformed(392+4+20+20,20*i*5.8+87,playtime_display,2,2,0)
		   draw_set_alpha(1)
		}
	break;
	#endregion
	
	#region Select File to Copy To
	case "copySaveTo":
	    outline_set_text();
	    draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, loc_gettext("choose_file_to_copy_to"))
	    draw_ftext(loc_get_font(fnt_main_small), _menued == 3 ? c_yellow : c_white, x-332, y+390, 2, 2, 0, loc_gettext("cancel_button"))
	    draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
	        var is_selecting = (i == _menued);
        
	        // Determine opacities - SELECTED SLOT ALWAYS HAS ALPHA 1
	        var inner_alpha = 1;
	        var outer_alpha = 1;
        
	        // For non-selected slots, use the normal opacity logic
	        if (!is_selected) {
	            inner_alpha = is_selecting ? _slotOpacityBG : 0.3;
	            outer_alpha = is_selecting ? _slotOpacity : 0.2;
	        }
        
	        var copy_colour = is_selected ? c_yellow : c_white
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, outer_alpha)
	        draw_set_alpha(outer_alpha)
	        draw_set_colour(copy_colour)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        draw_text_transformed(392+4+20+20, 20*i*5.8+87, playtime_display, 2, 2, 0)
	        draw_set_alpha(1)
	        draw_set_colour(c_white)
	    }
	break;
	#endregion
	
	#region Failed to Copy File (Data Already Exist)
	case "copySaveFail":
	    outline_set_text();
	    draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, loc_gettext("cannot_copy_there"))
	    draw_ftext(loc_get_font(fnt_main_small), _menued == 3 ? c_yellow : c_white, x-332, y+390, 2, 2, 0, loc_gettext("cancel_button"))
	    draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
	        var is_selecting = (i == _menued);
        
	        // Determine opacities - SELECTED SLOT ALWAYS HAS ALPHA 1
	        var inner_alpha = 1;
	        var outer_alpha = 1;
        
	        // For non-selected slots, use the normal opacity logic
	        if (!is_selected) {
	            inner_alpha = is_selecting ? _slotOpacityBG : 0.3;
	            outer_alpha = is_selecting ? _slotOpacity : 0.2;
	        }
        
	        var copy_colour = is_selected ? c_yellow : c_white
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, outer_alpha)
	        draw_set_alpha(outer_alpha)
	        draw_set_colour(copy_colour)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        draw_text_transformed(392+4+20+20, 20*i*5.8+87, playtime_display, 2, 2, 0)
	        draw_set_alpha(1)
	        draw_set_colour(c_white)
	    }
	break;
	#endregion
	
	#region Succeded in Copying File
	case "copySaveComplete":
	    outline_set_text();
	    draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, loc_gettext("copy_complete"))
	    draw_ftext(loc_get_font(fnt_main_small), _menued == 3 ? c_yellow : c_white, x-332, y+390, 2, 2, 0, loc_gettext("cancel_button"))
	    draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
	        var is_selecting = (i == _menued);
        
	        // Determine opacities - SELECTED SLOT ALWAYS HAS ALPHA 1
	        var inner_alpha = 1;
	        var outer_alpha = 1;
        
	        // For non-selected slots, use the normal opacity logic
	        if (!is_selected) {
	            inner_alpha = is_selecting ? _slotOpacityBG : 0.3;
	            outer_alpha = is_selecting ? _slotOpacity : 0.2;
	        }
        
	        var copy_colour = is_selected ? c_yellow : c_white
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, outer_alpha)
	        draw_set_alpha(outer_alpha)
	        draw_set_colour(copy_colour)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
	        draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        draw_text_transformed(392+4+20+20, 20*i*5.8+87, playtime_display, 2, 2, 0)
	        draw_set_alpha(1)
	        draw_set_colour(c_white)
	    }
	break;
	#endregion
	
	#region Initiate Save Erasing
	case "eraseSelect":
		outline_set_text();
		draw_ftext(loc_get_font(fnt_main_small),c_white,x-328,y,2,2,0,loc_gettext("choose_file_to_erase"))
		draw_ftext(loc_get_font(fnt_main_small),_menued == 3 ? c_yellow : c_white,x-332,y+390,2,2,0,loc_gettext("cancel_button"))
		draw_set_colour(c_white)
		outline_end();
    
		for(var i = 0; i < 3; ++i){
			var is_selected = (i == _menued);
    
		    // Determine opacities
		    var inner_alpha = is_selected ? _slotOpacityBG : 0.3;
		    var outer_alpha = is_selected ? _slotOpacity : 0.2;
			
			// Get party name from pre-loaded array
		    var party_name = global.party_names[i];
			
			var playtime_display = global.party_times[i];
			 var room_name_display = global.party_rooms[i];
    
		    // Load full party data only if this slot is selected AND file exists
		    if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
		        var buf = buffer_load("PARTYINFO" + string(i));
		        var json = buffer_read(buf, buffer_text);
		        global.PARTY_INFO = json_parse(json);
		        buffer_delete(buf);
		    }
    
			draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner,0,310,170*i/1.5+120,10,2.3,0,c_white,inner_alpha)
			draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer,0,310,170*i/1.5+120,10,2.3,0,c_white,outer_alpha)
		   draw_set_alpha(outer_alpha)
		   draw_text_transformed(110+6+20+20,20*i*5.8+87,string_upper(party_name),2,2,0)
		   draw_text_transformed(110+6+20+20,20*i*5.8+130,room_name_display,2,2,0)
		   draw_text_transformed(392+4+20+20,20*i*5.8+87,playtime_display,2,2,0)
		   draw_set_alpha(1)
		}
	break;
	#endregion
	
	#region Confirm Erase Choice
	case "confirmEraseChoice":
	    outline_set_text();
	    draw_ftext(loc_get_font(fnt_main_small),c_white, x-328, y, 2, 2, 0, loc_gettext("choose_file_to_erase"))
		draw_set_alpha(0.5)
	    draw_ftext(loc_get_font(fnt_main_small),c_gray, x-332, y+390, 2, 2, 0, loc_gettext("cancel_button"))
	    draw_set_alpha(1)
		draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
        
	        // Determine opacities
	        var inner_alpha = is_selected ? _slotOpacityBG : 0.3;
	        var outer_alpha = is_selected ? _slotOpacity : 0.2;
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // SHOW ROOM NAME FOR NON-SELECTED SLOTS, HIDE FOR SELECTED
	        if (is_selected) {
	            // Hide room name for selected slot (show nothing or dashes)
	            room_name_display = "";  // Or "------------" if you prefer dashes
	        } else {
	            // Show room name for non-selected slots
	            // (room_name_display already has the value from global.party_rooms[i])
	        }
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 0, 310, 170*i/1.5+120, 10, 2.3, 0, c_white, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 0, 310, 170*i/1.5+120, 10, 2.3, 0, c_white, outer_alpha)
	        draw_set_alpha(outer_alpha)
			if (is_selected){
			   draw_text_transformed(110+6+20+20, 20*i*5.8+87, loc_gettext("erase_this_file_prompt"), 2, 2, 0)
			} else {
				draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
			}
        
	        // Only draw room name if not selected AND not empty
	        if (!is_selected && room_name_display != "") {
	            draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        }
			
			if(is_selected && file_exists("file"+string(_menued_cache))){
					 draw_ftext(loc_get_font(fnt_main_small), _menued == 0 ? c_yellow : c_gray, x-190, 20*i*5.8+130, 2, 2, 0, loc_gettext("yes_button"))
					 draw_ftext(loc_get_font(fnt_main_small), _menued == 1 ? c_yellow : c_gray, x-15, 20*i*5.8+130, 2, 2, 0, loc_gettext("no_button"))
					 draw_set_colour(c_white)
			} 
			 draw_set_colour(c_white)
			    
	        draw_set_alpha(1)
	    }
	break;
	#endregion
	
	#region Confirm Erase Choice (! LAST CHANCE !)
	case "confirmEraseChoiceLast":
	    outline_set_text();
	    draw_ftext(loc_get_font(fnt_main_small), c_white, x-328, y, 2, 2, 0, loc_gettext("choose_file_to_erase"))
	    draw_set_alpha(0.5)
	    draw_ftext(loc_get_font(fnt_main_small), c_gray, x-332, y+390, 2, 2, 0, loc_gettext("cancel_button"))
	    draw_set_alpha(1)
	    draw_set_colour(c_white)
	    outline_end();
    
	    for(var i = 0; i < 3; ++i){
	        var is_selected = (i == _menued_cache);
	        var is_selecting = (i == _menued);
        
	        // DETERMINE OPACITIES - NON-SELECTED SLOTS ARE LOW OPACITY
	        var inner_alpha = is_selected ? 1 : 0.2;    // Selected: 1, Others: 0.2
	        var outer_alpha = is_selected ? 1 : 0.15;   // Selected: 1, Others: 0.15
        
	        var copy_colour = is_selected ? c_red : c_gray  // Non-selected use gray
        
	        // Get party name from pre-loaded array
	        var party_name = global.party_names[i];
	        var playtime_display = global.party_times[i];
	        var room_name_display = global.party_rooms[i];
        
	        // SHOW ROOM NAME FOR NON-SELECTED SLOTS, HIDE FOR SELECTED
	        if (is_selected) {
	            // Hide room name for selected slot (show nothing or dashes)
	            room_name_display = "";  // Or "------------" if you prefer dashes
	        }
	        // Non-selected slots already have room_name_display from global.party_rooms[i]
        
	        // Load full party data only if this slot is selected AND file exists
	        if (is_selected && party_name != "[EMPTY]" && file_exists("PARTYINFO" + string(i))) {
	            var buf = buffer_load("PARTYINFO" + string(i));
	            var json = buffer_read(buf, buffer_text);
	            global.PARTY_INFO = json_parse(json);
	            buffer_delete(buf);
	        }
        
	        // Draw borders with low opacity for non-selected slots
	        draw_sprite_ext(global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner, 
	                        0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, inner_alpha)
	        draw_sprite_ext(global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer, 
	                        0, 310, 170*i/1.5+120, 10, 2.3, 0, copy_colour, outer_alpha)
        
	        draw_set_alpha(outer_alpha)
        
	        if (is_selected) {
	            draw_set_colour(c_red);
	            draw_text_transformed(110+6+20+20, 20*i*5.8+87, loc_gettext("really_erase_prompt"), 2, 2, 0)
	            draw_set_colour(c_white);
	        } else {
	            draw_set_colour(c_gray);  // Gray text for non-selected
	            draw_text_transformed(110+6+20+20, 20*i*5.8+87, string_upper(party_name), 2, 2, 0)
	        }
        
	        // Only draw room name if not selected AND not empty
	        if (!is_selected && room_name_display != "") {
	            draw_text_transformed(110+6+20+20, 20*i*5.8+130, room_name_display, 2, 2, 0)
	        }
        
	        if (is_selected && file_exists("file" + string(_menued_cache))) {
	            draw_ftext(loc_get_font(fnt_main_small), _menued == 0 ? c_yellow : c_gray, 
	                       x-190, 20*i*5.8+130, 2, 2, 0, loc_gettext("choice.yes.loud"))
	            draw_ftext(loc_get_font(fnt_main_small), _menued == 1 ? c_yellow : c_gray, 
	                       x-15, 20*i*5.8+130, 2, 2, 0, loc_gettext("choice.no.loud"))
	            draw_set_colour(c_white)
	        }
        
	        draw_set_colour(c_white)
	        draw_set_alpha(1)
	    }
	break;	
	#endregion
}