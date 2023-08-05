
function cutscene_camera_pan_simple(){
///@arg targetDir
///@arg moveByUnits
///@arg spd

	with(CAM)
	{ 
			if argument0 == "left" {
			TweenFire(CAM,EaseLinear,0,0,0,argument2,"x",x,-argument1)
			} else if argument0 == "right" {
			TweenFire(CAM,EaseLinear,0,0,0,argument2,"x",x,argument1)
			}
			
			if argument0 == "up" {
				TweenFire(CAM,EaseLinear,0,0,0,argument2,"y",y,argument1)
			} else if argument0 == "down" {
				TweenFire(CAM,EaseLinear,0,0,0,argument2,"y",y,argument1)	
			}
	}

}