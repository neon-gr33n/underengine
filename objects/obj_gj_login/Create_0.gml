HEART.visible = 0;
keyboard_string = ""; // clears previous key presses
image_alpha=0
execute_tween(id,"image_alpha",0.8,easetype.linear,1)

_menued = 0;
_state = "enterCredentials";

usernameString = ""
tokenString = ""
saveCredentials = false;

tokenPrivacy = true;
				
response = undefined;
_avatar_url = noone
_avatar_surf = noone

spr = noone;

function needs_virtual_keyboard(){
	return global.osflavor == 1;	
}

function show_keyboard() {
	if needs_virtual_keyboard()
    {
        if (!keyboard_virtual_status())
            keyboard_virtual_show(1, 9, 0, false)
    }
}

function supports_clipboard() {
	return os_type != os_linux;
}	

function get_keyboard_input()
{
    // Handle clipboard paste
    if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) && supports_clipboard())
        keyboard_string += clipboard_get_text()
    
    // Limit length
    var len = string_length(keyboard_string)
    if (len > 30)
    {
        keyboard_string = string_copy(keyboard_string, 1, 30)
    }
    
    // Return current string for display
    return keyboard_string;
}

function draw_default_avatar() {
    // Draw a simple default avatar
    draw_set_color(make_color_rgb(100, 100, 200));
    draw_circle(d_width/1.95, d_height/4*1.6, 50, true);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Draw initials from username
    var initials = "GJ";
    if (string_length(global.gj_username) > 0) {
        initials = string_upper(string_copy(global.gj_username, 1, 2));
    }
    
    draw_text_transformed(d_width/1.95, d_height/4*1.6, initials, 2/960*d_height, 2/960*d_height, 0);
}

function process_keyboard_input(callback)
{
    var current_input = keyboard_string;
    var len = string_length(current_input);
    
    if (len > 0 && input.action_pressed)
    {
        callback(current_input);
        keyboard_string = ""; // Reset after processing
        return true; // Input was processed
    }
    
    return false; // No input processed
}
show_keyboard();