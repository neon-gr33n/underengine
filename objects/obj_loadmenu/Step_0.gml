switch(state){
    #region File Selection
    case "selectFile":
		refresh_save_slot_data(); // Refresh data
        // Vertical navigation
        if input.down_pressed || input.up_pressed {
            _menued=(_menued+4+input.down-input.up)%4;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }       
        
        // Horizontal navigation
        if (_menued >= 3 && (input.left_pressed || input.right_pressed)) {
            _menued = (_menued + 3 + input.right - input.left) % 3 + 3;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }
            
        if (_menued < 3){
            _menued_cache = _menued;
        }
        
        show_debug_message("Cached menued at: " + string(_menued_cache));
        
        if input.action_pressed {
            var fname = "file"+string(_menued_cache);
            switch(_menued){
                case 0:
                case 1:
                case 2:
                    _menued = 0;
                    state = "confirmChoice";
                break;        
                case 3:                    
                    _menued = 0;
					state = "copySave";
                break;
                case 4:
                    _menued = 0;
					state = "eraseSelect";
                break;
                case 5:
                    game_end();
                break;
            }
            sfx_play(snd_menu_select,1,global.sfx_volume);
        }
		
		if input.cancel_pressed {
			room_restart()
			room_goto(rm_menu);
		}
    break;
    #endregion
    
    #region Confirmation Dialogs
    case "confirmChoice":
        if input.left_pressed || input.right_pressed {
            _menued=(_menued+2+input.left-input.right)%2;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
		 // Handle C key to toggle reset mode
	    if input.menu_pressed && file_exists("file"+string(_menued)) {
	        reset_mode = !reset_mode;
	        sfx_play(snd_menu_switch, 1, global.sfx_volume);
	    }
	
        if input.action_pressed {
            if file_exists("file"+string(_menued_cache)){
                switch(_menued){
                    case 0:
                        if (reset_mode) {
                        // RESET - No extra confirmation needed
						 global.was_reset = true;
                        global.just_reset = true;
                        perform_game_reset(_menued_cache);
                        
                        // Set flags and transition
                        global.filechoice = _menued_cache;
                        
                       sfx_play(snd_menu_select,1,global.sfx_volume);
                    } else {
                        // CONTINUE
                        loadgame(_menued_cache);
                        sfx_play(snd_menu_select,1,global.sfx_volume);
                    }
                    break;
                    case 1:
                        _menued = _menued_cache;
                        state = "selectFile";    
						reset_mode = false;
                        sfx_play(snd_menu_select,1,global.sfx_volume);
                    break;
                }
            } else {
                switch(_menued){
                    case 0:
                        global.filechoice = _menued_cache;
                        room_restart();
                        room_goto(rm_naming);
                        sfx_play(snd_menu_select,1,global.sfx_volume);
                    break;
                    case 1:
                        _menued = _menued_cache;
                        state = "selectFile";    
                        sfx_play(snd_menu_select,1,global.sfx_volume);
                    break;
                }
            }
        }
    break;
    #endregion
    
    #region Copy Operations
    case "copySave":
        if input.down_pressed || input.up_pressed {
            _menued=(_menued+4+input.down-input.up)%4;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
        if input.action_pressed {
            _menued_cache = _menued;
            _menued = 0;
			state = "copySaveTo";
            sfx_play(snd_menu_select,1,global.sfx_volume);
        }
    break;
    
    case "copySaveTo":
        if input.down_pressed || input.up_pressed {
            _menued=(_menued+3+input.down-input.up)%3;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
        if input.action_pressed {
            if (_menued == _menued_cache) {
                state = "copySaveFail";
            } else {
                state = "copySaveComplete";    
            }
            sfx_play(snd_menu_select,1,global.sfx_volume);
        }
        
        if input.cancel_pressed {
            state = "selectFile";    
        }
    break;
    
    case "copySaveComplete":
        if (_menued != _menued_cache) {
            // Optional: Check if source files exist
            if (file_exists("file" + string(_menued_cache)) && 
                file_exists("PARTYINFO" + string(_menued_cache))) {
                
                file_copy("file" + string(_menued_cache), "file" + string(_menued));
                file_copy("PARTYINFO" + string(_menued_cache), "PARTYINFO" + string(_menued));
                copy_general(_menued_cache, _menued);
                
                // Optional: Update pre-loaded arrays after successful copy
                global.party_names[_menued] = global.party_names[_menued_cache];
                global.party_times[_menued] = global.party_times[_menued_cache];
                global.party_rooms[_menued] = global.party_rooms[_menued_cache];
            } else {
                state = "copySaveFail";
            }
        } else {
            state = "copySaveFail";
        }
        
        if (input.cancel_pressed) {
            alarm[1] = 1;    
        }
    break;
    
    case "copySaveFail":
        _menued = 0;
        if input.cancel_pressed {
            alarm[1] = 1;    
        }
    break;
    #endregion
    
    #region Erase Operations
    case "eraseSelect":
        // Vertical navigation
        if input.down_pressed || input.up_pressed {
            _menued=(_menued+4+input.down-input.up)%4;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
        if input.action_pressed {
            _menued_cache = _menued;
            _menued = _menued_cache;
			 if (file_exists("file" + string(_menued_cache)) && file_exists("PARTYINFO" + string(_menued_cache))){
				    state = "confirmEraseChoice";
			 } else {
					state = "selectFile"
			 }

        }
        
        if input.cancel_pressed {
            state = "selectFile";    
        }
    break;
    
    case "confirmEraseChoice":
        if input.left_pressed || input.right_pressed {
            _menued=(_menued+2+input.left-input.right)%2;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
        if input.action_pressed {
            _menued = 0;
            state = "confirmEraseChoiceLast";
        }
    break;
    
    case "confirmEraseChoiceLast":
        if input.left_pressed || input.right_pressed {
            _menued=(_menued+2+input.left-input.right)%2;
            sfx_play(snd_menu_switch,1,global.sfx_volume);
        }        
        
        if input.action_pressed {
            switch(_menued){
                case 0:
                    var fname = "file"+string(_menued_cache);
                    var fname_party= "PARTYINFO"+string(_menued_cache);
                    if (file_exists(fname)){
                        file_delete(fname);
                        file_delete(fname_party);
                        erase_general(_menued_cache);
                        // Optional: Update pre-loaded arrays after successful copy
                        global.party_names[_menued] = global.party_names[_menued_cache];
                        global.party_times[_menued] = global.party_times[_menued_cache];
                        global.party_rooms[_menued] = global.party_rooms[_menued_cache];
                        
                        state = "selectFile";
                    }
                break;
                case 1:
                    state = "selectFile";
                break;
            }
        }
    break;
    #endregion
}