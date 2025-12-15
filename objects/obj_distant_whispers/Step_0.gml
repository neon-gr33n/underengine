var dist, falloff;
dist = distance_to_object(PLAYER1)
if (dist <= range)
{
    falloff = ((range - dist) / range)
    audio_emitter_gain(global.ambEmitter, (falloff/2 * 0.5))
	audio_listener_position(twn, 0, 0);
	audio_emitter_position(global.ambEmitter,0,0,0)
}
else
    audio_emitter_gain(global.ambEmitter, 0)
