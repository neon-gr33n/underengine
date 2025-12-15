function load_gj_avatar(_url) {
    show_debug_message("🔧 load_gj_avatar() CALLED with URL: " + _url);
    
    // Use 200px version for better quality
    var avatar_url = _url;
    if (string_pos("/60/", avatar_url) > 0) {
        avatar_url = string_replace(avatar_url, "/60/", "/200/");
        show_debug_message("⬆️ Using 200px version: " + avatar_url);
    }
    
    // Create unique temp file name
    var temp_file = "gj_avatar_temp_" + string(current_time) + ".jpg";
    
    // Use http_get_file which automatically saves to file
    show_debug_message("📡 Starting http_get_file for avatar...");
    var request_id = http_get_file(avatar_url, temp_file);
    
    show_debug_message("🧪 HTTP GET FILE ID: " + string(request_id));
    
    if (request_id == -1) {
        show_debug_message("❌ HTTP GET FILE FAILED IMMEDIATELY!");
        set_default_avatar();
        return -1;
    }
    
    // Store both request ID and file path
    global.__gj_avatar_request = request_id;
    global.__gj_avatar_url = avatar_url;
    global.__gj_avatar_file = temp_file;
    
    show_debug_message("✅ File download started: " + temp_file);
    return request_id;
}
	
/// @function set_default_avatar()
/// Sets the default avatar sprite
function set_default_avatar() {
    show_debug_message("🎨 Setting default avatar...");
    
    // Only delete the current sprite if it's not already the default and it's a dynamic sprite
    if (sprite_exists(global.__gj_avatar) && global.__gj_avatar != spr_gj_default_avi) {
        // Check if this is a dynamically loaded sprite (not a built-in resource)
        var spr_name = sprite_get_name(global.__gj_avatar);
        if (spr_name != "spr_gj_default_avi") { // Avoid deleting built-in sprites
            sprite_delete(global.__gj_avatar);
            show_debug_message("🗑️ Deleted previous dynamic avatar sprite");
        }
    }
    
    global.__gj_avatar = spr_gj_default_avi;
    show_debug_message("✅ Default avatar set: " + string(spr_gj_default_avi));
}

/// @function initialize_avatar_system()
/// Call this at the start of your game to ensure avatar is always set
function initialize_avatar_system() {
    show_debug_message("🎮 Initializing avatar system...");
    if (!sprite_exists(global.__gj_avatar)) {
        set_default_avatar();
    }
    show_debug_message("✅ Avatar system initialized");
}