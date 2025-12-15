/**
 * Sets up the camera view and display settings.
 * @example
 * // Basic setup with defaults
 * camera_setup();
 * 
 * @example
 * // Setup for viewport 1 with custom scale
 * camera_setup(1, false, true, 0.75);
 */
function camera_setup(view_port = 0, _full_screen = noone, _pix_perf = true, view_scale = 0.5)
{
	//makes sure camera is persistent
	if(!persistent) {persistent = true;}
	
	//sets screen
	if _full_screen!=noone window_set_fullscreen(_full_screen);
	
	//Finds proper scale
	set_scales()
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2)*_pix_perf;
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? floor((display_get_height()/1.25)/9*16) : global._display_width;
	var pix_perf_h = window_get_fullscreen() ? floor(display_get_height()/1.25) : global._display_height;
	
	//finds draw size
	var appsurf_draw_size_w = window_get_fullscreen() ? view_full_w : view_w;
	var appsurf_draw_size_h = window_get_fullscreen() ? view_full_h : view_h;
	
	//record view camera id
	view = view_camera[view_port];
	view_set_camera(view_port,view);
	
	//resizes dimensions
	camera_set_view_size(view,GAME_RES.w * view_scale,GAME_RES.h * view_scale);
	display_set_gui_size(GAME_RES.w,GAME_RES.h);
	surface_resize(application_surface,GAME_RES.w,GAME_RES.h);
	window_set_size(global._windowed_width,global._windowed_height);
	
	//recenters window when getting out of fullscreen mode
	if (!window_get_fullscreen()) {alarm[0] = 10;}

}

/**
 * Toggles between fullscreen and windowed mode.
 * @example
 * // Toggle fullscreen
 * fullscreen_toggle();
 * 
 * @returns {boolean} Current fullscreen state after toggle
 */
function fullscreen_toggle(_pix_perf = true)
{
	//toggles full screen
	window_set_fullscreen(!window_get_fullscreen());
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2)*_pix_perf;
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? GAME_RES.h*pix_perf_zoom : GAME_RES.w;
	var pix_perf_h = window_get_fullscreen() ? GAME_RES.h*pix_perf_zoom : GAME_RES.w;
	
	//sets draw size
	var appsurf_draw_size_w = window_get_fullscreen() ? view_full_w : global._windowed_width;
	var appsurf_draw_size_h = window_get_fullscreen() ? view_full_h : global._windowed_height;
	
	//resizes dimensions
	camera_set_view_size(view,GAME_RES.w/2,GAME_RES.h/2);
	display_set_gui_size(GAME_RES.w,GAME_RES.h);
	surface_resize(application_surface,GAME_RES.w,GAME_RES.h);
	window_set_size(global._windowed_width,global._windowed_height);
	
 	//recenters window when getting out of fullscreen mode
	if (!window_get_fullscreen()) {alarm[0] = 10;}
	
	//returns full screen state
	return window_get_fullscreen();

}

/**
 * Adjusts camera zoom based on mouse wheel input.
 * @example
 * // Call each step to handle zoom
 * camera_set_zoom();
 */
function camera_set_zoom()
{
	//gets zoom inputs
	var zoom_input = mouse_wheel_up() - mouse_wheel_down();
	view_zoom = clamp(view_zoom+(zoom_speed*zoom_input),view_min_zoom,view_max_zoom);
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2);
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? GAME_RES.w*pix_perf_zoom : GAME_RES.w;
	var pix_perf_h = window_get_fullscreen() ? GAME_RES.h*pix_perf_zoom : GAME_RES.h;
	
	//sets view
	camera_set_view_size(view,pix_perf_w*view_zoom,pix_perf_h*view_zoom);
	camera_set_view_pos(view, x - camera_get_view_width(view)/2, y - camera_get_view_height(view)/2);
}

/**
 * Smoothly transitions camera zoom to a target scale.
 * @example
 * // Zoom to 2x scale
 * camera_lerp_zoom(2);
 * 
 * @example
 * // Zoom with custom speed
 * camera_lerp_zoom(1.5, 0.05);
 */
function camera_lerp_zoom(scale,zoom_spd = 0.025)
{
	view_scale = lerp(view_scale,scale,0.025);
	exit;
}

