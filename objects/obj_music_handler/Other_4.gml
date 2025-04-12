if(global.currentmus!=-1&&room!=rm_battle){
	VinylGainSet(global.currentmus,song_volume)
} else if(room!=rm_battle) {
	if(areasong != undefined) {
		global.currentmus = VinylPlay(areasong)
	if(areasong!="" && __LOAD_MUS_FROM_INCLUDED_FILES == true){
		global.currentmus = VinylPlay(areasong)
	}
	}else {
		/* do nothing */
	}
	//VinylPlay(areasong,areasong_loopable,song_volume)
} 

//song = audio_play_sound(areasong,20,true,song_volume,areasong_pos,1);	