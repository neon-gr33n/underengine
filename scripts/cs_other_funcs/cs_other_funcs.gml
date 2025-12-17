/// @category Cutscenes
/// @title Other Functions


/// @func cutscene_wait(seconds)
/// @desc Pauses cutscene progression for a specified time
/// @desc Uses frame-based timer to wait before advancing to next cutscene action
/// @param {Number} seconds Time to wait in seconds (converted to frames internally)
function cutscene_wait(){
    /// @arg seconds
    
    timer++;
    
    if (timer >= argument0 * game_get_speed(gamespeed_fps)) {
        timer = 0; 
        cutscene_end_action();
    }
}
	
/// @func cutscene_wait_for_dialogue()
/// @desc Pauses cutscene progression until current dialogue typing completes
/// @desc Waits for text writer to finish displaying text before advancing cutscene
/// @desc Checks both that dialogue text is empty AND typist is in finished state
function cutscene_wait_for_dialogue(){
    /// @description cutscene_wait_for_dialogue
    
    timer++;
    
    // Bug fix: Changed assignment (=) to comparison (==) 
    if (obj_text_writer.dialogue.dialogueText == "" && obj_text_writer.typist.get_state() == 1) {
        timer = 0;  
        cutscene_end_action();
    }
}

/// @func cutscene_run_code(func, [...args])
/// @desc Executes arbitrary code during a cutscene with support for arguments
/// @desc Flexible function that can run any script or function as part of cutscene sequence
/// @param {Function} func Function to execute (script name or function reference)
/// @param {...Any} args Variable number of arguments to pass to the function
/// @example
/// // Execute a simple function without arguments
/// cutscene_run_code(function() {
///     show_debug_message("Cutscene code executed!");
/// });
function cutscene_run_code() {
    /// @arg func()
    
    var func = argument[0];
    var args = [];
    
    for (var i = 1; i < argument_count; i++) {
        args[i-1] = argument[i];
    }
    
    if (array_length(args) > 0) {
        script_execute_ext(func, args);
    } else {
        func();
    }
    
    cutscene_end_action();
}
	
/// @func cutscene_item_add(item, [quantity], [overflow])
/// @desc Adds an item to inventory during a cutscene
/// @desc Wrapper for inven_add_item() that automatically advances cutscene
/// @param {Asset|String} item Item to add (item asset ID or name)
/// @param {Number} [quantity=1] Number of items to add (default 1)
/// @param {Bool} [overflow=true] Allow inventory overflow beyond capacity (default true)
function cutscene_item_add(item, quantity=1, overflow=true){
    inven_add_item(item, quantity, overflow);
    cutscene_end_action();
}

/// @func cutscene_play_sound(soundid, [priority], [loops], [gain])
/// @desc Plays a sound effect during a cutscene
/// @desc Wrapper for audio_play_sound() that automatically advances cutscene
/// @param {Sound|Asset} soundid Sound asset to play (e.g., snd_door_open, snd_click)
/// @param {Number} [priority=0] Audio priority (0 = normal, higher = more important)
/// @param {Bool} [loops=false] Whether sound should loop continuously
/// @param {Number} [gain=1.0] Volume/gain level (0.0 = silent, 1.0 = full volume)
function cutscene_play_sound(){
    /// @arg soundid
    /// @arg priority
    /// @arg loops
    /// @arg gain
    
    audio_play_sound(argument0, argument1, argument2, argument3);
    cutscene_end_action();
}

/// @func cutscene_stop_sound(soundid)
/// @desc Stops a currently playing sound during a cutscene
/// @desc Wrapper for audio_stop_sound() that automatically advances cutscene
/// @param {Sound|Asset} soundid Sound asset to stop (must be currently playing)
function cutscene_stop_sound(){
    /// @arg soundid
 
    audio_stop_sound(argument0);
    cutscene_end_action();
}

/// @func cutscene_start_encounter(encounter, mus_id, mus_pitch, exclaim, quick, boss)
/// @desc Starts a battle encounter during a cutscene
/// @desc Wrapper for encounter_start() that automatically advances cutscene
/// @param {String} encounter Encounter identifier or name (e.g., "test") 
/// @param {String} mus_id Music track ID to play during encounter
/// @param {Number} mus_pitch Music pitch multiplier (1.0 = normal speed)
/// @param {Bool} exclaim Show exclamation mark "!" animation before encounter starts
/// @param {Bool} quick Use quick transition (skips some animations for faster start)
/// @param {Bool} boss Whether this is a boss encounter (
function cutscene_start_encounter(encounter, mus_id, mus_pitch, exclaim, quick, boss){
    encounter_start(encounter, mus_id, mus_pitch, exclaim, quick, boss);
    cutscene_end_action();
}