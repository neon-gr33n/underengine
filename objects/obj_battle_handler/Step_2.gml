CAM.following = noone
with(CAM){
	x=0
	y=0
	camera_set_position()
	view_zoom = 1;
	camera_set_zoom()
}
with(CAM) camera_setup(0, window_get_fullscreen(), true, 1)