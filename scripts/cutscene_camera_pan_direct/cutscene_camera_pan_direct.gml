
function cutscene_camera_pan_direct(){
///@arg x
///@arg y
///@arg spd

	with(CAM)
	{ 
			TweenFire(CAM,EaseLinear,0,0,0,argument2,"x",x,argument0)
			TweenFire(CAM,EaseLinear,0,0,0,argument2,"y",y,argument1)
	}

}