/**
 * Smoothly resets camera zoom to default.
 * @example
 * // Reset zoom
 * camera_reset_zoom();
 */
function camera_reset_zoom(zoom_spd = 0.025)
{
	view_scale = lerp(view_scale,global._display_height / GAME_RES.h, 0.025);	
}

/**
 * Updates camera position and handles screen shake.
 * @example
 * // Call each step to follow player
 * camera_set_position();
 */
function camera_set_position()
{
	
	//Positions Camera on the Controller
	var view_x = clamp(x - camera_get_view_width(view)/2, 0, room_width - camera_get_view_width(view));
	var view_y = clamp(y - camera_get_view_height(view)/2, 0, room_height - camera_get_view_height(view));

	//Calculates screen shake
	var shake_x = 0;
	var shake_y = 0;
	if(shake)
	{
		
		//substracts from timer
		shake_time--;
		
		//sets shake offset
		shake_x = choose(-shake_magnitude,shake_magnitude);
		shake_y = choose(-shake_magnitude,shake_magnitude);
		
		//starts decay once timer is done counting down
		if(shake_time <= 0) {
			
			//decays shake magnitude
			shake_magnitude -= shake_decay;
			
			//turns off shake effect
			if(shake_magnitude <= 0) {shake = false;}
			
		}
			
	}

	//Sets view position
	camera_set_view_pos(view,view_x+shake_x,view_y+shake_y);
	
}

/**
 * Links a player to a dedicated camera object.
 * @example
 * // In player's create event
 * player_link_to_camera();
 */
function player_link_to_camera(_p_id = id)
{
	//disables master camera
	if(instance_exists(global.master_camera)) {global.master_camera.camera_state = cameraStates.DISABLE;}
	
	//creates player camera
	var cam_id = instance_create_layer(x,y,layer,obj_player_camera);
	var _p_num = instance_number(PLAYER);
	
	//links camera and player
	//player vars
	camera_id = cam_id;
	//camera vars
	cam_id.player_id = _p_id;
	cam_id.player_number = _p_num;
	cam_id.following = _p_id;
	
	//enables view
	view_enabled = true;
	view_visible[_p_num] = true;
	
	//sets up view
	with(cam_id) {camera_setup(player_number);}
}

/**
 * Handles window resizing and fullscreen toggling.
 * @example
 * // Switch to fullscreen
 * camera_window_resize(true);
 * 
 * @example
 * // Set windowed mode with custom size
 * camera_window_resize(false, 1600, 900);
 */
function camera_window_resize(_p_full,_p_width=1280,_p_height=-1)
{
	if _p_full {
		if !window_get_fullscreen() {fullscreen_toggle()}
	} else {
		global._windowed_width=_p_width;
		global._windowed_height=(_p_height<0 ? floor(_p_width/4*3) : _p_height);
	
		/*//finds pixel perfect dimensions
		var pix_perf_w = GAME_RES.w;
		var pix_perf_h = GAME_RES.w;
	
		//sets draw size
		var appsurf_draw_size_w = global._windowed_width;
		var appsurf_draw_size_h = global._windowed_height;
	
		//resizes dimensions
		camera_set_view_size(view,pix_perf_w*view_zoom,pix_perf_h*view_zoom);
		display_set_gui_size(pix_perf_w, pix_perf_h);
		surface_resize(application_surface, appsurf_draw_size_w, appsurf_draw_size_h);
		window_set_size(appsurf_draw_size_w, appsurf_draw_size_h);
	
		//recenters window when getting out of fullscreen mode
		alarm[0] = 10;
	
		//returns full screen state*/
		camera_setup(global.master_view);
	}
		
}

/**
 * Calculates and sets view scaling values.
 * @example
 * // Update scaling values
 * set_scales();
 */
function set_scales() {
	view_scale = global._display_height / GAME_RES.h;
	view_w = GAME_RES.w * view_scale;
	view_h = GAME_RES.h * view_scale;
	view_full_scale = ((display_get_width()/1.5) / GAME_RES.w);
	view_full_w = GAME_RES.w * view_full_scale;
	view_full_h = GAME_RES.h * view_full_scale;
}