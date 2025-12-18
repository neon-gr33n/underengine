/// @func refresh_save_slot_data()
/// @desc Updates the cached save slot data (names, times, rooms)
/// @desc Reads from PARTYINFO files for names and underengine.ini for times/rooms
function refresh_save_slot_data() {
    // Refresh party names from FRISK's name
    for (var i = 0; i < 3; i++) {
        if (file_exists("PARTYINFO" + string(i))) {
            var buf = buffer_load("PARTYINFO" + string(i));
            var json = buffer_read(buf, buffer_text);
            
            // Try to parse JSON with error handling
            try {
                var party_data = json_parse(json);
                
                // Get CHARA's name (FRISK character)
                var chara_name = "Frisk"; // Default
                if (variable_struct_exists(party_data, "FRISK")) {
                    if (variable_struct_exists(party_data.FRISK, "NAME")) {
                        chara_name = string(party_data.FRISK.NAME);
                    }
                }
                
                global.party_names[i] = chara_name;
            } catch (e) {
                // JSON parsing failed
                global.party_names[i] = "[CORRUPTED]";
                show_debug_message("Failed to parse PARTYINFO" + string(i) + ": " + string(e));
            }
            
            buffer_delete(buf);
        } else {
            global.party_names[i] = "[EMPTY]";
        }
    }
    
    // Refresh times and rooms from INI
    for (var i = 0; i < 3; i++) {
        var ini_filename = "underengine.ini";
        
        if (file_exists(ini_filename)) {
            ini_open(ini_filename);
            
            // Read save data
            var room_id = ini_read_real("General-SL" + string(i), "room", -1);
            var save_hours = ini_read_real("World-SL" + string(i), "HR", 0);
            var save_minutes = ini_read_real("World-SL" + string(i), "MN", 0);
            var save_seconds = ini_read_real("World-SL" + string(i), "SC", 0);
            
            ini_close();
            
            // Check if this is a valid game save (not menu/loading screen)
            var has_playtime = (save_hours > 0) || (save_minutes > 0) || (save_seconds > 0);
            var has_partyinfo = file_exists("PARTYINFO" + string(i));
            
            // This slot has a valid save if: not a menu room AND has playtime AND has PARTYINFO
            var has_valid_save = (has_playtime || has_partyinfo);
            
            if (has_valid_save) {
                // Format time for valid save
                var save_mins = save_minutes mod 60;
                var time_str = "";
                
                if (save_hours > 0) {
                    time_str = string(save_hours) + ":";
                }
                
                time_str += (save_mins < 10 ? "0" : "") + string(save_mins) + ":" +
                           (save_seconds < 10 ? "0" : "") + string(save_seconds);
                
                global.party_times[i] = time_str;
                
                // Get room display name
                if (room_id > 0) {
                    global.party_rooms[i] = get_room_name(room_id);
                } else {
                    global.party_rooms[i] = "Unknown Location";
                }
            } else {
                // This is a menu screen or empty slot
                global.party_rooms[i] = "------------";
                global.party_times[i] = "--:--"
            }
        } else {
            // No INI file exists
            global.party_rooms[i] = "------------";
            global.party_times[i] = "--:--";
        }
    }
}