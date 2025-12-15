/**
 * Creates enemy instances for the current encounter setup.
 * Instantiates enemies in their battle positions based on the encounter setup.
 * 
 * @function encounter_create
 * @description Creates enemy instances for battle by instantiating the objects stored in global.enc_slot.
 *              Each enemy is positioned in a predefined slot on the battlefield and initialized with
 *              their health stats from the enemy configuration data.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // First setup the encounter, then create the instances
 * encounter_setup("FROGGIT", "WHIMSUN", noone);
 * encounter_create();
 * // Creates froggit at left position, whimsun at center position
 * 
 * @throws {Error} May fail silently if enemy data structures are malformed.
 * 
 * @note This function should be called after encounter_setup().
 * @note Enemy positions are fixed: slot 0 at x=96, slot 1 at x=320, slot 2 at x=544, all at y=224.
 * @note Enemies are created at depth -100 to control rendering order.
 * @note Enemies are scaled 2x (image_xscale and image_yscale = 2).
 * 
 * @see encounter_setup - Function to prepare enemies before creation
 * @see global.enc_slot - Array containing enemy objects to instantiate
 * @see global.ENEMY_INFO - Global data structure containing enemy configuration
 * 
 * @sideeffects
 * - Creates new instances in the room (instance_create_depth)
 * - Modifies global.enc_slot array (replaces object IDs with instance IDs)
 * - Each enemy instance receives custom variables:
 *   - drawXPos: Original creation x position
 *   - drawYPos: Original creation y position
 *   - _hp: Current health from enemy stats
 *   - _hp_max: Maximum health from enemy stats
 * 
 * @global
 * @modifies global.enc_slot
 * @uses instance_create_depth
 */
function encounter_create() {
    // Iterate through all 3 possible enemy slots
    for (i = 0; i < 3; i++) {
        // Check if this slot has an enemy assigned
        if (global.enc_slot[i] != noone) {
            /**
             * Create enemy instance with the following properties:
             * - Position: Calculated based on slot index (96 + i * 224, 224)
             * - Depth: -100 (rendering order)
             * - Object: The enemy object from global.enc_slot[i]
             * - Custom variables: Position tracking and health stats
             * 
             * @type {instance}
             * @property {number} drawXPos - Stores the creation x position
             * @property {number} drawYPos - Stores the creation y position
             * @property {number} image_xscale - Horizontal scale (2 = double size)
             * @property {number} image_yscale - Vertical scale (2 = double size)
             * @property {number} _hp - Current hit points from enemy stats
             * @property {number} _hp_max - Maximum hit points from enemy stats
             */
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