state = "selectFile"

reset_mode = false;
reset_key_cooldown = 0;

// Initialize global time variables
seconds = -1;
minutes = -1;
hours = -1;

// Pre-load party times
global.party_times = array_create(3, "--:--");

// Pre-load party rooms
global.party_rooms = array_create(3, "------------");

for (var i = 0; i < 3; i++) {
	    if (file_exists("PARTYINFO" + string(i))) {
	        var buf = buffer_load("PARTYINFO" + string(i));
	        var json = buffer_read(buf, buffer_text);
	        var party_data = json_parse(json);
	        global.party_names[i] = string(member_get_attribute(party_get_leader(), "NAME"));
	        if (global.party_names[i] == "NULL" || global.party_names[i] == "") {
	            global.party_names[i] = "[EMPTY]";
	        }
	        buffer_delete(buf);
	    }
}

for (var i = 0; i < 3; i++) {
    var ini_filename = "underengine.ini";
    if (file_exists(ini_filename)) {
        ini_open(ini_filename);
        
        // Use DIFFERENT variable names to avoid conflict
		var save_hours = ini_read_real("World-SL" + string(i), "HR", 0);
        var save_minutes = ini_read_real("World-SL" + string(i), "MN", 0);
        var save_seconds = ini_read_real("World-SL" + string(i), "SC", 0);
		
		 // Read room data from General-SL section
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
        if (room_name == "Menu - Starting Up..." || room_name == "Menu - Load"){
			global.party_rooms[i] = "------------";
		    global.party_times[i] = "--:--";
		} else {
		    global.party_rooms[i] = room_name; // Use the actual room name
		}
    } else {
		global.party_rooms[i] = "------------";
	}
}

_menued = 0;
_menued_cache = 0;
_slotOpacity = 1;
_slotOpacityBG = 0.7;

HEART.image_alpha = 0;