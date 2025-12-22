if room!=rm_battle && room!=rm_shop fname=(global.room_data[$ "ROOMS"][$ global.room_data[$ "__ROOM__"][$ room_get_name(room)]][$ "THEME"]==undefined ? fname : global.room_data[$ "ROOMS"][$ global.room_data[$ "__ROOM__"][$ room_get_name(room)]][$ "THEME"])
else fname=noone;
if fname==noone mus_stop(global.currentmus[0])
else {
	if(room!=rm_battle&& room!=rm_shop&&!paused){
		//show_message(string(mus_load(fname))+string(audio_get_name(global.currentmus[0])))
	mus_playx(mus_load(fname), true, volume, pos, pitch,0);	
	} else if(room!=rm_battle&& room!=rm_shop&&paused){
		mus_set_volume(global.currentmus[0],volume,0.25,false)
		mus_resume(global.currentmus[0]);
		paused=false;
	}
}
