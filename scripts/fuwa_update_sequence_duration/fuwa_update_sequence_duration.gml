/// @func fuwa_update_sequence_duration
/// @arg  {map} timer
function fuwa_update_sequence_duration() {

	var _timer = argument[0];

	var _sequence = _timer[? "SEQUENCE"];
	var _curNode = timer_get_sequence_curpos(_timer);

	_sequence[@ _curNode, fuwasequence.duration] = (_timer[? "TIME_END"] - _timer[? "TIME_START"]); // internal units 


}
