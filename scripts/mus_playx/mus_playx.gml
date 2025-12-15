///@arg filename
///@param {boolean} loopable
///@param {int} volume
///@param {int} offset
///@param {int} pitch
///@param {int} index - Default is 0 (OW Music), 1 is Battle Music, 2 is Cutscene/Ambience
function mus_playx(fname, loopable, volume=global.mus_volume, offset=0, pitch=1, index = 0){
	if !audio_is_playing(global.currentmus[index])&&audio_get_name(global.currentmus[index])!=fname {
	global.currentmus[index]=audio_play_sound(fname,global.muspriority,loopable,volume,offset,pitch);
	mus_set_pitch(global.currentmus[index],pitch);
	mus_set_volume(global.currentmus[index],volume);
	}
}