// This script plays a sound on a specific emitter.
///@arg soundid
///@arg pitch
///@arg volume
///@arg offset
///@arg priority
///@arg loopable
function sfx_play_on(soundid, pitch = 1, volume = 1, offset = 0, priority = 8, loopable=false) {
	return audio_play_sound_on(global.sfxEmitter, soundid, loopable, priority, volume, offset, pitch);
}