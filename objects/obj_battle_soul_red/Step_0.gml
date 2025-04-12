///desc Process States
if currentState == "soulMoving" 
{
	var dx = check("right") - check("left")
	var dy = check("down") - check("up")
	if place_meeting(x+dx, y+dy, obj_battle_board) {
		repeat(spd * 10){
				if(!place_meeting(x,y-1,obj_battle_board)){
					if check("up") { y-=0.1}  
				}
				if(!place_meeting(x,y+1,obj_battle_board)){
					if check("down") { y+=0.1}
				}
				if(!place_meeting(x-1,y,obj_battle_board)){
					if check("left") {x-=0.1} 
				}
				if(!place_meeting(x+1,y,obj_battle_board)){
					if check("right") {x+=0.1}
				} else {
					// do nothing	
				}
		}
	} else {
	    x += dx * spd
	    y += dy * spd
	}
	if check("cancel") { spd = 1; } else { spd = 2; };
	
	var _invTimer = 0
	if(place_meeting(x,y, obj_parent_bullet) && _hurting == 0){ 
		_hurting = 1
		image_speed = 0.2
		sfx_playc(snd_hit)
		instance_create(0,0,obj_shaker)
	}
	if _hurting == 1 
	{
		_invTimer++
		if (_invTimer == 60)
		{
			_hurting = 0
			image_speed = 0
			image_index = 0 
		}
	}
}
	

if currentState == "inMenu" 
{ /* do nothing */ }