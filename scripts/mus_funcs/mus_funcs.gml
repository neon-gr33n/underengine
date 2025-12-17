/// @category Sound
/// @title BGM Functions
/// @desc Functions for loading and managing background music files

/// @func mus_playx(fname, loopable, [volume], [offset], [pitch], [index])
/// @desc Plays the loaded BGM at a specific index with comprehensive audio controls
/// @desc Only plays if the specified music slot is not already playing the requested file
/// @param {String} fname Audio asset name to play
/// @param {Bool} loopable Whether the music should loop continuously
/// @param {Number} [volume=global.mus_volume] Playback volume (0-1 or 0-100 depending on system)
/// @param {Number} [offset=0] Starting position in seconds
/// @param {Number} [pitch=1] Pitch multiplier (1.0 = normal speed)
/// @param {Number} [index=0] Music slot index (0 = Overworld, 1 = Battle, 2 = Cutscene/Ambience)
/// @example
/// // Play overworld theme with looping
/// mus_playx(mus_load("overworld"), true, 0.8, 0, 1.0, 0);
/// 
/// // Play battle music without looping
/// mus_playx(mus_load("battle"), false, 1.0, 0, 1.0, 1);
function mus_playx(fname, loopable, volume=global.mus_volume, offset=0, pitch=1, index = 0){
	if !audio_is_playing(global.currentmus[index])&&audio_get_name(global.currentmus[index])!=fname {
		global.currentmus[index]=audio_play_sound(fname,global.muspriority,loopable,volume,offset,pitch);
		mus_set_pitch(global.currentmus[index],pitch);
		mus_set_volume(global.currentmus[index],volume);
	}
}

/// @func mus_playx_on(fname, loopable, [volume], [pitch], [time], [index])
/// @desc Plays BGM on a specific audio emitter with gradual volume/pitch changes
/// @desc Uses spatial audio features for positioned sound playback
/// @param {String} fname Audio asset name to play
/// @param {Bool} loopable Whether the music should loop continuously
/// @param {Number} [volume=1] Initial playback volume (0-1)
/// @param {Number} [pitch=1] Pitch multiplier (1.0 = normal speed)
/// @param {Number} [time=0] Time in seconds for volume fade-in
/// @param {Number} [index=0] Music slot index for tracking
/// @return {Number} Audio instance ID of the playing sound
/// @example
/// // Play music on the global music emitter with fade-in
/// var music_id = mus_playx_on(mus_load("dungeon", true, 0.7, 1.0, 2.0, 0);
/// 
/// // Play instant battle music
/// var battle_music = mus_playx_on(mus_load("battle", false, 1.0, 1.2, 0, 1);
function mus_playx_on(fname, loopable, volume=1, pitch=1, time=0, index = 0){
    // Store the audio instance in the appropriate index
    global.currentmus[index] = audio_play_sound_on(global.musEmitter, fname, loopable, global.muspriority);
    
    // Apply volume with optional fade-in
    if (time > 0) {
        mus_set_volume(global.currentmus[index], volume, time);
    } else {
        mus_set_volume(global.currentmus[index], volume);
    }
    
    // Apply pitch setting
    mus_set_pitch(global.currentmus[index], pitch);
    
    return global.currentmus[index];
}

/// @func mus_load(fname)
/// @desc Loads an external music file and creates an audio stream for playback
/// @desc Searches in platform-specific music directories for OGG format files
/// @param {String} fname Name of the music file (without extension)
/// @return {Number|Real} Audio stream handle if loaded successfully, -1 if file not found
/// @example
/// var bgm_handle = mus_load("town_theme");
/// if (bgm_handle != -1) {
///     audio_play_sound(bgm_handle, 0, false);
/// } else {
///     show_debug_message("Failed to load background music");
/// }
function mus_load(fname) {
    var _path = "";
    var type = ".ogg";
    
    if (is_android()) {
        _path = "assets/data/mus/";
    } else {
        _path = "./data/mus/";
    }
    
    var full_path = _path + fname + type;
    show_debug_message("Attempting to load music: " + full_path);
    
    if (file_exists(full_path)) {
        return audio_create_stream(full_path);
    } else {
        show_debug_message("Music file not found: " + full_path);
        return -1;
    }
}

