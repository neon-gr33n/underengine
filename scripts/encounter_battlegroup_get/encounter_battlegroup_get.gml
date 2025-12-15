/**
 * Retrieves and sets up a predefined battlegroup of enemies for an encounter.
 * Maps battlegroup identifiers to specific enemy configurations.
 * 
 * @function encounter_battlegroup_get
 * @description Fetches a predefined enemy battlegroup configuration and sets up the encounter.
 *              Acts as a lookup table that maps battlegroup IDs to specific enemy arrangements.
 *              Each case sets up enemies in specific battle positions (left, center, right slots).
 * 
 * @param {string} _group_id - Identifier for the battlegroup to fetch.
 *                             Determines which enemy configuration to use.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Setup a test battlegroup with Toaddit on left and Whimsun on right
 * encounter_battlegroup_get("test");
 * 
 * @example
 * // Setup a single Toaddit in the center position
 * encounter_battlegroup_get("toaddit_s");
 * 
 * @throws {Error} If _group_id doesn't match any case, nothing happens (silent failure).
 *                 Consider adding a default case for error handling.
 * 
 * @note This function acts as a configuration lookup - add new battlegroups here.
 * @note Enemy IDs (like "TOADDIT", "WHIMSUN") should exist in global.ENEMY_INFO.
 * @note Positions: slot 0 = left, slot 1 = center, slot 2 = right.
 * @note "_s" suffix typically indicates a single enemy in center position.
 * 
 * @see encounter_setup - Function that actually configures the enemy slots
 * @see global.ENEMY_INFO - Global data structure containing enemy definitions
 * 
 * @sideeffects
 * - Calls encounter_setup() which modifies:
 *   - global.ENEMY_INFO["__ENEMY__"]["ENEMIES"] array
 *   - global.enc_slot array
 * 
 * 
 */
function encounter_battlegroup_get(_group_id) {
    /// @arg group_id - String value - determines which battlegroup to fetch
    
    // Switch statement maps battlegroup IDs to enemy configurations
    switch (_group_id) {
        case "test":
            // Test configuration: Toaddit (left), empty (center), Whimsun (right)
            encounter_setup("TOADDIT", noone, "WHIMSUN");
            break;
            
        case "toaddit_s":
            // Single Toaddit in center position
            encounter_setup(noone, "TOADDIT", noone);
            break;
            
        case "toadsun":
            // Toaddit (left), empty (center), Whimsun (right)
            // Same as "test" but semantically named for this specific pair
            encounter_setup("TOADDIT", noone, "WHIMSUN");
            break;
            
        case "whimsun_s":
            // Single Whimsun in center position
            encounter_setup(noone, "WHIMSUN", noone);
            break;
            
        case "loox_s":
            // Single Loox in center position
            encounter_setup(noone, "LOOX", noone);
            break;
            
        case "geno":
            // Single Geno in center position (likely a boss or special enemy)
            encounter_setup(noone, "GENO", noone);
            break;
            
        // No default case - unknown battlegroup IDs are silently ignored
        // Consider adding: default: show_debug_message("Unknown battlegroup: " + _group_id);
    }
    
    // Note: After this function, encounter_create() should be automatically called by obj_battle_handler to instantiate enemies
}