function cutscene_cam_zoom(){
	var zoom_amt = argument0
	if instance_exists(CAM) with(CAM)
	{
		cam1.zoom(zoom_amt,room_speed*0.5);
	}

}