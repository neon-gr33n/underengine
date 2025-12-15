/**
 * Initializes an encounter by setting up enemy slots for battle.
 * Clears all existing enemy slots and populates them with specified enemies.
 * 
 * @function encounter_setup
 * @description Sets up an encounter by populating enemy slots with specified enemies.
 *              First clears all existing enemy slots, then sets up new enemies based on provided arguments.
 *              Each argument represents an enemy ID that should be loaded into the corresponding slot.
 * 
 * @param {string|noone} [enemy0] - Enemy ID for slot 0 (left position). Use noone or undefined for empty slot.
 * @param {string|noone} [enemy1] - Enemy ID for slot 1 (center position). Use noone or undefined for empty slot.
 * @param {string|noone} [enemy2] - Enemy ID for slot 2 (right position). Use noone or undefined for empty slot.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Setup a battle with Froggit in slot 0, Whimsun in slot 1, and leave slot 2 empty
 * encounter_setup("FROGGIT", "WHIMSUN", noone);
 * 
 * @example
 * // Setup a battle with only one enemy in the center slot
 * encounter_setup(noone, "FROGGIT", noone);
 * 
 * @throws {Error} Will not throw errors but will skip invalid enemy IDs gracefully.
 * 
 * @note The function expects enemy IDs that exist in global.ENEMY_INFO.
 *       If an enemy ID doesn't exist, that slot will remain empty (noone).
 * 
 * @see global.ENEMY_INFO - Global data structure containing enemy information
 * @see global.enc_slot - Array containing the actual enemy objects for battle
 * 
 * @sideeffects
 * - Modifies global.ENEMY_INFO["__ENEMY__"]["ENEMIES"] array
 * - Modifies global.enc_slot array
 * - Clears all existing enemy slots before populating new ones
 */
function encounter_setup() {
    /// @desc used to initialize an encounter, or setup a random encounter battlegroup
    /// @arg enemy0
    /// @arg enemy1
    /// @arg enemy2
    
    // First, clear all slots
    for (var i = 0; i < 3; i++) {
        global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] = noone;
        global.enc_slot[i] = noone;
    }
    
    // Now set up the new encounter
    for (var i = 0; i < 3; i++) {
        // Check if argument exists and is not undefined
        if (is_undefined(argument[i]) || argument[i] == noone) {
            continue; // Skip this iteration - slot remains noone
        }
        
        var enemy_object = global.ENEMY_INFO[$ argument[i]][$ "OBJECT"];
        if (enemy_object != noone) {
            global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] = argument[i];
            global.enc_slot[i] = enemy_object;
        }
    }
}