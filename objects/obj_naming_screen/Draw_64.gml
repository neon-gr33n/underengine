if (live_call()) return live_result;

if (!checkingName) {
    // Get current language info from LANGUAGE_CONFIG
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var is_japanese = lang_info.name == "JAPANESE";
    
    // Use Japanese font only for Japanese, otherwise use regular font
    var font = is_japanese ? "[fnt_main_bt_jp]" : "[fnt_main_bt]";
    var font_index = is_japanese ? asset_get_index("fnt_main_bt_jp") : asset_get_index("fnt_main_bt");
    
    // Draw title and current name
    draw_text_scribble(x + (is_japanese ? -45 : 65), y - 30, font + "[wave][shake]" + loc_gettext("ui.naming.main") + "[/shake][/wave]");
    draw_text_scribble(x + 145, y + 15, font + "[shake]" + chr(34) + _currentNameEntry + chr(34) + "[/shake]");
    
    // Determine if we're on control row
    var on_control_row = (!is_japanese) ? (english_char_y == 4) : (japanese_nav_state == 2);
    
    // For non-Japanese languages, use English-style controls with dynamic spacing
    if (!is_japanese) {
        // English control buttons for all non-Japanese languages
        var controls = ["ui.title.quit", "ui.naming.clear", "ui.naming.randomize", "choice.accept"];
        var control_texts = [];
        var control_widths = [];
        var total_width = 0;
        var separator_width = calculate_text_width(" | ", font_index);
        
        // Get the actual text and widths for each control
        for (var i = 0; i < 4; i++) {
            control_texts[i] = loc_gettext(controls[i]);
            control_widths[i] = calculate_text_width(control_texts[i], font_index);
            total_width += control_widths[i];
        }
        
        // Add separator widths (3 separators between 4 items)
        total_width += separator_width * 3;
        
        // Calculate starting position to center the controls
        var start_x = x + (400 - total_width) / 2; // Assuming 400px width area
        
        // Draw controls with dynamic spacing
        var current_x = start_x;
        for (var i = 0; i < 4; i++) {
            var highlight = (english_char_y == 4 && english_control_sel == i) ? "[c_yellow]" : "";
            var end_tag = (english_char_y == 4 && english_control_sel == i) ? "[/c]" : "";
            
            draw_text_scribble(current_x, y + 240, 
                font + "[shake]" + highlight + control_texts[i] + end_tag + "[/shake]");
            
            // Move to next position
            current_x += control_widths[i];
            
            // Draw separator if not the last item
            if (i < 3) {
                draw_text_scribble(current_x, y + 240, font + "[shake]|[/shake]");
                current_x += separator_width;
            }
        }
    }
    
   if (is_japanese) {
    // Japanese character set selection - highlight if selected on charset row
    var charsets = ["ひらがな", "カタカナ", "アルファベット"];
    var charset_x = [x - 70, x + 100, x + 270];
    
    for (var i = 0; i < 3; i++) {
        var highlight = "";
        var end_tag = "";
        
        if (japanese_nav_state == 1) {
            // On charset selection row - highlight the selected one
            highlight = (japanese_charset_selection == i) ? "[c_yellow]" : "";
            end_tag = (japanese_charset_selection == i) ? "[/c]" : "";
        } else {
            // Not on charset row - show current charset without highlight
            highlight = "";
            end_tag = "";
        }
        
        draw_text_scribble(charset_x[i], y + 255, 
            font + "[shake]" + highlight + charsets[i] + end_tag + "[/shake]");
    }
    
    // Japanese control buttons (lower position) - use original fixed spacing
    var controls = ["ui.title.quit", "ui.naming.clear", "ui.naming.randomize", "choice.accept"];
    var control_x = [x-110, x + 85, x + 240, x + 380];
    var separator_x = [x + 55, x + 200, x + 350];
    
	 for (var i = 0; i < 4; i++) {
	        var highlight = (japanese_nav_state == 2 && english_control_sel == i) ? "[c_yellow]" : "";
	        var end_tag = (japanese_nav_state == 2 && english_control_sel == i) ? "[/c]" : "";
        
	        draw_text_scribble(control_x[i], y + 320, 
	            font + "[shake]" + highlight + loc_gettext(controls[i]) + end_tag + "[/shake]");
        
	        if (i < 3) {
	            draw_text_scribble(separator_x[i], y + 320, font + "[shake]|[/shake]");
	        }
	    }
	}
} else {
    // Confirmation mode
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var is_japanese = lang_info.name == "JAPANESE";
    var font = is_japanese ? "[fnt_main_bt_jp]" : "[fnt_main_bt]";
    var font_index = is_japanese ? asset_get_index("fnt_main_bt_jp") : asset_get_index("fnt_main_bt");
    
    draw_text_scribble(x + 65, y - 30, font + _currentNameDescript);
    draw_ftext(loc_get_font(fnt_main_small), c_white, 410 + _confirm_name_offset_x + random(1), 200 + _confirm_name_offset_y + random(1),  0.5 + _confirm_name_scale, 0.5 + _confirm_name_scale, -random(2), _currentNameEntry);
    
   if (_validName) {
    // For Japanese, use original fixed positions
    if (is_japanese) {
        // Original fixed positions for Japanese
        draw_text_scribble(x + 65, y + 280, 
            _choice == 0 ? font + "[c_yellow]" + loc_gettext("choice.yes") + "[/c]" : font + loc_gettext("choice.yes"));
        draw_text_scribble(x + 290, y + 280, 
            _choice == 1 ? font + "[c_yellow]" + loc_gettext("choice.no") + "[/c]" : font + loc_gettext("choice.no"));
    } else {
        // For non-Japanese, use dynamic spacing
        var yes_text = loc_gettext("choice.yes");
        var no_text = loc_gettext("choice.no");
        var yes_width = calculate_text_width(yes_text, font_index);
        var no_width = calculate_text_width(no_text, font_index);
        var spacing = 50; // Minimum spacing between buttons
        
        var total_width = yes_width + no_width + spacing;
        var start_x = x + (400 - total_width) / 2;
        
        // Draw Yes button
        var yes_x = start_x;
        draw_text_scribble(yes_x, y + 280, 
            _choice == 0 ? font + "[c_yellow]" + yes_text + "[/c]" : font + yes_text);
        
        // Draw No button
        var no_x = start_x + yes_width + spacing;
        draw_text_scribble(no_x, y + 280, 
            _choice == 1 ? font + "[c_yellow]" + no_text + "[/c]" : font + no_text);
    }
} else {
    // For invalid name
    if (is_japanese) {
        // Original fixed position for Japanese
        draw_text_scribble(x + 65, y + 280, 
            _choice == 0 ? font + "[c_yellow]" + loc_gettext("choice.return") + "[/c]" : font + loc_gettext("choice.return"));
    } else {
        // For non-Japanese, center the return button
        var return_text = loc_gettext("choice.return");
        var return_width = calculate_text_width(return_text, font_index);
        var return_x = x + (400 - return_width) / 2;
        
        draw_text_scribble(return_x, y + 280, 
            _choice == 0 ? font + "[c_yellow]" + return_text + "[/c]" : font + return_text);
    }
}
}