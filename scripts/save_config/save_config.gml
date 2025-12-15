// save config
function save_config() {
    // Save input profile
    var json_string = json_stringify(input_profile_export(input_profile_get()));
    var bytes = string_byte_length(json_string);
    var buf = buffer_create(bytes, buffer_fixed, 1);
    buffer_write(buf, buffer_text, json_string);
    buffer_save(buf, "CONTROLS");
    buffer_delete(buf);
    
    // Determine settings path
    var settings_path = "";
    if (is_android()) {
        settings_path = working_directory + "settings.cfg";
    } else {
        settings_path = "settings.cfg";
    }
    
    ini_open(settings_path);
    
    // Save language settings - use consistent naming
    if (variable_global_exists("LANGUAGE_CONFIG") && global.LANGUAGE_CONFIG != undefined) {
        var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
        if (current_lang != undefined) {
            ini_write_string("LANGUAGE", "LOC", current_lang.name);
            ini_write_real("LANGUAGE", "LANG_ID", global.lang); // Use consistent name
        }
    } else {
        // Fallback if LANGUAGE_CONFIG not initialized
        ini_write_string("LANGUAGE", "LOC", global.LOC);
        ini_write_real("LANGUAGE", "LANG_ID", global.lang);
    }
    
    // Save sound settings
    if (variable_global_exists("master_volume")) ini_write_real("SOUND", "master", global.master_volume);
    if (variable_global_exists("mus_volume")) ini_write_real("SOUND", "mus", global.mus_volume);
    if (variable_global_exists("voice_volume")) ini_write_real("SOUND", "voice", global.voice_volume);
    if (variable_global_exists("sfx_volume")) ini_write_real("SOUND", "sfx", global.sfx_volume);
    
    // Save graphics settings
    if (variable_global_exists("vsync")) ini_write_real("GRAPHICS", "vsync", global.vsync);
    if (variable_global_exists("window_mode")) ini_write_real("GRAPHICS", "dmode", global.window_mode);
    
    // Get current FPS limit
    var current_fps = game_get_speed(gamespeed_fps);
    ini_write_real("GRAPHICS", "fps_limit", current_fps);
    
    // Save resolution index
    if (variable_global_exists("resolution_index")) ini_write_real("GRAPHICS", "resolution_index", global.resolution_index);
    
    if (variable_global_exists("asp_ratio")) ini_write_real("GRAPHICS", "aspect_ratio", global.asp_ratio);
    
    // Save simplify VFX setting if it exists
    if (variable_global_exists("simplify_vfx")) ini_write_real("GRAPHICS", "simplify_vfx", global.simplify_vfx);
    
    // Save gameplay settings
    if (variable_global_exists("camera_lerp")) ini_write_real("GAMEPLAY", "cam_lerp", global.camera_lerp);
    if (variable_global_exists("auto_sprint")) ini_write_real("GAMEPLAY", "auto_sprint", global.auto_sprint);
    if (variable_global_exists("rounded_box")) ini_write_real("GAMEPLAY", "rounded_box", global.rounded_box);
    
    // Save accessibility settings
    if (variable_global_exists("one_handed")) ini_write_real("ACCESSIBILITY", "one_handed", global.one_handed);
    if (variable_global_exists("epilepsy_mode")) ini_write_real("ACCESSIBILITY", "epilepsy_mode", global.epilepsy_mode);
    if (variable_global_exists("shake_screen")) ini_write_real("ACCESSIBILITY", "screen_shake", global.shake_screen);
    
    // Save difficulty if it exists
    if (variable_global_exists("__difficulty_id")) {
        ini_write_string("ACCESSIBILITY", "difficulty", global.__difficulty_id);
    }
    
    // Save extras
    if (variable_global_exists("presence")) ini_write_real("EXTRAS", "discord_rpc", global.presence);
    if (variable_global_exists("_border_sel")) ini_write_string("EXTRAS", "border_id", global._border_sel);
    if (variable_global_exists("_border_type_index")) ini_write_real("EXTRAS", "border_mode", global._border_type_index);
    if (variable_global_exists("_border_enabled")) ini_write_real("EXTRAS", "border_enabled", global._border_enabled);
    
    ini_close();
    
    // Debug log
    show_debug_message("Config saved: lang=" + string(global.lang) + ", resolution_index=" + string(global.resolution_index));
}