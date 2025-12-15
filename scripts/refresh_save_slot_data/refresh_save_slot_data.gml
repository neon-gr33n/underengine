/// @function refresh_save_slot_data()
/// Updates the cached save slot data (names, times, rooms)
function refresh_save_slot_data() {
    // Refresh party names from CHARA's name
    for (var i = 0; i < 3; i++) {
        if (file_exists("PARTYINFO" + string(i))) {
            var buf = buffer_load("PARTYINFO" + string(i));
            var json = buffer_read(buf, buffer_text);
            var party_data = json_parse(json);
            
            // Get CHARA's name
            var chara_name = "Chara"; // Default
            if (variable_struct_exists(party_data, "CHARA")) {
                if (variable_struct_exists(party_data.CHARA, "NAME")) {
                    chara_name = string(party_data.CHARA.NAME);
                }
            }
            
            global.party_names[i] = chara_name;
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
            
            var save_hours = ini_read_real("World-SL" + string(i), "HR", 0);
            var save_minutes = ini_read_real("World-SL" + string(i), "MN", 0);
            var save_seconds = ini_read_real("World-SL" + string(i), "SC", 0);
            
            var room_id = ini_read_real("General-SL" + string(i), "room", 1);
            
            ini_close();
            
            // Format time
            var save_mins = save_minutes mod 60;
            var time_str = "";
            if (save_hours > 0) time_str = string(save_hours) + ":";
            time_str += (save_mins < 10 ? "0" : "") + string(save_mins) + ":" +
                       (save_seconds < 10 ? "0" : "") + string(save_seconds);
            
            global.party_times[i] = time_str;
            
            var room_name = get_room_name(room_id);
            if (room_name == "Menu - Starting Up..." || room_name == "Menu - Load") {
                global.party_rooms[i] = "------------";
                global.party_times[i] = "--:--";
            } else {
                global.party_rooms[i] = room_name;
            }
        } else {
            global.party_rooms[i] = "------------";
        }
    }
}