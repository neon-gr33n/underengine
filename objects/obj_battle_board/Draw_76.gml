if(!surface_exists(_board_surface)){
	_board_surface=surface_create(640,360);
}

surface_set_target(_board_surface);{
	draw_clear_alpha(0,0);
}surface_reset_target();