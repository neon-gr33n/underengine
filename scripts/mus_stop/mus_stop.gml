///@arg streamid
// Denitializes an external music file and destroys the stream
function mus_stop(streamid){
	audio_stop_sound(streamid)
	audio_destroy_stream(streamid)
}