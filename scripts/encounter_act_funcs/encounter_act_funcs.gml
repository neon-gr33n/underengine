/**
 * Modifies an enemy's ACT by adding, removing, or replacing an ACT.
 * 
 * @param {string} enemy_id - The ID of the enemy to modify
 * @param {string} act_name - The name of the ACT to modify
 * @param {struct} act_data - The new ACT data (use {} to remove the ACT)
 * @param {boolean} is_replace - If true, replaces existing ACT; if false, adds/removes
 * @return {boolean} - Returns true if successful, false if enemy doesn't exist
 */
function modify_enemy_act(enemy_id, act_name, act_data, is_replace = true) {
    // Check if enemy exists
    if (!variable_struct_exists(global.ENEMY_INFO, enemy_id)) {
        show_debug_message("Error: Enemy with ID '" + enemy_id + "' not found in global.ENEMY_INFO");
        return false;
    }
    
    var enemy_info = global.ENEMY_INFO[$ enemy_id];
    
    // Ensure enemy has ACTS struct
    if (!variable_struct_exists(enemy_info, "ACTS")) {
        if (is_empty(act_data)) {
            // No ACTS to remove from, return success
            return true;
        }
        enemy_info[$ "ACTS"] = {};
    }
    
    var enemy_acts = enemy_info[$ "ACTS"];
    
    if (is_empty(act_data)) {
        // Remove the ACT if it exists
        if (variable_struct_exists(enemy_acts, act_name)) {
            variable_struct_remove(enemy_acts, act_name);
            show_debug_message("Removed ACT '" + act_name + "' from enemy '" + enemy_id + "'");
            return true;
        } else {
            show_debug_message("Warning: ACT '" + act_name + "' not found in enemy '" + enemy_id + "'");
            return false;
        }
    } else {
        // Add or replace the ACT
        // Validate act_data structure
        if (!variable_struct_exists(act_data, "responses") || 
            !variable_struct_exists(act_data, "mercy_effect") || 
            !variable_struct_exists(act_data, "repeatable")) {
            show_debug_message("Error: act_data must contain 'responses', 'mercy_effect', and 'repeatable' fields");
            return false;
        }
        
        if (is_replace || !variable_struct_exists(enemy_acts, act_name)) {
            // Replace or add the ACT
            enemy_acts[$ act_name] = act_data;
            show_debug_message((is_replace ? "Replaced" : "Added") + " ACT '" + act_name + "' for enemy '" + enemy_id + "'");
            return true;
        } else {
            show_debug_message("Warning: ACT '" + act_name + "' already exists for enemy '" + enemy_id + "'. Use is_replace = true to replace.");
            return false;
        }
    }
}

/**
 * Helper function to check if a struct is empty
 * 
 * @param {struct} s - The struct to check
 * @return {boolean} - Returns true if struct is empty or undefined
 */
function is_empty(s) {
    return is_undefined(s) || (is_struct(s) && variable_struct_get_names(s) == 0);
}

/**
 * Creates a new ACT data structure
 * 
 * @param {array} responses - Array of response strings
 * @param {number} mercy_effect - Mercy points gained from completing the ACT
 * @param {boolean} repeatable - Whether the ACT can be repeated
 * @return {struct} - Returns a properly formatted ACT struct
 */
function create_act_data(responses, mercy_effect, repeatable) {
    return {
        responses: responses,
        mercy_effect: mercy_effect,
        repeatable: repeatable
    };
}

/**
 * Removes an ACT from an enemy
 * 
 * @param {string} enemy_id - The ID of the enemy
 * @param {string} act_name - The name of the ACT to remove
 * @return {boolean} - Returns true if successful
 */
function remove_enemy_act(enemy_id, act_name) {
    return modify_enemy_act(enemy_id, act_name, {});
}

/**
 * Adds a new ACT to an enemy (fails if ACT already exists)
 * 
 * @param {string} enemy_id - The ID of the enemy
 * @param {string} act_name - The name of the ACT to add
 * @param {struct} act_data - The ACT data structure
 * @return {boolean} - Returns true if successful
 */
function add_enemy_act(enemy_id, act_name, act_data) {
    return modify_enemy_act(enemy_id, act_name, act_data, false);
}

/**
 * Replaces an existing ACT in an enemy
 * 
 * @param {string} enemy_id - The ID of the enemy
 * @param {string} act_name - The name of the ACT to replace
 * @param {struct} act_data - The new ACT data structure
 * @return {boolean} - Returns true if successful
 */
function replace_enemy_act(enemy_id, act_name, act_data) {
    return modify_enemy_act(enemy_id, act_name, act_data, true);
}