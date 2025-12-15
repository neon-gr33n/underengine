/**
 * Ends the current battle encounter and returns to the previous room.
 * Cleans up battle-specific resources and transitions back to the overworld.
 * 
 * @function encounter_end
 * @description Terminates the current battle sequence by stopping battle music,
 *              hiding the player's heart/cursor, destroying battle handler objects,
 *              and returning to the room where the encounter was initiated.
 *              This function handles the cleanup phase after battle completion.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Called when player wins a battle
 * if (all_enemies_defeated) {
 *     encounter_end();
 * }
 * 
 * @example
 * // Called when player flees from battle
 * if (flee_successful) {
 *     encounter_end();
 * }
 * 
 * @throws {Error} May fail silently if:
 *                 - HEART object doesn't exist
 *                 - obj_battle_handler doesn't exist
 *                 - Room saved in flags doesn't exist
 * 
 * @note This is a cleanup function - should be called after battle resolution.
 * @note Stops the current battle music track.
 * @note Hides the player's targeting cursor (HEART object).
 * @note Destroys the main battle controller (obj_battle_handler).
 * @note Sets a global flag to indicate party has been loaded.
 * @note Returns to the room saved at battle start.
 * @note Assumes the room to return to was saved in global.flags["rm_r"].
 * 
 * @see encounter_start - Function that initiates battles and saves the return room
 * @see global.flags - Global data structure storing game state information
 * @see HEART - Player's targeting cursor/selection object
 * @see obj_battle_handler - Main battle controller object
 * @see global.currentmus - Array containing current music track references
 * @see global.ploaded - Flag indicating party loading state
 * 
 * @sideeffects
 * - Stops battle music (global.currentmus[2])
 * - Hides HEART object (sets visible = false)
 * - Destroys obj_battle_handler instance
 * - Sets global.ploaded to 1
 * - Transitions to previously saved room
 * 
 * @global
 * @modifies global.currentmus[2] (stops music)
 * @modifies HEART.visible
 * @modifies global.ploaded
 * @destroys obj_battle_handler instance
 */
function encounter_end() {   
    // Stop battle music (index 2 in currentmus array)
    mus_stop(global.currentmus[2]);
    
    // Hide the player's targeting cursor/heart
    HEART.visible = false;
    
    // Destroy the main battle controller/manager
    instance_destroy(obj_battle_handler);
    
    // Set party loaded flag to indicate party should be restored
    global.ploaded = 1;
    
    // Return to the room where the encounter started
    // The room was saved in global.flags["rm_r"] by encounter_start()
    room_goto(flag_get(global.flags, "rm_r"));
}