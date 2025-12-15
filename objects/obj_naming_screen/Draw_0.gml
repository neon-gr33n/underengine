draw_set_alpha(0.8);
draw_rectangle_color(0, 0, window_get_width(), window_get_height(), c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

if (!checkingName) {
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var is_japanese = lang_info.name == "JAPANESE";
    
    if (!is_japanese) {
        // For all non-Japanese languages, use English-style interface
        // Use naming_rows for non-Japanese languages (uppercase or lowercase based on toggle)
        if (global.english_caps_toggle) {
            naming_rows = naming_rows_upper;
        } else {
            naming_rows = naming_rows_lower;
        }
        _current_charset = naming_rows;
        draw_character_grid(x, y, typist);
        
        // Draw capitalization indicator for non-Japanese languages
        var caps_indicator = global.english_caps_toggle ? "ABC" : "abc";
        var caps_width = string_width("[" + caps_indicator + "]");
        var caps_x = x + 400 - caps_width - 10; // Right-aligned
        draw_text(caps_x, y - 30, "[" + caps_indicator + "]");
    } else {
        // Japanese-specific handling
        switch(_charset) {
            case 0: _current_charset = hiragana_rows; break;
            case 1: _current_charset = katakana_rows; break;
            case 2: 
                // For alphabet mode in Japanese, apply capitalization toggle
                if (global.japanese_alpha_caps_toggle) {
                    naming_rows = naming_rows_upper;
                } else {
                    naming_rows = naming_rows_lower;
                }
                _current_charset = naming_rows;
                
                // Draw capitalization indicator for Japanese alphabet mode
                var caps_indicator = global.japanese_alpha_caps_toggle ? "ABC" : "abc";
                var caps_width = string_width("[" + caps_indicator + "]");
                var caps_x = x + 400 - caps_width - 10; // Right-aligned
                draw_text(caps_x, y - 30, "[" + caps_indicator + "]");
                break;
        }
        draw_character_grid(x, y, typist);
    }
}
