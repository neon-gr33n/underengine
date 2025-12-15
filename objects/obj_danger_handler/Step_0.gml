if(!_override){
	if(!place_meeting(x,y,PLAYER1)){
		TweenFire(obj_danger_handler,EaseLinear,0,0,0,15,"image_alpha",0,0.7);
		global.danger = false;
	} else if(place_meeting(x,y,PLAYER1)){
		TweenFire(PLAYER1,EaseLinear,0,0,0,15,"_hud_alpha",1,0);
		global.danger = true;
		//TweenFire(obj_danger_handler,EaseLinear,0,0,0,15,"image_alpha",image_alpha,0)
	}
}