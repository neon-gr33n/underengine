/// @func timer_stop
/// @desc {void} Stop a timer.
/// @desc		 Stopped timers have their progress reset and will not update their progress, but can be accessed normally.
/// @arg {map} timer
function timer_stop() {

	var _timer = argument[0];

	timer_restart(_timer);
	timer_pause(_timer);


}
