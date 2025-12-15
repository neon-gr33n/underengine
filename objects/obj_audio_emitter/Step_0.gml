if audio_exists(snd) && start {
	if !mono {
		var dist, falloff;
		dist = distance_to_object(PLAYER1)
		if (dist <= range)
		{
		    falloff = ((range - dist) / range)
		    audio_emitter_gain(e_id, (falloff/2 * 0.5)*gain)
			audio_listener_position(0, 0, 0);
			audio_emitter_position(e_id,0,0,0)
		}
		else
		    audio_emitter_gain(e_id, 0)
	}
}