///@arg soundid
///@arg pitch
///@arg volume
///@arg offset
///@arg priority
///@arg loopable
function sfx_playc(soundid, pitch=1, volume=1, offset=0, priority = 8, loopable=false){
	return audio_play_sound(soundid,priority,loopable,volume,0,pitch);	
}
