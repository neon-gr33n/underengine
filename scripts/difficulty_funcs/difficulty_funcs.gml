/**
 * Initializes the global difficulty settings data structure.
 * @example
 * // Call once at game start
 * difficulty_data_init();
 */
function difficulty_data_init(){
	global.GAME_DIFFICULTY = {
		__DIFFICULTY__: {
			EASY: {
				// Double base ATK and Defense, reduce damage by 1.5x
				DEF_MULTIPLER: 2,
				ATK_MULTIPLIER: 2,
				DMG_REDUCTION_MULTIPLIER: 1.5,
				LABEL: "Easy"
			},
			NORMAL: {
				// No ATK or Defense boost, damage reduction is significantly lessened
				DMG_REDUCTION_MULTIPLIER: 0.5,
				LABEL: "Normal"
			},
			HARD: {
				// Increase damage taken by 0.5x
				DMG_MULTIPLIER: 0.5,
				LABEL: "Hard"
			},
			LUNATIC: {
				// Increase damage taken by 2x, you must be out of your damn mind
				DMG_MULTIPLIER: 2,
				LABEL: "Lunatic"
			}
		}
	}
}

/**
 * Sets the game difficulty and applies appropriate stat multipliers.
 * @example
 * // Set to Easy difficulty
 * game_set_difficulty("EASY");
 * 
 * @example
 * // Set to Hard difficulty
 * game_set_difficulty("HARD");
 * 
 * @param {string} difficulty_name - Name of difficulty (EASY, NORMAL, HARD, LUNATIC)
 * @returns {boolean} Success or failure of setting difficulty
 */
function game_set_difficulty(difficulty_name) {
    // Validate difficulty exists
    if (variable_struct_exists(global.GAME_DIFFICULTY.__DIFFICULTY__, difficulty_name)) {
        
        // Store previous difficulty
        var previous_difficulty = global.__difficulty_id;
        
        // Set new difficulty
        global.__difficulty_id = difficulty_name;
        
        // Get difficulty data
        var old_difficulty_data = global.GAME_DIFFICULTY.__DIFFICULTY__[$ previous_difficulty];
        var new_difficulty_data = global.GAME_DIFFICULTY.__DIFFICULTY__[$ difficulty_name];
        
        // Apply difficulty effects to party members
        var party_members = party_get_attribute("MEMBERS");
        
        for (var i = 0; i < array_length(party_members); i++) {
            var member = party_members[i];
            var stats = member_get_attribute(member, "STATS");
            
            // Ensure BASE_STATS exists for restoring original values
            var base_stats = member_get_attribute(member, "STATS");
            if (!variable_struct_exists(base_stats, "ATK")) {
                // Initialize BASE_STATS with current values
                base_stats.ATK = stats.ATK;
                base_stats.DEF = stats.DEF;
                member_set_attribute(member, "STATS", base_stats);
            }
            
            // Restore to base stats first (remove old multipliers)
            if (variable_struct_exists(old_difficulty_data, "ATK_MULTIPLIER") || 
                variable_struct_exists(old_difficulty_data, "DEF_MULTIPLER")) {
                
                // Only restore if we were on Easy before
                if (previous_difficulty == "EASY") {
                    stats.ATK = base_stats.ATK;
                    stats.DEF = base_stats.DEF;
                }
            }
            
            // Apply new multipliers (only for Easy mode)
            if (difficulty_name == "EASY") {
                if (variable_struct_exists(new_difficulty_data, "ATK_MULTIPLIER")) {
                    if (base_stats.ATK == 0) {
                        // If base ATK is 0, add the multiplier value directly
                        stats.ATK = new_difficulty_data.ATK_MULTIPLIER;
                    } else {
                        // Otherwise multiply normally
                        stats.ATK = round(base_stats.ATK * new_difficulty_data.ATK_MULTIPLIER);
                    }
                }
                if (variable_struct_exists(new_difficulty_data, "DEF_MULTIPLER")) {
                    if (base_stats.DEF == 0) {
                        // If base DEF is 0, add the multiplier value directly
                        stats.DEF = new_difficulty_data.DEF_MULTIPLER;
                    } else {
                        // Otherwise multiply normally
                        stats.DEF = round(base_stats.DEF * new_difficulty_data.DEF_MULTIPLER);
                    }
                }
                
                show_debug_message("Applied Easy mode multipliers: ATK=" + 
                                  string(stats.ATK) + ", DEF=" + string(stats.DEF) +
                                  " (base ATK=" + string(base_stats.ATK) + ", base DEF=" + string(base_stats.DEF) + ")");
            }
        }
        
        show_debug_message("Difficulty changed from " + previous_difficulty + " to " + difficulty_name);
        return true;
    } else {
        show_debug_message("Invalid difficulty: " + difficulty_name);
        return false;
    }
}

/**
 * Applies difficulty modifiers to damage values.
 * @example
 * // Calculate damage after difficulty adjustments
 * var damage = game_get_difficulty_damage(100);
 * 
 * @example
 * // Use with attack calculations
 * var finalDamage = game_get_difficulty_damage(baseDamage + strength * 2);
 * 
 * @param {number} base_damage - The base damage value before difficulty adjustments
 * @returns {number} Modified damage based on current difficulty settings
 */
function game_get_difficulty_damage(base_damage) {
    var _diff = global.GAME_DIFFICULTY.__DIFFICULTY__;
    var _current_diff = "NORMAL"; // Default, you'll need to track current difficulty
    
    // If you have a way to track current difficulty, use it
    if (variable_struct_exists(global, "__difficulty_id")) {
        _current_diff = global.__difficulty_id;
    }
    
    var _difficulty_data = _diff[$ _current_diff];
    var _final_damage = base_damage;
    
    // Apply damage reduction (if exists)
    if (variable_struct_exists(_difficulty_data, "DMG_REDUCTION_MULTIPLIER")) {
        _final_damage = max(1, _final_damage - (_final_damage * _difficulty_data.DMG_REDUCTION_MULTIPLIER));
    }
    
    // Apply damage multiplier (if exists) - this increases damage
    if (variable_struct_exists(_difficulty_data, "DMG_MULTIPLIER")) {
        _final_damage = _final_damage * (1 + _difficulty_data.DMG_MULTIPLIER);
    }
    
    return round(_final_damage);
}
	
/**
 * Gets the current difficulty settings.
 * @example
 * var diffInfo = game_get_difficulty_info();
 * var damageMultiplier = diffInfo.DMG_MULTIPLIER;
 * 
 * @returns {object} Current difficulty settings object
 */
function game_get_difficulty_info() {
    var _current = global.__difficulty_id;
    return global.GAME_DIFFICULTY.__DIFFICULTY__[$ _current];
}

/**
 * Gets the display label for the current difficulty.
 * @example
 * show_message("Current difficulty: " + game_get_difficulty_label());
 * 
 * @returns {string} Current difficulty label
 */
function game_get_difficulty_label() {
    var _info = game_get_difficulty_info();
    return _info.LABEL;
}