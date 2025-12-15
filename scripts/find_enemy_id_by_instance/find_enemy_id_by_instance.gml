/**
 * Finds the enemy ID corresponding to a specific instance in battle.
 * Maps battle instance IDs back to their enemy configuration identifiers.
 * 
 * @function find_enemy_id_by_instance
 * @description Searches through enemy configurations to identify which enemy type
 *              a given instance represents. Used to translate between battle instances
 *              and enemy data configurations during combat.
 * 
 * @param {instance} instance_id - The instance ID of an enemy in battle.
 *                                 Should be a valid enemy instance from global.enc_slot.
 * 
 * @returns {string|noone} Enemy ID string if found, noone if instance not found or invalid.
 *
 * @example
 * // Use enemy ID to get configuration data during battle
 * var current_enemy_id = find_enemy_id_by_instance(global.current_target);
 * if (current_enemy_id != noone) {
 *     var enemy_stats = global.ENEMY_INFO[$ current_enemy_id][$ "STATS"];
 *     // Use stats for damage calculation
 * }
 * 
 * @throws {Error} Returns noone if instance not found in battle slots.
 * @throws {Error} Returns noone if enemy configuration data is malformed.
 * 
 * @note Searches through all enemy configurations in global.ENEMY_INFO.
 * @note Skips the "__ENEMY__" metadata structure.
 * @note Compares against current battle setup in global.enc_slot.
 * @note Validates that the instance matches the enemy type in the battle lineup.
 * 
 * @see global.ENEMY_INFO - Global data structure containing enemy configurations
 * @see global.enc_slot - Array containing active enemy instances in battle
 * @see global.ENEMY_INFO["__ENEMY__"]["ENEMIES"] - Array of enemy IDs in current battle
 * 
 * @sideeffects
 * - Iterates through all enemy configurations (performance consideration for many enemies)
 * - Accesses multiple global data structures
 * - No modifications to game state
 * 
 * @global
 * @readonly Does not modify any game state
 */
function find_enemy_id_by_instance(instance_id) {
    // Loop through all enemy IDs to find which one this instance represents
    var enemy_structs = variable_struct_get_names(global.ENEMY_INFO);
    
    for (var i = 0; i < array_length(enemy_structs); i++) {
        var enemy_id = enemy_structs[i];
        // Skip the "__ENEMY__" metadata struct
        if (enemy_id == "__ENEMY__") continue;
        
        var enemy_info = global.ENEMY_INFO[$ enemy_id];
        
        // Check if this enemy has a matching instance
        for (var j = 0; j < 3; j++) {
            var slot_enemy = global.enc_slot[j];
            if (slot_enemy == instance_id) {
                // This instance exists in the battle slots
                // Now check if this is the right enemy type by comparing with the battle's enemy list
                if (variable_struct_exists(global.ENEMY_INFO[$ "__ENEMY__"], "ENEMIES")) {
                    var battle_enemies = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"];
                    var battle_enemy_id = battle_enemies[j]; // Get the enemy ID at this position
                    
                    if (battle_enemy_id == enemy_id) {
                        return enemy_id;
                    }
                }
            }
        }
    }
    
    return noone;
}