///@category Sound
///@title SFX Functions

/// @function sfx_gain(soundid, level, [time])
/// @description Gradually increases the volume of a sound effect over time.
/// @param {sound} soundid The sound to adjust
/// @param {number} level Target volume level (0.0 to 1.0)
/// @param {number} [time=0] Fade duration in frames/milliseconds
/// @returns {number} Returns the result of audio_sound_gain
function sfx_gain(soundid, level, time=0){
	return audio_sound_gain(soundid, level, time);
}

/// @function sfx_get_pitch(soundid)
/// @description Gets the current pitch of a sound.
/// @param {sound} soundid The sound to check
/// @returns {number} Current pitch value
function sfx_get_pitch(soundid){
	return audio_sound_get_pitch(soundid);	
}

/// @function sfx_pan(soundid, priority, loop, pan)
/// @description Positions a sound in the stereo field (left/right panning).
/// @param {sound} soundid The sound to play with panning
/// @param {number} priority Playback priority
/// @param {boolean} loop Whether to loop the sound
/// @param {number} pan Pan position (-1 = left, 0 = center, 1 = right)
/// @returns {number} Returns the sound instance ID
// This script pans the audio either to the left or right
function sfx_pan(){
///@arg soundid
///@arg priority
///@arg loop
///@arg pan

audio_falloff_set_model(audio_falloff_linear_distance);
return audio_play_sound_at(argument0, -median(-1, argument3, 1), 0, 0, 1, 0, 0, argument2, argument1);
}

/// @function sfx_pitch(soundid, [pitch])
/// @description Adjusts the pitch of a sound.
/// @param {sound} soundid The sound to modify
/// @param {number} [pitch=1] Target pitch (1.0 = normal)
/// @returns {number} Returns the result of audio_sound_pitch
function sfx_pitch(soundid,pitch=1){
	return audio_sound_pitch(soundid,pitch);
}

/// @function sfx_play(soundid, [pitch], [volume], [offset], [priority], [loopable])
/// @description Plays a sound effect with customizable parameters.
/// @param {sound} soundid The sound to play
/// @param {number} [pitch=1] Pitch adjustment (1.0 = normal)
/// @param {number} [volume=global.sfx_volume] Volume level (0.0 to 1.0)
/// @param {number} [offset=0] Starting position in milliseconds
/// @param {number} [priority=8] Playback priority
/// @param {boolean} [loopable=false] Whether the sound should loop
/// @returns {number} Returns the sound instance ID
function sfx_play(soundid, pitch=1, volume=global.sfx_volume, offset=0, priority = 8, loopable=false){
	return audio_play_sound(soundid,priority,loopable,volume,0,pitch);	
}

/// @function sfx_play_on(soundid, [pitch], [volume], [offset], [priority], [loopable])
/// @description Plays a sound effect on a specific audio emitter.
/// @param {sound} soundid The sound to play
/// @param {number} [pitch=1] Pitch adjustment (1.0 = normal)
/// @param {number} [volume=1] Volume level (0.0 to 1.0)
/// @param {number} [offset=0] Starting position in milliseconds
/// @param {number} [priority=8] Playback priority
/// @param {boolean} [loopable=false] Whether the sound should loop
/// @returns {number} Returns the sound instance ID
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

/// @function sfx_stop(soundid)
/// @description Stops playback of a specific sound.
/// @param {sound} soundid The sound to stop
/// @returns {number} Returns the result of audio_stop_sound
// This script stops a sound.
function sfx_stop(soundid) {
	return audio_stop_sound(soundid);
}