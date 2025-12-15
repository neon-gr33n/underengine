with(PLAYER1) {
	var _si = sprite_index;
	var _ii = image_index;
	
	sprite_index=spr_frisk_hitbox;
	image_index=0;
}

if place_meeting(x,y,PLAYER1) {
	if room_exists(target) {
		persistent=true
		room_goto(target)
		alarm[0]=1
	}
}

with(PLAYER1) {
	sprite_index=_si;
	image_index=_ii;
}
