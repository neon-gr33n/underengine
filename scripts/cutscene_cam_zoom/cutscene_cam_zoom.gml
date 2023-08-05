function cutscene_cam_zoom(){
	var zoom_amt = argument0
	var duration = argument1;
	if instance_exists(CAM) with(CAM)
	{
			TweenFire(CAM,EaseLinear,0,0,0,duration,"cam1.zoom_amount",cam1.zoom_amount,zoom_amt)
	}

}