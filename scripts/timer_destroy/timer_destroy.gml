/// @func timer_destroy
/// @desc {void} Destroys a timer.
/// @arg {map} timer
function timer_destroy() {

	var _timer = argument[0];

	if (is_undefined(_timer)){
		return;
	}

	var _owner = _timer[? "OWNER"];
	var _ownerNode = global._fuwa_instanceMap[? _owner];
	var _ownerTimerList = _ownerNode[? "TIMER_LIST"];

	// Remove reference to timer
	var _timerPos = ds_list_find_index(_ownerTimerList,_timer);
	//fuwa_assert(_timerPos != -1, "Timer not found in instance node's timer list");
	ds_list_delete(_ownerTimerList,_timerPos);

	// Destroy the entire node if 0 timers left over (including this timer), and shortcut in map
	if (ds_list_empty(_ownerTimerList)){
		var _nodePos = ds_list_find_index(global._fuwa_instanceList,_ownerNode);
		//fuwa_assert(_nodePos != -1, "Instance node not found in instance list");
		ds_list_delete(global._fuwa_instanceList,_nodePos);
		ds_map_destroy(_ownerNode);
		ds_map_delete(global._fuwa_instanceMap,_owner);
	}

	// Destroying a non-autodestroy timer might affect the node's autodestroy status
	// But rescanning would negate the performance difference anyway (since worst-case is looping through)
	// And it's likely to be taken care of on the next fuwa_run step

	// Destroy timer, as it was dereferenced earlier
	ds_map_destroy(_timer);


}
