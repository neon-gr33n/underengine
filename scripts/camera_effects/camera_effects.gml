/// @category Camera
/// @title Camera Effects

/// @function camera_screenshake(_time, _magnitude, _decay, [cam_obj])
/// @description Sets up a screen shake effect for a camera object.
/// @param {number} _time Duration of the shake in frames
/// @param {number} _magnitude Intensity of the shake in pixels
/// @param {number} _decay Rate at which shake diminishes (0-1)
/// @param {Object} [cam_obj=obj_master_camera] Camera object to apply shake to
function camera_screenshake(_time,_magnitude,_decay,cam_obj=obj_master_camera)
{
	if global.shake_screen {
		cam_obj.shake = true;
		cam_obj.shake_time = _time;
		cam_obj.shake_magnitude = _magnitude;
		cam_obj.shake_decay = _decay;
	}
}