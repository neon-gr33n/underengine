/**
 * Initiates a battle encounter with specified parameters.
 * Transitions from overworld to battle scene with configurable effects and music.
 * 
 * @function encounter_start
 * @description Starts a battle encounter by setting up battle parameters, saving party position,
 *              playing battle music, and transitioning to the battle room. Can optionally show
 *              an exclamation animation in the overworld before transitioning.
 * 
 * @param {string} _battlegroup_id - Identifier for the enemy battlegroup to encounter.
 *                                   Determines which enemies will appear in battle.
 * @param {string} [_mus_id="battle"] - Music track to play during battle.
 *                                      Defaults to "battle". Should correspond to a file in mus folder.
 * @param {number} [_mus_pitch=0.95] - Pitch adjustment for battle music.
 *                                  Defaults to 0.95 (normal pitch). Values > 0.95 increase pitch.
 * @param {boolean} [_exclaim=true] - Whether to show exclamation animation in overworld.
 *                                    Defaults to true. If false, transitions immediately.
 * @param {boolean} [_quick=false] - Whether the exclamation animation should be quick.
 *                                   Defaults to false (normal speed).
 * @param {boolean} [_boss=false] - Whether this is a boss battle.
 *                                  Defaults to false. May affect battle mechanics or visuals.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Start a normal battle with goblin group, default music
 * encounter_start("battlegroup_goblins");
 * 
 * @example
 * // Start a boss battle with special music, no exclamation animation
 * encounter_start("battlegroup_final_boss", "boss_music", 1, false, false, true);
 * 
 * @example
 * // Quick transition with custom music pitch
 * encounter_start("battlegroup_wolves", "battle_dark", 0.8, true, true);
 * 
 * @throws {Error} May fail if battlegroup_id doesn't exist or music file is missing.
 * 
 * @note This function saves the player's current position before battle.
 * @note Overworld music is stopped when battle starts.
 * @note If _exclaim is false, a fade transition is used instead of animation.
 * @note The function sets various global flags for battle state management.
 * 
 * @see encounter_battlegroup_get - Function that retrieves the specified battlegroup
 * @see obj_encounter_anim - Object that handles the exclamation animation
 * @see rm_battle - The battle room that will be transitioned to
 * 
 * @sideeffects
 * - Sets global.battlemus to the specified music ID
 * - Stops current music tracks (global.currentmus[0] and global.currentmus[2])
 * - Sets global flags for party position (partyX, partyY)
 * - Sets global flag for current room (rm_r)
 * - Either creates an exclamation animation instance or performs a fade transition
 * - Eventually transitions to rm_battle room
 * 
 * @global
 * @modifies global.battlemus
 * @modifies global.flags
 * @modifies global.currentmus (stops music)
 */
function encounter_start(_battlegroup_id, _mus_id = "battle", _mus_pitch = 0.95, _exclaim = true, _quick = false, _boss = false) {
    /// @desc Starts the enemy encounter with the given battle group
    /// @arg battlegroup_id - String value, determines what group of enemies to encounter
    /// @arg mus_id  - String value, determines what song to play from the mus folder
    /// @arg mus_pitch - Floating point value, determines what pitch to set our music to
    /// @param exclaim*  - Show an exclamation animation in the overworld?
    /// @param quick* - Should the animation be quick?
    /// @param boss* - Are we entering a boss battle?
    
    // Set battle music track
    global.battlemus = _mus_id;
    
    // Stop current music tracks (overworld music)
    mus_stop(global.currentmus[0]);
    mus_stop(global.currentmus[2]);
    
    // Retrieve the specified battlegroup configuration
    encounter_battlegroup_get(_battlegroup_id);
    
    // Save party position for return after battle
    flag_set(global.flags, "partyX", PLAYER1.x);
    flag_set(global.flags, "partyY", PLAYER1.y);
    
    // Save current room for return after battle
    flag_set(global.flags, "rm_r", room);
    
    // Handle transition based on exclamation setting
    if (!_exclaim) {
        // Immediate transition with fade effect
        fade_basic(0, 1, 30);
        room_goto(rm_battle);
    } else {
        // Create exclamation animation with battlegroup data
        var inst = instance_create(0, 0, obj_encounter_anim);
		global.battlemus_pitch = _mus_pitch
        with (inst) {
            battlegroup = _battlegroup_id;
			fast = _quick
			boss = _boss;
            // Note: Additional animation parameters could be set here
            // e.g., quick = _quick, boss = _boss
        }
    }
    
    // Note: Music pitch parameter (_mus_pitch) is received but not used in current implementation
    // This could be implemented with: audio_sound_pitch() or similar function
}