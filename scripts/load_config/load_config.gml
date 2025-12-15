function load_config() {
    var settings_path = is_android() ? working_directory + "settings.cfg" : "settings.cfg";
    
    ini_open(settings_path);
    
    // Load language settings - using new language ID system
    global.lang = ini_read_real("LANGUAGE", "LANG_ID", 1); // Default to English (ID 1)
    
    // Load the language name for compatibility with old code
    var loc_temp = ini_read_string("LANGUAGE", "LOC", "ENGLISH");
    global.LOC = (loc_temp != undefined && loc_temp != "") ? loc_temp : "ENGLISH";
    
    global.master_volume = ini_read_real("SOUND", "master", 1);
    global.mus_volume = ini_read_real("SOUND", "mus", 0.75);
    global.voice_volume = ini_read_real("SOUND", "voice", 1);
    global.sfx_volume = ini_read_real("SOUND", "sfx", 0.5);
    
    global.vsync = ini_read_real("GRAPHICS", "vsync", true);
    global.window_mode = ini_read_real("GRAPHICS", "dmode", 0);
    game_set_speed(ini_read_real("GRAPHICS", "fps_limit", 60), gamespeed_fps);
    
    // Load resolution index - default to index 0 (lowest resolution)
    global.resolution_index = ini_read_real("GRAPHICS", "resolution_index", 0);
    
    // Load aspect ratio - check if resolution index is 0, then force aspect ratio to 0
    var temp_asp_ratio = ini_read_real("GRAPHICS", "aspect_ratio", 0);
    if (global.resolution_index == 0) {
        global.asp_ratio = 0; // Force square for lowest resolution
    } else {
        global.asp_ratio = temp_asp_ratio;
    }
    
    // Load simplify VFX setting - default to false
    global.simplify_vfx = ini_read_real("GRAPHICS", "simplify_vfx", false);
    
    global.camera_lerp = ini_read_real("GAMEPLAY", "cam_lerp", false);
    global.auto_sprint = ini_read_real("GAMEPLAY", "auto_sprint", false);
    global.rounded_box = ini_read_real("GAMEPLAY", "rounded_box", false);
    
    global.one_handed = ini_read_real("ACCESSIBILITY", "one_handed", false);
    global.epilepsy_mode = ini_read_real("ACCESSIBILITY", "epilepsy_mode", false);
    global.shake_screen = ini_read_real("ACCESSIBILITY", "screen_shake", true);
    
    // Load difficulty setting
    var difficulty_temp = ini_read_string("ACCESSIBILITY", "difficulty", "NORMAL");
    global.__difficulty_id = (difficulty_temp != undefined && difficulty_temp != "") ? string_upper(difficulty_temp) : "NORMAL";
    
    // Validate difficulty exists in our struct (if struct exists)
    if (variable_global_exists("GAME_DIFFICULTY")) {
        game_set_difficulty(global.__difficulty_id);
        if (!variable_struct_exists(global.GAME_DIFFICULTY.__DIFFICULTY__, global.__difficulty_id)) {
            global.__difficulty_id = "NORMAL"; // Fallback to normal if invalid
        }
    }
    
    global.presence = ini_read_real("EXTRAS", "discord_rpc", false);
    global._border_sel = ini_read_string("EXTRAS", "border_id", "SIMPLE");
    global._border_type_index = ini_read_real("EXTRAS", "border_mode", 1);
    global._border_enabled = ini_read_real("EXTRAS", "border_enabled", true);
    
    ini_close();
    
    // After loading config, set display sizes based on loaded resolution index
	if (variable_global_exists("resolutions")){
    set_display_sizes();
	}
    
    // Load input profile if it exists
    if (file_exists("CONTROLS")) {
        var buf = buffer_load("CONTROLS");
        var json_string = buffer_read(buf, buffer_text);
        var profile = json_parse(json_string);
        input_profile_import(profile);
        buffer_delete(buf);
    }
}