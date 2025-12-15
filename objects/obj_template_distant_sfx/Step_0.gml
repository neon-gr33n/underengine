var dist, falloff;
dist = distance_to_object(PLAYER1)
if (dist <= range)
{
    falloff = ((range - dist) / range)
    audio_emitter_gain(global.ambEmitter, (falloff * global.snd_vol))
}
else
    audio_emitter_gain(global.ambEmitter, 0)
