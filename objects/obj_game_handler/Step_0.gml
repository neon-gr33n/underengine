if UTE_DEBUG_MODE == true {
	scr_debugger();	
}

if !instance_exists(obj_cutscene_handler){
	if instance_exists(obj_ow_player) {obj_ow_player.image_speed = 1; obj_ow_player.canMove = true;}	
}

if (keyboard_check_pressed(vk_f4))	
window_set_fullscreen(!window_get_fullscreen());
display_set_gui_maximize();