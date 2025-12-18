/// @category Battle
/// @title Encounter Initialization

/// @function encounter_setup([enemy0], [enemy1], [enemy2])
/// @description Sets up an encounter by populating enemy slots with specified enemies
/// @param {string|noone} [enemy0] Enemy ID for slot 0 (left position)
/// @param {string|noone} [enemy1] Enemy ID for slot 1 (center position) 
/// @param {string|noone} [enemy2] Enemy ID for slot 2 (right position)
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