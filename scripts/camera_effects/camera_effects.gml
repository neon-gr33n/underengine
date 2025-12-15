/**
 * Sets up a screen shake effect for a camera object.
 * 
 * @example
 * // Basic screen shake with 10-frame duration, magnitude 5, and 0.9 decay
 * camera_screenshake(10, 5, 0.9);
 * 
 * @example
 * // Screen shake on a specific camera with different parameters
 * camera_screenshake(15, 8, 0.8, obj_other_camera);
 * 
 * @function camera_screenshake
 * @description Initiates screen shake effect when global.shake_screen is true.
 * @param {number} duration - Duration of the shake in frames.
 * @param {number} magnitude - Intensity of the shake (in pixels).
 * @param {number} decay - Rate at which the shake diminishes over time (0-1).
 * @param {Object} [cam_obj=obj_master_camera] - Camera object to apply shake to.
 */
function camera_screenshake(_time,_magnitude,_decay,cam_obj=obj_master_camera)
{
	if global.shake_screen {
		cam_obj.shake = true;
		cam_obj.shake_time = _time;
		cam_obj.shake_magnitude = _magnitude;
		cam_obj.shake_decay = _decay;
	}
}