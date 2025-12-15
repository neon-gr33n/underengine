if (player_is_dead()) {
//	if instance_exists(obj_danger_handler) with (obj_danger_handler) { _override = true }
//	global.danger = true;
	audio_stop_all()
	room_goto(rm_gameover)
}

if (flag_get(global.flags,"geno") == 1){
	global.running_enabled = false;	
	spriteIdle = spr_frisk_idle_geno;
	spriteMove = spr_frisk_move_geno
	alarm[1] = 30;
}