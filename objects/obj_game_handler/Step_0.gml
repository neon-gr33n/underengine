if UTE_DEBUG_MODE == true {
	scr_debugger();	
}

if (keyboard_check_pressed(vk_f4))	
window_set_fullscreen(!window_get_fullscreen());
display_set_gui_maximize();