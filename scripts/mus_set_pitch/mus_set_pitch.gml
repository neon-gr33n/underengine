///@arg streamid
///@param {int} pitch
function mus_set_pitch(streamid,pitch=1){
	return audio_sound_pitch(streamid, pitch);
}	