/// @category Battle
/// @title Battlegroup Fetching

/// @function encounter_battlegroup_get(_group_id)
/// @description Fetches a predefined enemy battlegroup configuration 
/// @desc NOTE: encounter_create will automatically be called by obj_battle_handler, do not call it manually
/// @param {string} _group_id Identifier for the battlegroup to fetch
function encounter_battlegroup_get(_group_id) {
    /// @arg group_id - String value - determines which battlegroup to fetch
    
    // Switch statement maps battlegroup IDs to enemy configurations
    switch (_group_id) {
        case "test":
            // Test configuration: Example / Test (Center)
            encounter_setup(noone, "TEST", noone);
            break;
        case "geno":
            // Single Geno in center position (likely a boss or special enemy)
            encounter_setup(noone, "GENO", noone);
            break;
    }
}