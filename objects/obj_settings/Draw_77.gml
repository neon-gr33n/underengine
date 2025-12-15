gpu_set_blendenable(false)
if surface_exists(application_surface) {
surface_set_target(application_surface);

	if surface_exists(global.pause_surf) { draw_surface_ext(global.pause_surf,0,0,global._display_width/surface_get_width(global.pause_surf),global._display_height/surface_get_height(global.pause_surf),0,c_white,1)};
	else {
		global.pause_surf = surface_create(GAME_RES.w,GAME_RES.h);
		buffer_set_surface(global.pause_buff,global.pause_surf,0);
	}
surface_reset_target();
}
gpu_set_blendenable(true)
//if(!surface_exists(global.pause_surf)){show_message("nope")}

//if keyboard_check_pressed(ord("I")) show_message(string(surface_get_width(global.pause_surf))+"x"+string(surface_get_height(global.pause_surf)))