if input.pause_pressed && player_exists() {
	PLAYER1.canMove = false;
    if instance_exists(obj_settings) {
        instance_destroy(obj_settings);
        instance_activate_all();
        audio_stop_sound(mus_menu);
        audio_resume_all();
        //camera_setup(global.master_view);
    } else if global.pausing_enabled && PLAYER1.currentState == "playerMoveGen" {
        gpu_set_blendenable(false);
        
        global.pause_surf = surface_create(GAME_RES.w,GAME_RES.h);
        surface_set_target(global.pause_surf);
        if surface_exists(application_surface) {
            draw_surface_ext(application_surface, 0, 0, GAME_RES.w / global._display_width, GAME_RES.h / global._display_height, 0, c_white, 1);
        }
        surface_reset_target();
        
        if buffer_exists(global.pause_buff) buffer_delete(global.pause_buff);
        global.pause_buff = buffer_create(global._display_width * global._display_height * 4, buffer_grow, 1);
        buffer_get_surface(global.pause_buff, global.pause_surf, 0);
        
        gpu_set_blendenable(true)
        
        instance_deactivate_all(true)
        instance_activate_object(input_controller_object)
        instance_activate_object(obj_gui_handler)
		instance_activate_object(obj_tile_assets)
        instance_activate_object(input)
		if (os_type == os_android){
			instance_activate_object(obj_mobile_ui)
		}
        instance_activate_object(HEART)
		instance_activate_object(PPFX)
		instance_activate_object(LIGHT)
		instance_activate_object(PLAYER1)
        instance_activate_object(obj_master_camera)
        instance_activate_object(obj_gmlive);
        instance_create(0,0,obj_settings)
        audio_pause_all()
    }
}

if room == rm_settings && !instance_exists(obj_settings) {
    gpu_set_blendenable(false);
    
    global.pause_surf = surface_create(GAME_RES.w,GAME_RES.h);
    surface_set_target(global.pause_surf);
    if surface_exists(application_surface) {
        draw_surface_ext(application_surface, 0, 0, GAME_RES.w / global._display_width, GAME_RES.h / global._display_height, 0, c_white, 1);
    }
    surface_reset_target();
    
    if buffer_exists(global.pause_buff) buffer_delete(global.pause_buff);
    global.pause_buff = buffer_create(global._display_width * global._display_height * 4, buffer_grow, 1);
    buffer_get_surface(global.pause_buff, global.pause_surf, 0);
    
    gpu_set_blendenable(true)
    
    instance_deactivate_all(true)
    instance_activate_object(input_controller_object)
    instance_activate_object(obj_gui_handler)
    instance_activate_object(input)
	if (os_type == os_android){
	instance_activate_object(obj_mobile_ui)
	}
    instance_activate_object(HEART)
    instance_activate_object(obj_master_camera)
    instance_activate_object(obj_gmlive);
    instance_create(0,0,obj_settings)
    audio_pause_all()
}