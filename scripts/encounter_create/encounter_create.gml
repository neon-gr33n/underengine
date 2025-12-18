/// @category Battle
/// @title Encounter Creation

/// @function encounter_create()
/// @description Creates enemy instances for the current encounter setup
function encounter_create() {
    // Iterate through all 3 possible enemy slots
    for (i = 0; i < 3; i++) {
        // Check if this slot has an enemy assigned
        if (global.enc_slot[i] != noone) {
            global.enc_slot[i] = instance_create_depth(
                96 + i * 224, // x position: 96, 320, or 544
                224,          // y position: fixed at 224
                -100,         // depth: -100 for rendering order
                global.enc_slot[i], // enemy object to instantiate
                {
                    drawXPos: x, // Store creation x position
                    drawYPos: y, // Store creation y position
                    image_xscale: 2, // Scale enemy 2x horizontally
                    image_yscale: 2, // Scale enemy 2x vertically
                    _hp: global.ENEMY_INFO[$ global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i]][$ "STATS"][$ "HP"],
                    _hp_max: global.ENEMY_INFO[$ global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i]][$ "STATS"][$ "MAX_HP"],
                }
            );
        }
    }
}