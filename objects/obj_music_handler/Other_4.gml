if(global.currentmus!=-1&&room!=rm_battle){
	mus_resume(global.currentmus)	
	mus_set_volume(global.currentmus,song_volume,0.25,false)
} else if(room!=rm_battle) {
	song = mus_playx(mus_load(areasong), true, song_volume,
	areasong_pos, areasong_pitch);	
} 

//song = audio_play_sound(areasong,20,true,song_volume,areasong_pos,1);	