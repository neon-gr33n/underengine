if(flash<3){
	show_soul=!show_soul;
	if(show_soul){
		flash+=1;
		sfx_play(snd_noise,1,global.sfx_volume);
	}
	alarm[2]=2*(!fast ? 2 : 1);
}else{
	show_player=false;
	show_soul=true;
	var duration=15*(!fast ? 2 : 1);
	if (!boss){
		fade_shape(cutoutSprite, cutoutDur)
	}
	sfx_play(snd_encounter,1,global.sfx_volume);
	alarm[3]=20*(!fast ? 2 : 1);
}