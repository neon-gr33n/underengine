//show_debug_message("I'ze does exist!")
show_debug_message(sprite_get_name(global.__gj_avatar))

// Check for avatar download timeout
if (global.__gj_avatar_request != undefined && global.__gj_avatar_timeout != undefined) {
    if (current_time > global.__gj_avatar_timeout) {
        show_debug_message("⏰ AVATAR DOWNLOAD TIMEOUT! Request ID: " + string(global.__gj_avatar_request));
        show_debug_message("⏰ URL: " + string(global.__gj_avatar_url));
        show_debug_message("⏰ Request appears to be hanging - using default avatar");
        
        global.__gj_avatar_request = undefined;
        global.__gj_avatar_timeout = undefined;
        set_default_avatar();
    }
}