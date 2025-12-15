snd = mus_whispers
range = 400
loops = true
if !audio_emitter_exists(global.ambEmitter) {
	global.ambEmitter	= audio_emitter_create()
}
audio_play_sound_on(global.ambEmitter, snd, loops, 1)
audio_emitter_gain(global.ambEmitter,	0)
audio_falloff_set_model(audio_falloff_linear_distance);
audio_emitter_falloff(global.ambEmitter, 200, 500, 1);

twn = 0;
TweenFire(id, EaseInOutQuad, TWEEN_MODE_PATROL, 0, 0, 120, "twn", -150, 150);