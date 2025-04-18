/// @func timer_set_autodestroy
/// @desc {void} Sets whether the timer will be destroyed when the timer is finished and been checked at least once.
/// @arg {map} timer
/// @arg {bool} autoDestroy
function timer_set_autodestroy() {

	var _timer = argument[0];
	var _autoDestroy = argument[1];

	_timer[? "AUTODESTROY"] = _FUWA_OPTIONS_DISABLE_AUTODESTROY ? false : _autoDestroy;


}
