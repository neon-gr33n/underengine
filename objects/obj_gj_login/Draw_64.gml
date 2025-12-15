if(live_call()) return live_result;
draw_set_alpha(image_alpha)

_alpha = (image_alpha/0.8*1)
draw_set_halign(fa_center)
draw_set_font(loc_get_font(fnt_main))
d_width = window_get_fullscreen() ? window_get_width() : surface_get_width(application_surface)
d_height = window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface)


draw_sprite_centered_ext(spr_gj_logo,0,d_width/2,40/960*d_height*2,1,1,0,c_white,_alpha)

draw_sprite_ext(spr_px,0,0,80,GAME_RES.w,4,0,c_white,_alpha)

switch (_state){
    case "enterCredentials":
        #region Draw Visuals
        if image_alpha >= 0.7
            outline_set_text();
        draw_set_color(_menued == 0 ? c_aqua : c_white)
        draw_text_transformed(d_width/6,d_height/4*1,"Username: ",2/960*d_height,2/960*d_height,0)
        draw_set_color(_menued == 0 ? c_aqua : c_gray)
        draw_text_transformed(d_width/2,d_height/4*1,usernameString,2/960*d_height,2/960*d_height,0)
        outline_end()
        
        if image_alpha >= 0.7 
            outline_set_text();
        draw_set_color(_menued == 1 ? c_aqua : c_white)
        draw_text_transformed(d_width/7.3,d_height/4*1.4,"Token: ",2/960*d_height,2/960*d_height,0)
        draw_set_color(_menued == 1 ? c_aqua : c_gray)
        draw_text_transformed(d_width/2,d_height/4*1.4,tokenPrivacy ? string_repeat("*",string_length(tokenString)) : tokenString,2/960*d_height,2/960*d_height,0)
        outline_end()
        
        if image_alpha >= 0.7 
            outline_set_text();
        draw_set_color(_menued == 2 ? c_aqua : c_white)
        draw_text_transformed(d_width/3.6,d_height/4*1.8,"Save Credentials: "+(saveCredentials ? loc_gettext("choice.yes") : loc_gettext("choice.no")),2/960*d_height,2/960*d_height,0)
        outline_end()
        
        if image_alpha >= 0.7 
            outline_set_text();
        draw_set_color(_menued == 3 ? c_aqua : c_white)
        draw_text_transformed(d_width/6,d_height/4*2.6,loc_gettext("choice.accept"),2/960*d_height,2/960*d_height,0)
        outline_end()
        
        if image_alpha >= 0.7 
            outline_set_text();
        draw_set_color(_menued == 4 ? c_aqua : c_white)
        draw_text_transformed(d_width/6,d_height/4*3,loc_gettext("choice.back"),2/960*d_height,2/960*d_height,0)
        outline_end()
        #endregion
        #region Process Input
        if input.down_pressed||input.up_pressed {
            _menued=(_menued+5+input.down_pressed-input.up_pressed)%5;
            keyboard_string = "";
            audio_play_sound(snd_menu_switch,50,false)
        }
        #endregion
    break;
    
    case "verifyCredentials":
	 #region Draw Visuals
	if !global.__gj_authorized {
	    draw_set_color(c_red)
	    draw_text_transformed(d_width/1.95,d_height/4*1,"~ LOG IN FAILED ~" ,3/960*d_height,3/960*d_height,0)
	    draw_set_color(c_white)
	    draw_set_halign(fa_middle)
	    draw_text_transformed(d_width/1.95,d_height/4*1.5,"Failed to sign in\nto your GameJolt account with the\n provided credentials-\nReason: Invalid username or token.\nPlease verify the information you\ninput is correct and try again." ,2/960*d_height,2/960*d_height,0)
	} else if (global.__gj_authorized) {
	    var avatar_x = d_width/1.95;
	    var avatar_y = d_height/4*1.6;
	    var circle_radius = 100;

	    // SIMPLIFIED: Better avatar state handling
	    if (global.__gj_avatar > 0 && sprite_exists(global.__gj_avatar)) {
	        // Avatar successfully loaded and ready
	        var spr_width = sprite_get_width(global.__gj_avatar);
	        var spr_height = sprite_get_height(global.__gj_avatar);

	        if (spr_width > 1 && spr_height > 1) {
	            // Calculate proper scaling to fit within circle
	            var target_size = circle_radius * 1.8; // Slightly smaller than circle
	            var scale_x = target_size / spr_width;
	            var scale_y = target_size / spr_height;
	            var scale = min(scale_x, scale_y);
				
	            // Draw the avatar with proper scaling and color
				// todo: make a ciruclar mask
	            draw_sprite_centered_ext(global.__gj_avatar, 1, avatar_x, avatar_y, scale, scale, 0, c_white, 1);
	        } else {
	            // Sprite exists but has invalid dimensions
	            draw_default_avatar();
	            draw_set_color(c_yellow);
	            draw_text_transformed(avatar_x, avatar_y + circle_radius + 20, "Invalid Size", 0.9/960*d_height, 0.9/960*d_height, 0);
	        }
	    } else if (global.__gj_avatar < 0) {
	        // Avatar is loading (negative ID) or failed (-1)
	        draw_default_avatar();
	        draw_set_color(c_yellow);
        
	        // Show loading status
	        if (global.__gj_avatar == -1) {
	            draw_text_transformed(avatar_x, avatar_y + circle_radius + 20, "No Avatar", 0.9/960*d_height, 0.9/960*d_height, 0);
	        } else {
	            // Any other negative number means loading
	            draw_text_transformed(avatar_x, avatar_y + circle_radius + 20, "Loading Avatar...", 0.9/960*d_height, 0.9/960*d_height, 0);
	        }
	    } else {
	        // Avatar not loaded yet (shouldn't happen with new system)
	        draw_default_avatar();
	        draw_set_color(c_green);
	        draw_text_transformed(avatar_x, avatar_y + circle_radius + 20, "Ready", 0.9/960*d_height, 0.9/960*d_height, 0);
	    }

	    draw_set_color(c_yellow)	
	    draw_text_transformed(d_width/1.95,d_height/4*2.5,"Welcome, " + global.gj_username + "!" ,2/960*d_height,2/960*d_height,0)
	    draw_set_color(c_gray)
	    draw_text_transformed(d_width/1.95,d_height/4*3,"(Press 'Cancel' to close this window.)" ,2/960*d_height,2/960*d_height,0)
	    if saveCredentials {
	        draw_set_color(c_gray)
	        draw_text_transformed(d_width/1.95,d_height/4*3.5,"(Your GameJolt credentials have been\nsaved to your device.)" ,2/960*d_height,2/960*d_height,0)
	    }
	}
    #endregion
    break;
}