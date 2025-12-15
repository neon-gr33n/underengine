/**
 * Adjusts an enemy's horizontal position on the battle screen, with optional smooth transitions.
 * Centers or repositions enemies during battle sequences with configurable animation options.
 * 
 * @function encounter_adjust_pos
 * @description Repositions an enemy horizontally on the battle screen. Provides two modes:
 *              immediate positioning or smooth tween-based transitions. Primarily used for
 *              centering enemies for special attacks, focus animations, or battle formations.
 * 
 * @param {instance} target - The enemy instance to reposition. Should be a valid instance ID.
 * @param {number} x - The target x-coordinate to move the enemy to (in room coordinates).
 * @param {boolean} [lerpSmooth=false] - Whether to use smooth tween animation.
 *                                       Defaults to false (immediate positioning).
 * @param {number} [duration=0] - Duration of the smooth transition in frames or seconds.
 *                                Only used when lerpSmooth is true.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Immediately center an enemy at position 320
 * encounter_adjust_pos(enemy_instance, 320);
 * 
 * @example
 * // Smoothly move enemy to position 400 over 1 second (60 frames)
 * encounter_adjust_pos(enemy_instance, 400, true, 60);
 * 
 * @example
 * // Center the currently targeted enemy for a special attack
 * var center_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
 * encounter_adjust_pos(global.current_target, center_x, true, 30);
 * 
 * @throws {Error} May fail silently if target is invalid or not an instance.
 * 
 * @note The Y-coordinate is intentionally not adjustable - enemies maintain consistent height.
 * @note Uses drawXPos custom variable for position tracking (not the actual x coordinate).
 * @note Smooth mode requires TweenFire function/tweening system to be available.
 * @note The tween uses EaseLinear interpolation for consistent speed.
 * 
 * @see TweenFire - Tweening function used for smooth transitions
 * @see global.current_target - Common target for battle actions
 * @see drawXPos - Custom variable used to track enemy position
 * 
 * @sideeffects
 * - Modifies target.drawXPos directly (immediate mode)
 * - Creates a tween on target.x (smooth mode)
 * - May affect battle animations and sequencing
 * 
 * @global
 * @requires TweenFire function for smooth transitions
 * 
 * @todo Consider adding Y-axis adjustment for special battle scenarios
 * @todo Consider adding callback parameter for post-animation actions
 */
function encounter_adjust_pos() {
    /// @desc Centers the enemy on the screen (optional lerpSmooth argument for smooth centering transition)
    /// @arg target
    /// @arg x
    /// @arg lerpSmooth* 
    /// @arg duration*
    
    // (we're omitting Y because that should almost ALWAYS remain consistent)
    // (Provided an optional "duration" argument for lerping in the event that 
    // we wish to have an enemy take longer to center)
    
    // Extract arguments (using legacy argument array for compatibility)
    var target = argument0;    // Enemy instance to reposition
    var xPos = argument1;      // Target x-coordinate
    var lerpSmooth = argument2; // Smooth animation flag
    var duration = argument3;   // Animation duration (frames/seconds)
    
    // Check if smooth transition is requested
    if (!lerpSmooth) {
        // Immediate positioning - set drawXPos directly
        with (target) {
            drawXPos = xPos; // Center the object on the battle screen
        }
    } else if (lerpSmooth) {
        // Smooth tween animation - use tweening system
        with (target) {
            /**
             * @description Creates a linear tween to animate the enemy's x-position.
             * @param {instance} target - Instance to tween
             * @param {function} EaseLinear - Linear easing function
             * @param {number} 0 - Start delay (none)
             * @param {number} 0 - Unused parameter (likely for y-position)
             * @param {number} 0 - Unused parameter
             * @param {number} duration - Tween duration
             * @param {string} "x" - Property to animate
             * @param {number} x - Current x position (start value)
             * @param {number} xPos - Target x position (end value)
             */
            TweenFire(target, EaseLinear, 0, 0, 0, duration, "x", x, xPos);
        }
    }
    
    // Note: The actual battle system should update visual position based on drawXPos
    // This might happen in the enemy's draw event or a controller object
}