///@desc Create Shards
sprite_index = noone; 

repeat(6){
	instance_create_depth(x,y,0,obj_gameover_shard);
}

audio_play_sound(snd_shatter,0,false);

alarm[3]=60;