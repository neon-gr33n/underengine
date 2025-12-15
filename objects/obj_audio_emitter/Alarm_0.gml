if !audio_emitter_exists(global.ambEmitter) {
	global.ambEmitter	= audio_emitter_create()
}
audio_play_sound_on(e_id, snd, loops,1)
audio_emitter_gain(e_id,gain)
if !mono {
	audio_falloff_set_model(audio_falloff_linear_distance);
	audio_emitter_falloff(e_id, 200, 500, 1);
}

start=true