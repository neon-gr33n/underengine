///@arg filename
///@param {boolean} loopable
///@param {int} volume
///@param {int} pitch
///@param {int} time
///@param {int} index
function mus_playx_on(fname,loopable, volume=1, pitch=1, time=0, index = 0){
	global.currentmus=audio_play_sound_on(global.musEmitter,filename,loopable,global.muspriority);
	mus_set_volume(global.currentmus,volume,time=0,instant=true);
	mus_set_pitch(global.currentmus, pitch);
	return music;
}