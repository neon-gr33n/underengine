if(live_call()) return live_result;


draw_set_alpha(image_alpha);
d_width = window_get_fullscreen() ? window_get_width() : surface_get_width(application_surface);
d_height = window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface);

// Mobile-safe area detection (iOS/Android)
var safe_x1 = 0;
var safe_y1 = 0;
var safe_x2 = d_width;
var safe_y2 = d_height;

// Check for mobile device
var is_mobile = is_android() == true ? true : false; // Basic mobile detection
if (is_mobile) {
    // Adjust for safe areas on mobile
    var margin = 40; // Minimum margin for mobile
    safe_x1 = margin;
    safe_y1 = margin;
    safe_x2 = d_width - margin;
    safe_y2 = d_height - margin;
    
    // Additional check for devices with notches
    var landscape = (d_width > d_height);

	if (landscape) {
	    safe_x1 = 80;
	    safe_x2 = d_width - 80;
	}
}

_alpha = (image_alpha/0.8*1);
var alpha = (_alpha_other/0.8*1);

// Dynamic scaling for mobile
var title_scale = is_mobile ? 3 : 4;
var text_scale = is_mobile ? 1.2 : 1.5;
var prompt_scale = is_mobile ? 1.5 : 2;

if state < 2 {
    draw_set_alpha(_alpha);
    
    // Center title horizontally for mobile
    var title_x = is_mobile ? (safe_x1 + (safe_x2 - safe_x1) / 2) : (d_width/5);
    draw_ftext(loc_get_font(fnt_main_small), c_white, title_x, safe_y1 + d_height/34, title_scale, title_scale, 0, "~ DISCLAIMER ~");
    
    // Use safer text positioning for mobile
    var text_x = is_mobile ? (safe_x1 + 20) : (d_width/30);
    var text_y = is_mobile ? (safe_y1 + d_height/5) : (d_height/6);
    
    draw_ftext(loc_get_font(fnt_main_small), c_white, text_x, text_y, text_scale, text_scale, 0, 
        string_hash_to_newline("No dogs were harmed in the making#of this video game (please don't sue)#This is a demo, it will not reflect#the quality of the final product,#assets used in this project#are subject to change.#This includes, but is not limited to:#fonts, music, sprites (overworld, battle, etc.)#and, dialogue/flavor text.")
    );
} else {
    draw_set_alpha(_alpha);
    
    // Center title for mobile
    var title_x = is_mobile ? (safe_x1 + (safe_x2 - safe_x1) / 2) : (d_width/5);
    draw_ftext(loc_get_font(fnt_main_small), c_white, title_x, safe_y1 + d_height/34, title_scale, title_scale, 0, "~ DISCLAIMER ~");
    
    draw_set_alpha(alpha);
    
    // First block of text
    var text1_x = is_mobile ? (safe_x1 + 20) : (d_width/30);
    var text1_y = is_mobile ? (safe_y1 + d_height/5) : (d_height/6);
    
    draw_ftext(loc_get_font(fnt_main_small), c_white, text1_x, text1_y, text_scale, text_scale, 0, 
        string_hash_to_newline("No dogs were harmed in the making#of this video game (please don't sue)#This is a demo, it will not reflect#the quality of the final product,#assets used in this project#are subject to change.#This includes, but is not limited to:#fonts, music, sprites (overworld, battle, etc.)#and, dialogue/flavor text.")
    );
    
    // "THANK YOU" text
    var thank_x = is_mobile ? (safe_x1 + (safe_x2 - safe_x1) / 2) : (d_width/4);
    var thank_y = is_mobile ? (safe_y2 - d_height/4) : (d_height/1.5);
    
    draw_ftext(loc_get_font(fnt_main_small), c_white, thank_x, thank_y, title_scale, title_scale, 0, "~ THANK YOU ~");
    
    // Continue prompt with mobile-friendly text
    var prompt_text = is_mobile ? "TAP TO CONTINUE" : "PRESS START TO CONTINUE";
    var prompt_x = is_mobile ? (safe_x1 + (safe_x2 - safe_x1) / 2) : (d_width/4);
    var prompt_y = is_mobile ? (safe_y2 - 60) : (d_height/1.2);
    
    // Add pulsing effect for better visibility on mobile
    var pulse_alpha = (1 + sin(current_time / 200)) / 2; // Pulsing alpha
    draw_set_alpha(pulse_alpha);
    
    draw_ftext(loc_get_font(fnt_main_small), c_white, prompt_x, prompt_y, prompt_scale, prompt_scale, 0, prompt_text);
    
    // Reset alpha
    draw_set_alpha(1);
}

// For mobile touch input (add this to your step event or input handling)
if (is_mobile && state >= 2) {
    // Check for any touch input
    for (var i = 0; i < 5; i++) { // Check up to 5 touch points
        if (device_mouse_check_button_pressed(i, mb_left)) {
            // Handle touch to continue
            // Add your continue logic here
            audio_play_sound(snd_menu_confirm, 0, false);
            // Proceed to next screen
        }
    }
}