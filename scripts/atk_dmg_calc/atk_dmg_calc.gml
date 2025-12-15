/**
 * Calculates damage for a player attack against an enemy.
 * Handles complex damage calculation including player stats, enemy defense,
 * weapon properties, timing-based mechanics, and status effects.
 * 
 * @function atk_dmg_calc
 * @description Performs comprehensive damage calculation for player attacks.
 *              Incorporates player statistics, weapon attributes, enemy defense,
 *              timing-based hit quality, critical hits, and status effect modifiers.
 *              Supports both simple (single-bar) and complex (multi-bar) weapon systems.
 * 
 * @returns {number} Calculated damage amount, rounded to nearest integer.
 *                   Returns 0 if attack misses in single-bar mode.
 * 
 * @throws {Error} May fail if required global variables (p_index, enemyChoice, etc.)
 *                 are not properly initialized.
 * 
 * @note Assumes global variables: p_index, enemyChoice, rec_x, rec_speed, missed
 * @note Damage calculation varies based on weapon type (single-bar vs multi-bar)
 * @note Incorporates status effects: freeze (2x damage), burn (added damage)
 * @note Single-bar weapons use timing-based critical hit system
 * @note Multi-bar weapons use weighted hit scoring system
 * @note Includes random variation of ±0-1 damage
 * 
 * @see member_get_stat - Function to retrieve party member statistics
 * @see party_get_member - Function to get party member data
 * @see item_get_attribute - Function to retrieve weapon properties
 * @see global.ENEMY_INFO - Global enemy configuration data
 * @see global.enc_slot - Array of enemy instances in battle
 * 
 * @sideeffects
 * - Reads multiple global variables and data structures
 * - Accesses party member and enemy statistics
 * - Performs random number generation
 * - No persistent state modifications
 * 
 * @global
 * @reads p_index, enemyChoice, rec_x, rec_speed, missed
 * @reads global.ENEMY_INFO, global.enc_slot
 */
function atk_dmg_calc() {
    // Calculate base attack minus enemy defense
    var atk_def = member_get_stat(party_get_member(p_index), "ATK") // Player's ATK
        + member_get_stat(party_get_member(p_index), "TEMP_ATK") // Any temporary ATK buffs
        + (8 + 2 * member_get_stat(party_get_member(p_index), "LV")) // LV attack buffs
        + item_get_attribute(member_get_stat(party_get_member(p_index), "WEAPON"), "ATK") // Weapon's ATK
        - global.ENEMY_INFO[$ global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice]][$ "STATS"][$ "DEF"]; // Enemy's DEF
    
    // Double damage if enemy is frozen
    atk_def *= (global.enc_slot[enemyChoice]._freeze == -1 ? 2 : 1);
    
    // Get weapon bar information for timing-based mechanics
    var bar_info = item_get_attribute(member_get_stat(party_get_member(p_index), "WEAPON"), "BARS")[$ "INFO"];
    
    // Single-bar weapon damage calculation
    if (array_length(bar_info) == 1) {
        if (missed[0]) {
            return 0; // Attack missed
        } else {
            // Calculate damage with timing-based critical hit system
            return round(
                (atk_def + random(2)) // Base damage with small random variation
                * (
                    (abs(320 - rec_x[0]) <= 12 // Check if timing was perfect (criteria for critical hit)
                        ? item_get_attribute(member_get_stat(party_get_member(p_index), "WEAPON"), "CRIT_MULT") // Critical hit multiplier
                        : (1 - abs(320 - rec_x[0]) / 550) * 2 // Normal hit scaling based on timing accuracy
                    )
                )
            );
        }
    } 
    // Multi-bar weapon damage calculation
    else {
        // Calculate hit score based on timing accuracy across multiple bars
        var hit_score = 0;
        for (var i = 0; i < array_length(bar_info); ++i) {
            // Calculate timing distance from perfect hit position
            var distance = abs(floor(rec_x[i] / rec_speed[i]) - floor(320 / rec_speed[i]));
            
            // Assign score based on timing accuracy (closer to perfect = higher score)
            var sub_hit_score = 0;
            if (28 <= distance) sub_hit_score += 0;
            if (22 <= distance && distance < 28) sub_hit_score += 10;
            if (16 <= distance && distance < 22) sub_hit_score += 15;
            if (10 <= distance && distance < 16) sub_hit_score += 20;
            if (5 <= distance && distance < 10) sub_hit_score += 40;
            if (4 <= distance && distance < 5) sub_hit_score += 50;
            if (3 <= distance && distance < 4) sub_hit_score += 70;
            if (2 <= distance && distance < 3) sub_hit_score += 80;
            if (1 <= distance && distance < 2) sub_hit_score += 90;
            if (distance < 1) sub_hit_score += 110;
            
            // Add weighted score for this bar
            hit_score += sub_hit_score / array_length(bar_info) / bar_info[i][$ "WEIGHT"];
        }
        
        // Apply critical hit bonuses for exceptional timing
        if (hit_score > 400) hit_score *= item_get_attribute(member_get_stat(party_get_member(p_index), "WEAPON"), "CRIT_MULT") / 1.8;
        if (hit_score > 430) hit_score *= 1.8;
        
        // Calculate final damage with hit score scaling
        return round((atk_def) * (hit_score / 160) * (4 / array_length(bar_info))) 
            + round(random(2)) // Small random variation
            + global.enc_slot[enemyChoice]._burn; // Add burn damage if enemy is burning
    }
}