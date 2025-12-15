///@arg soundid
///@arg pitch
///@arg volume
///@arg offset
///@arg priority
///@arg loopable
function sfx_play(soundid, pitch=1, volume=global.sfx_volume, offset=0, priority = 8, loopable=false){
	return audio_play_sound(soundid,priority,loopable,volume,0,pitch);	
}