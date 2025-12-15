if ticks < 215_999_990
	ticks++;
seconds = (ticks div 60) % 60;
minutes = (seconds div 60) % 60;
hours = (seconds div 60); // No need for mod as ticks are already being limited

function update_input_device() {
    static last_input_time = 0;
    static last_device = "keyboard";
    
    // Check for any gamepad input
    var gamepad_active = false;
    if (input_gamepad_is_connected(0)) {
        // Check gamepad buttons, axes, and triggers
        if (abs(gamepad_axis_value(0, gp_axislh)) > 0.1 ||
            abs(gamepad_axis_value(0, gp_axislv)) > 0.1 ||
            abs(gamepad_axis_value(0, gp_axisrh)) > 0.1 ||
            abs(gamepad_axis_value(0, gp_axisrv)) > 0.1 ||
            gamepad_button_check(0, gp_face1) ||
            gamepad_button_check(0, gp_face2) ||
            gamepad_button_check(0, gp_face3) ||
            gamepad_button_check(0, gp_face4) ||
            gamepad_button_check(0, gp_shoulderlb) ||
            gamepad_button_check(0, gp_shoulderrb) ||
            gamepad_button_check(0, gp_start) ||
            gamepad_button_check(0, gp_select) ||
            gamepad_button_check(0, gp_padu) ||
            gamepad_button_check(0, gp_padd) ||
            gamepad_button_check(0, gp_padl) ||
            gamepad_button_check(0, gp_padr)) {
            gamepad_active = true;
            last_input_time = current_time;
            last_device = "gamepad";
        }
    }
    
    // Check for keyboard/mouse input
    var keyboard_active = (keyboard_check(vk_anykey) || mouse_check_button(mb_any));
    if (keyboard_active) {
        last_input_time = current_time;
        last_device = "keyboard";
    }
    
    // Check for touch input (simplified version)
    var touch_active = false;
    if (os_type == os_android || os_type == os_ios) {
        // Simple check for any touch/mouse input on mobile
        // On Android, mouse events are used for touch
        if (device_mouse_check_button(0, mb_left) || 
            device_mouse_check_button_pressed(0, mb_left) ||
            device_mouse_check_button_released(0, mb_left)) {
            touch_active = true;
            last_input_time = current_time;
            last_device = "touch";
        }
        
        // Alternatively, use the built-in touch functions
        // for (var i = 0; i < 5; i++) {
        //     if (device_is_touch(i)) {
        //         touch_active = true;
        //         last_input_time = current_time;
        //         last_device = "touch";
        //         break;
        //     }
        // }
    }
    
    // Set the active device based on most recent input
    global.input_device = last_device;
}
// Call this in your step event
update_input_device();
//show_debug_message("Input devise active is: " + global.input_device)

if(!is_android() || global.input_device == "gamepad"){
	instance_deactivate_object(obj_mobile_ui)	
}

if (is_android() && global.input_device == "touch"){
	instance_activate_object(obj_mobile_ui)	
}

if instance_exists(obj_ow_party) obj_ow_party.image_blend=c_white
if global.debug {
	scr_debugger();
	show_debug_overlay(performanceInfo)
}

if !DEVELOPERBUILD {
	global.debug = false;
} else if keyboard_check_pressed(vk_f6) global.debug=!global.debug
if global.debug || DEVELOPERBUILD == 1 {
	if keyboard_check_pressed(vk_f5) {
		screen_capture()
	}
	if keyboard_check_pressed(vk_f8){
		global.rounded_box = !global.rounded_box;	
	}
}

if (keyboard_check_pressed(vk_f4)) with(obj_master_camera) fullscreen_toggle()
//window_set_fullscreen(!window_get_fullscreen());
//display_set_gui_maximize();

//if (keyboard_check_pressed(ord("R"))) party_update();