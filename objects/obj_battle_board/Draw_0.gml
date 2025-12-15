if !surface_exists(_surface){
	_surface = surface_create(GAME_RES.w,GAME_RES.h);
}

// Test
//surface_set_target(_surface)
//	draw_rectangle_color(0, 0, 640, 480, c_red, c_blue, c_green, c_yellow, false);
//surface_reset_target();

// If the battle board has changed
if !array_equals(_vertex_array, _last_vertex_array) {
	// Gets and creates the new board
	var _array_size = array_length(_vertex_array);
	_last_vertex_array = [];
	array_copy(_last_vertex_array, 0, _vertex_array, 0,_array_size);
	var _temp = [];
	array_copy(_temp, 0, _vertex_array, 0, _array_size);
	_tris = polygon_arr_to_triangles(_temp);
	
	
	// Creates the surace vertex buffer
	if buffer_exists(surf_buff) buffer_delete(surf_buff);
	surf_buff = vertex_create_buffer();
	
	vertex_begin(surf_buff, surf_format); {
		for (var i = 0; i < array_length(_tris); i++) {
			var __x = x + _tris[i][0];
			var __y = y + _tris[i][1];
			vertex_position(surf_buff, __x, __y);
			vertex_texcoord(surf_buff, __x / 640, __y / 480);
			vertex_color(surf_buff, c_white, 1);
		}
	} vertex_end(surf_buff);
	
	
	// Creates the outline vertex buffer
	if buffer_exists(ring_buff) buffer_delete(ring_buff);
	ring_buff = vertex_create_buffer();
	
	vertex_begin(ring_buff, ring_format); {
		for (var i = 0; i < _array_size + 1; i++) {
			var __x = x + _vertex_array[i % _array_size][0];
			var __y = y + _vertex_array[i % _array_size][1];
			vertex_position(ring_buff, __x, __y);
			vertex_color(ring_buff, c_white, 1);
			
			var __sub_dir = point_direction(_vertex_array[i % _array_size][0], _vertex_array[i % _array_size][1], _vertex_array[(i - 1 + _array_size) % _array_size][0], _vertex_array[(i - 1 + _array_size) % _array_size][1]);
			var __add_dir = point_direction(_vertex_array[i % _array_size][0], _vertex_array[i % _array_size][1], _vertex_array[(i + 1) % _array_size][0], _vertex_array[(i + 1) % _array_size][1]);
			if __sub_dir < __add_dir __sub_dir += 360;
			var __final_dir = (__sub_dir + __add_dir) / 2;
			var _point_dist = thickness_frame / (dcos((__sub_dir - __add_dir) / 2 - 90));
			vertex_position(ring_buff, __x + lengthdir_x(_point_dist, __final_dir), __y + lengthdir_y(_point_dist, __final_dir));
			vertex_color(ring_buff, c_white, 1);
		}
	} vertex_end(ring_buff);
}

// Draws the board
vertex_submit(surf_buff, pr_trianglelist, surface_get_texture(_surface));
vertex_submit(ring_buff, pr_trianglestrip, -1)