/// @description Draws a representation when debugging

if(UTE_DEBUG_MODE)
{
	//draws grid
	draw_grid(GRID_CELL_SIZE);
	
	//draws camera position
	draw_camera(c_ltgray);
	
	//draws view positions
	draw_view(global.master_view);
}
