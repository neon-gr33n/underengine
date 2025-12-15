var charIndex = 0;

// Gaster easter egg
if (_currentNameEntry == "gaster" || _currentNameEntry == "GASTER" || _currentNameEntry == "Gaster") {
    game_restart();
}

// ===== CAPITALIZATION TOGGLE HANDLING =====
if (input.menu_pressed && !checkingName && !nameConfirmed) {
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var is_japanese = lang_info.name == "JAPANESE";
    
    if (!is_japanese) {
        // For all non-Japanese languages
        global.english_caps_toggle = !global.english_caps_toggle;
        sfx_play(snd_menu_switch);
    } else if (is_japanese && _charset == 2) {
        // Only toggle caps when in alphabet mode in Japanese
        global.japanese_alpha_caps_toggle = !global.japanese_alpha_caps_toggle;
        sfx_play(snd_menu_switch);
    }
}

// ===== CONFIRMATION MODE NAVIGATION =====
if (checkingName && !nameConfirmed && _validName && (input.right_pressed || input.left_pressed)) {
    _choice = (_choice + 1) % 2;
    sfx_play(snd_menu_switch);
}

// ===== REGULAR MODE NAVIGATION =====
if ((input.right_pressed || input.left_pressed || input.down_pressed || input.up_pressed) && !nameConfirmed && !checkingName) {
    sfx_play(snd_menu_switch);
    
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var is_japanese = lang_info.name == "JAPANESE";
    
    if (!is_japanese) {
        // NON-JAPANESE LANGUAGES NAVIGATION: Character grid → Control row
        if (english_char_y < 4) {
            // We're in the letter grid
            // Save current charset and set to naming_rows
            var temp_charset = _current_charset;
            _current_charset = naming_rows;
            
            if (input.right_pressed) {
                move_selection_right();
                english_char_x = char_x;
                english_char_y = char_y;
            }
            else if (input.left_pressed) {
                move_selection_left();
                english_char_x = char_x;
                english_char_y = char_y;
            }
            else if (input.down_pressed) {
                // Check if we can move down within the grid
                var rows = array_length(_current_charset);
                if (char_y < rows - 1) {
                    move_selection_down();
                    english_char_x = char_x;
                    english_char_y = char_y;
                } else {
                    // At last row, move to control row
                    english_char_y = 4;
                    english_control_sel = 0; // Start on QUIT
                }
            }
            else if (input.up_pressed) {
                move_selection_up();
                english_char_x = char_x;
                english_char_y = char_y;
            }
            
            // Restore original charset
            _current_charset = temp_charset;
        } else {
            // We're on the control row (row 4)
            if (input.right_pressed) {
                english_control_sel = (english_control_sel + 1) % 4;
            }
            else if (input.left_pressed) {
                english_control_sel = (english_control_sel - 1 + 4) % 4;
            }
            else if (input.down_pressed) {
                // Already on control row - can't go further down
            }
            else if (input.up_pressed) {
                // Move back up to last letter row
                english_char_y = array_length(naming_rows) - 1;
                // Update char_y to match
                char_y = english_char_y;
                // Center selection
                var last_row = naming_rows[english_char_y];
                english_char_x = floor(string_length(last_row) / 2);
                char_x = english_char_x;
            }
        }
    } else {
        // JAPANESE NAVIGATION: Character grid → Charset row → Control row
        // japanese_nav_state: 0=character grid, 1=charset row, 2=control row
        
        if (japanese_nav_state == 0) {
            // In character grid (STARTING STATE)
            if (input.right_pressed) {
                move_selection_right();
            }
            else if (input.left_pressed) {
                move_selection_left();
            }
            else if (input.down_pressed) {
                // Check if we can move down within the grid
                var rows = array_length(_current_charset);
                if (char_y < rows - 1) {
                    move_selection_down();
                } else {
                    // At last row, move to charset selection
                    japanese_nav_state = 1;
                    // Highlight current charset
                    japanese_charset_selection = _charset;
                }
            }
            else if (input.up_pressed) {
                move_selection_up();
            }
        }
        else if (japanese_nav_state == 1) {
            // On charset selection row (ひらがな, カタカナ, アルファベット)
            if (input.right_pressed) {
                japanese_charset_selection = (japanese_charset_selection + 1) % 3;
            }
            else if (input.left_pressed) {
                japanese_charset_selection = (japanese_charset_selection - 1 + 3) % 3;
            }
            else if (input.down_pressed) {
                // Move down from charset selection to control row
                japanese_nav_state = 2;
                english_control_sel = 0; // Start on QUIT
            }
            else if (input.up_pressed) {
                // Move up from charset selection back to character grid
                japanese_nav_state = 0;
                // Go to last row of current charset
                char_y = array_length(_current_charset) - 1;
                // Center selection
                var last_row = _current_charset[char_y];
                char_x = floor(string_length(last_row) / 2);
            }
        }
        else if (japanese_nav_state == 2) {
            // On control row
            if (input.right_pressed) {
                english_control_sel = (english_control_sel + 1) % 4;
            }
            else if (input.left_pressed) {
                english_control_sel = (english_control_sel - 1 + 4) % 4;
            }
            else if (input.down_pressed) {
                // Already on bottom - can't go further down
            }
            else if (input.up_pressed) {
                // Move up from control row to charset selection
                japanese_nav_state = 1;
            }
        }
    }
}

