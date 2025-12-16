if(live_call()) return live_result;
if surface_exists(application_surface) {
    // Only reset the target if we actually have a surface set as target
    if (surface_get_target() != -1) {
        surface_reset_target();
    }
	
	var _inputSurf = application_surface; // or view_get_surface(0);
    
//    gpu_set_blendenable(false);
					
	draw_surface_centered_ext(_inputSurf,
                                    (window_get_fullscreen() ? display_get_width()/2 : global._windowed_width/2),
                                    (window_get_fullscreen() ? display_get_height()/2 : global._windowed_height/2),
                                    window_get_fullscreen() ? view_full_scale : view_scale,
                                    window_get_fullscreen() ? view_full_scale : view_scale,
                                    0, c_white, 1);

	
	border_draw(global._border_id)
////    gpu_set_blendenable(true);

}
	
display_set_gui_maximize((window_get_fullscreen() ? display_get_width()/1.5 : global._display_width)/GAME_RES.w,(window_get_fullscreen() ? display_get_width()*3/1.5/4 : global._display_height)/GAME_RES.h,(window_get_fullscreen() ? (display_get_width()-(display_get_width()/1.5)) : global._windowed_width-global._display_width)/2,((window_get_fullscreen() ? display_get_height()-(display_get_width()*3/1.5/4) : global._windowed_height-global._display_height))/2)