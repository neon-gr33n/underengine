if(!_stop_attacking) && !speech_bubble_exists(){
	//audio_play_sound_on(global._gmu_emitter_sfx,snd_,0,false);
	if(_fly_count<6){
		var fly = instance_create_depth(0,0,-500,obj_bullet_fly)
		with(fly){
			_is_homing = true;	
		}
	}
	alarm[0]=60;
	alarm[1]=20;
}