// ===== ACTION BUTTON HANDLING =====
if (input.action_pressed && !nameConfirmed) {
    if (!checkingName) {
        var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
        var is_japanese = lang_info.name == "JAPANESE";
        
        if (!is_japanese) {
            // NON-JAPANESE LANGUAGES
            if (english_char_y < 4) {
                // LETTER SELECTED
                if (string_length(_currentNameEntry) < 6) {
                    _currentNameEntry += get_selected_letter();
                    sfx_play(snd_menu_select);
                } else {
                    sfx_play(snd_error);
                }
            } else {
                // CONTROL BUTTON SELECTED
                switch(english_control_sel) {
                    case 0: // QUIT
                        room_goto(rm_loadgame);
                        sfx_play(snd_menu_select);
                        break;
                        
                    case 1: // CLEAR
                        _currentNameEntry = "";
                        sfx_play(snd_menu_select);
                        break;
                        
                    case 2: // RANDOMIZE
                        ds_list_shuffle(randomizedName);
                        randomize();
                        _currentNameEntry = string(ds_list_find_value(randomizedName, r));
                        sfx_play(snd_menu_switch);
                        break;
                        
                    case 3: // ACCEPT
                        if (_currentNameEntry != "") {
                            // Always reset _validName when entering confirmation
                            if (!global.just_reset) {
                                _validName = false;
                            }
                            checkingName = true;
                            if (!global.just_reset) { // Disable the naming descriptions if we just reset
                                check_current_entry(string_lower(_currentNameEntry));
                            }
                            sfx_play(snd_menu_select);
                        } else {
                            sfx_play(snd_error);
                        }
                        break;
                }
            }
        } else {
            // JAPANESE MODE
            if (japanese_nav_state == 0) {
                // In character grid
                if (string_length(_currentNameEntry) < 6) {
                    _currentNameEntry += get_selected_letter();
                    sfx_play(snd_menu_select);
                } else {
                    sfx_play(snd_error);
                }
            }
            else if (japanese_nav_state == 1) {
                // On charset selection row - pressing action switches to selected charset
                _charset = japanese_charset_selection;
                switch_charset(_charset);
                // Stay on charset selection row
                sfx_play(snd_menu_select);
            }
            else if (japanese_nav_state == 2) {
                // On control row
                switch(english_control_sel) {
                    case 0: // QUIT
                        room_goto(rm_loadgame);
                        sfx_play(snd_menu_select);
                        break;
                        
                    case 1: // CLEAR
                        _currentNameEntry = "";
                        sfx_play(snd_menu_select);
                        break;
                        
                    case 2: // RANDOMIZE
                        ds_list_shuffle(randomizedName);
                        randomize();
                        _currentNameEntry = string(ds_list_find_value(randomizedName, r));
                        sfx_play(snd_menu_switch);
                        break;
                        
                    case 3: // ACCEPT
                        if (_currentNameEntry != "") {
                            // Always reset _validName when entering confirmation
                            _validName = false;
                            checkingName = true;
                            check_current_entry(string_lower(_currentNameEntry));
                            
                            // Start the tween animation immediately when entering confirmation
                            if (_validName && !_tween_executed_once) {
                                execute_tween(id, "_confirm_name_offset_x", -145, "linear", 3, false);
                                execute_tween(id, "_confirm_name_offset_y", -25, "linear", 3, false);
                                execute_tween(id, "_confirm_name_scale", 6, "linear", 3, false);
                                _tween_executed_once = true;
                            }
                            sfx_play(snd_menu_select);
                        } else {
                            sfx_play(snd_error);
                        }
                        break;
                }
            }
        }
    } else {
        // CONFIRMATION MODE ACTION (same for all languages)
        switch(_choice) {
            case 0: // Confirm (YES)
                if (_validName) {
                    nameConfirmed = true;
                    sfx_play(snd_menu_select);
                    
                    mus_stop(global.currentmus[2]);
                    sfx_play(snd_cymbal);
                    fade_basic(0, 1, 140, 0, c_white);
            
                    // Store the name
                    global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "NAME"] = _currentNameEntry;
            
                    // Set alarm for transition
                    alarm[0] = 140;
                } else {
                    sfx_play(snd_error);
                    checkingName = false;
                    _confirm_name_scale = 2;
                    _confirm_name_offset_x = 0;
                    _confirm_name_offset_y = 0;
                    _tween_executed_once = false;
                }
                break;
                
            case 1: // Cancel (NO)
                checkingName = false;
                _confirm_name_scale = 2;
                _confirm_name_offset_x = 0;
                _confirm_name_offset_y = 0;
                _tween_executed_once = false;
                sfx_play(snd_menu_select);
                break;
        }
    }
}

// Cancel/Backspace button
if (input.cancel_pressed && !nameConfirmed) {
    if (!checkingName) {
        // Backspace
        var len = string_length(_currentNameEntry);
        if (len != 0) {
            _currentNameEntry = string_delete(_currentNameEntry, len, 1);
            sfx_play(snd_menu_select);
        }
    } else {
        // Cancel confirmation
        checkingName = false;
        _confirm_name_scale = 2;
        _confirm_name_offset_x = 0;
        _confirm_name_offset_y = 0;
        _tween_executed_once = false;
        sfx_play(snd_menu_select);
    }
}