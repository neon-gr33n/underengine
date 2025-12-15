///@arg streamid
///@param {int} volume
///@param {int} time
///@param {boolean} instant - is the fade over time or instantenous end of track?
/// Sets the volume of the given stream over a period of time
function mus_set_volume(streamid,volume=1,time=0,instant=false){
	return audio_sound_gain(streamid, volume, instant ? 0:(10 / room_speed) * 1000);
}