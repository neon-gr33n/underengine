///@desc Process Inputs
show_debug_message("Avatar loaded: " + sprite_get_name(global.__gj_avatar))
// Auto-convert negative sprite IDs to positive when loading completes
if (global.__gj_avatar < 0 && sprite_exists(abs(global.__gj_avatar))) {
    global.__gj_avatar = abs(global.__gj_avatar);
    show_debug_message("Auto-converted avatar ID from " + string(-global.__gj_avatar) + " to: " + string(global.__gj_avatar));
}

if (global.__gj_authorized == true){
    show_debug_message("User authed success")	
    show_debug_message("Avatar state: " + string(global.__gj_avatar))
} else {
    show_debug_message("Failed to authenticate user")	
}

switch(_state){
    // The user is currently entering their login details/credentials.
    case "enterCredentials": 
        // Toggle Token Visibility
        if (keyboard_check_pressed(vk_control)){
            tokenPrivacy = !tokenPrivacy;		
        }
        switch(_menued){
            case 0:
                usernameString = get_keyboard_input(usernameString, function(input_text){
                    sfx_play(snd_menu_select)	
                    usernameString = input_text
                    tokenString = ""
                    _menued = 1;
                })
            break;
            case 1:
                tokenString = get_keyboard_input(tokenString, function(input_text){
                    sfx_play(snd_menu_select)	
                    tokenString = input_text
                })
            break;
            case 2:
                if input.action_pressed
                    saveCredentials = !saveCredentials
            break;
            case 3:
                if input.action_pressed {
                    global.gj_username = usernameString;
                    global.gj_token = tokenString;
                    
                    // Reset states for new login attempt
                    global.__gj_authorized = false;
					
                    show_debug_message("=== STARTING AUTHENTICATION ===");
                    
                    // Create GJ instance if it doesn't exist
                    if (!instance_exists(GJ)) {
                        instance_create(0,0,GJ);
                        show_debug_message("✅ Created GJ instance");
                    } else {
                        show_debug_message("✅ GJ instance already exists");
                    }
                    
                    // Set callback and make auth request WITHOUT callback function
                    global.network_callback = "users/auth";
                    show_debug_message("🔄 Making auth request...");
                    
                    global.gj.user.auth(global.gj_username, global.gj_token, function(){         
	                    // IMMEDIATELY switch to verifyCredentials state
	                    _state = "verifyCredentials";
	                    show_debug_message("🔄 State changed to verifyCredentials");
					});          
                }
            break;
            case 4:
                if input.menu_pressed {
                    if instance_exists(obj_settings){
                        with(obj_settings){_menu = 2.6;}
                    }
                    instance_destroy(obj_gj_login)
                }
            break;
        }
    break;
    
    case "verifyCredentials":
        show_debug_message("🔍 Verifying credentials...");
        show_debug_message("Current callback: " + string(global.network_callback));
        show_debug_message("Authorized: " + string(global.__gj_authorized));
		
		if (global.__gj_authorized){
			global.gj.user.fetch(global.gj_username, function(){
				global.network_callback="users/fetch"
			})	
		}
        
        // Allow closing anytime after authentication, regardless of avatar state
        if (global.__gj_authorized && input.cancel_pressed) {
            show_debug_message("✅ Authentication successful - closing login screen");
            instance_destroy(obj_gj_login)
            if saveCredentials {
                gj_util_storecredentials(global.gj_username,global.gj_token)	
            }
        } else if (!global.__gj_authorized && input.cancel_pressed) {
            show_debug_message("❌ Authentication failed - returning to credentials entry");
            usernameString = ""
            tokenString = ""
            _state = "enterCredentials";	
        }
        
        // Debug: Check if we're stuck in this state
        if (global.network_callback == "users/auth") {
            show_debug_message("⏳ Waiting for auth response...");
        } else if (global.network_callback == "users/fetch") {
            show_debug_message("🔄 users/fetch should be processing in async event");
        }
    break;
}