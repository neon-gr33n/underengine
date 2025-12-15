if(live_call()) return live_result;

/*if !surface_exists(_board_surface){
	_board_surface = surface_create(GAME_RES.w,GAME_RES.h);
}

//surface_set_target(_board_surface);
//	draw_rectangle_colour(0, 0, 640, 480, c_red, c_yellow, c_blue, c_green, false);
//surface_reset_target();

var _scale, _slice9, _left, _right, _up, _down;
_scale = window_get_fullscreen() ? obj_master_camera.view_full_scale : obj_master_camera.view_scale;
_slice9 = sprite_get_nineslice(sprite_index);
_left = _slice9.left;
_right = _slice9.right;
_up = _slice9.top;
_down = _slice9.bottom;

//draw_clear_alpha(0,0);
draw_surface_part_ext(_board_surface, x - left + _left, y - up + _up, left + right - (_left + _right), up + down - (_up + _down), (x - left + _left) * _scale, (y - up + _up) * _scale, _scale, _scale, c_white, 1)*/