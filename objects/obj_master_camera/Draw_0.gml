/// @description Draws a representation when debugging
//draw_surface(application_surface,0,0)
if(live_call()) return live_result;

if(global.debug)
{
	//draws grid
	draw_grid(GRID_CELL_SIZE);
	//sets alpha
	//gridcell_size=GRID_CELL_SIZE;c_grid=c_orange;grid_alpha=0.25;
	//var alpha = draw_get_alpha()
	//draw_set_alpha(grid_alpha);
	
	////draws vertical line
	//for(var i = 1; i < room_width/gridcell_size; i++)
	//{

	//	//draws lines
	//	var x_offset = i * gridcell_size - 1;
	//	draw_line_color(x_offset,0,x_offset,room_height,c_grid,c_grid);
		
	//}
	
	//	draw_rectangle_color(0, 0, 640, 480, c_grid, c_grid, c_grid, c_grid, false)
	////draws horizontal line
	//for(var i = 1; i < room_height/gridcell_size; i++)
	//{
	//	//draws lines
	//	var y_offset = i * gridcell_size - 1;
	//	draw_line_color(0,y_offset,room_width,y_offset,c_grid,c_grid);
		
	//}
	
	//draws camera position
	draw_camera(c_ltgray);
	
	//draws view positions
	draw_view(global.master_view);
}