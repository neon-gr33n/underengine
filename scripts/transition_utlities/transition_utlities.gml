/**
 * Creates a basic fade transition between two alpha values.
 * @example
 * // Fade to black over 1 second
 * fade_basic(0, 1, 1);
 * 
 * @example
 * // Fade from black with callback
 * fade_basic(1, 0, 2, 0, c_black, function() { 
 *     show_message("Fade complete!"); 
 * });
 * 
 * @param {number} start - Initial alpha value (0-1)
 * @param {number} target - Target alpha value (0-1)
 * @param {number} duration - Transition duration in seconds
 * @param {number} delaySeconds - Delay before starting transition in seconds
 * @param {color} colour - Color of the fade overlay
 * @param {function} onFinish - Function to call when transition completes
 * @returns {boolean} Always returns true
 */
function fade_basic(start,target,duration,delaySeconds = 0,colour = c_black,onFinish = function(){}) {
	obj_fade_transition.color = colour
	//execute_tween(obj_fade_transition,"alpha",target,"linear",duration,false,delaySeconds)
	TweenFire(obj_fade_transition,EaseLinear,0,0,delaySeconds,duration,"alpha",start,target-start)
	if (TweenJustFinished()){
		onFinish();
	}
	
	return true;

}

/**
 * Creates a "cutout" transition using a sprite shape (like Mario & Luigi games).
 * @example
 * // Circle cutout transition
 * fade_shape(spr_circle_cutout);
 * 
 * @example
 * // Star-shaped fade out over 60 frames
 * fade_shape(spr_star_shape, 60, 1);
 * 
 * @param {sprite} cutout_sprite - Sprite to use as cutout shape (must have centered origin)
 * @param {number} duration - Transition duration in frames (default 30)
 * @param {number} fade_type - 0 = fade in, 1 = fade out (default 0)
 */
function fade_shape(cutout_sprite,_duration=30,fade_type=0){
	instance_create_depth(0,0,-99999,obj_shape_transition, 
	{
		clipSpr : cutout_sprite,
		fadeamt : _duration,
		fadetype : fade_type
	})
}