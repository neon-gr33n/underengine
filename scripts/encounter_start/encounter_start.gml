/// @category Battle
/// @title Encounter Start
/// @function encounter_start(_battlegroup_id, [_mus_id], [_mus_pitch], [_exclaim], [_quick], [_boss])
/// @description Starts a battle encounter with specified parameters
/// @param {string} _battlegroup_id Identifier for the enemy battlegroup to encounter
/// @param {string} [_mus_id="battle"] Music track to play during battle
/// @param {number} [_mus_pitch=0.95] Pitch adjustment for battle music
/// @param {boolean} [_exclaim=true] Show exclamation animation in overworld
/// @param {boolean} [_quick=false] Make exclamation animation quick
/// @param {boolean} [_boss=false] Mark as boss battle
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
}