/// @arg soundid
/// @param level
/// @param time - The amount of time (in frames/ms) it takes to increase volume
function sfx_gain(soundid, level, time=0){
	return audio_sound_gain(soundid, level, time);
}