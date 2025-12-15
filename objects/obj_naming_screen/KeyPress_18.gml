if DEVELOPERBUILD {
	mus_stop(global.currentmus[2])
	global.debug=true;
	global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "NAME"] = "Dev"
	instance_destroy(obj_music_handler)
	room_goto(rm_fallen)
}
