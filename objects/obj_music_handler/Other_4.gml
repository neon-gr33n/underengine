if(global.currentmus!=-1&&room!=rm_battle){
	VinylGainSet(global.currentmus,song_volume)
} else if(room!=rm_battle) {
	global.currentmus = VinylPlay(areasong)
	//VinylPlay(areasong,areasong_loopable,song_volume)
} 

//song = audio_play_sound(areasong,20,true,song_volume,areasong_pos,1);	