/// @func mus_pause(streamid)
/// @desc Pauses playback of a music stream
/// @param {Number|Real} streamid Audio stream handle to pause
/// @return {Bool} Returns true if successful, false if failed
/// @example
/// // Assuming bgm_handle is a valid audio stream
/// if (mus_pause(bgm_handle)) {
///     show_debug_message("Music paused successfully");
/// }
function mus_pause(streamid){
	return audio_pause_sound(streamid);	
}



/// @func mus_resume(streamid)
/// @desc Resumes playback of a previously paused music stream
/// @param {Number|Real} streamid Audio stream handle to resume
/// @return {Bool} Returns true if successful, false if failed
/// @example
/// // Resume a paused music stream
/// if (mus_resume(paused_bgm)) {
///     show_debug_message("Music resumed successfully");
/// } else {
///     show_debug_message("Failed to resume music");
/// }
function mus_resume(streamid){
	return audio_resume_sound(streamid);	
}

/// @func mus_set_pitch(streamid, [pitch])
/// @desc Sets the playback pitch of a music stream
/// @param {Number|Real} streamid Audio stream handle to modify
/// @param {Number} [pitch=1] Pitch multiplier (1.0 = normal speed, 0.5 = half speed, 2.0 = double speed)
/// @return {Bool} Returns true if successful, false if failed
/// @example
/// // Slow down music for dramatic effect
/// if (mus_set_pitch(bgm_handle, 0.75)) {
///     show_debug_message("Music pitch lowered successfully");
/// }
/// 
/// // Reset to normal speed
/// mus_set_pitch(bgm_handle, 1.0);
function mus_set_pitch(streamid, pitch=1){
	return audio_sound_pitch(streamid, pitch);
}

/// @func mus_set_volume(streamid, [volume], [time], [instant])
/// @desc Sets the volume of a music stream with optional fade transition
/// @desc Supports both instant volume changes and gradual fades over time
/// @param {Number|Real} streamid Audio stream handle to modify
/// @param {Number} [volume=1] Target volume level (0-1)
/// @param {Number} [time=0] Time in seconds for volume transition (0 = instant)
/// @param {Bool} [instant=false] DEPRECATED - Use time=0 instead for instant changes
/// @return {Bool} Returns true if successful, false if failed
/// @example
/// // Instant volume change to 50%
/// mus_set_volume(bgm_handle, 0.5);
/// 
/// // Gradual fade to silence over 3 seconds
/// mus_set_volume(bgm_handle, 0, 3);
/// 
/// // Instant mute (legacy parameter style)
/// mus_set_volume(bgm_handle, 0, 0, true);
function mus_set_volume(streamid, volume=1, time=0, instant=false){
    // Calculate transition time in milliseconds
    var transition_time = 0;
    
    if (instant) {
        transition_time = 0; // Instant change
    } else if (time > 0) {
        transition_time = time * 1000; // Convert seconds to milliseconds
    } else {
        transition_time = 0; // Default to instant
    }
    
    return audio_sound_gain(streamid, volume, transition_time);
}

/// @func mus_stop(streamid)
/// @desc Stops playback and destroys an audio stream, freeing its resources
/// @desc Combines audio_stop_sound() and audio_destroy_stream() for convenience
/// @param {Number|Real} streamid Audio stream handle to stop and destroy
/// @example
/// // Stop and clean up a music stream
/// mus_stop(bgm_handle);
/// bgm_handle = -1; // Mark as invalid
function mus_stop(streamid){
    audio_stop_sound(streamid);
    audio_destroy_stream(streamid);
}