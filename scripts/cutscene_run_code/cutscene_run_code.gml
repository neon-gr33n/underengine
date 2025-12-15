/**
 * Executes arbitrary code during a cutscene.
 * 
 * @param {function} func - Function to execute
 * @param {...any} args - Arguments to pass to the function
 */
function cutscene_run_code() {
	////@desc cutscene_run_code
	///@arg func()
	var func = argument[0];
	var args = [];
	for (var i = 1; i < argument_count; i++)
		args[i-1] = argument[i];
	
	if array_length(args) > 0
		script_execute_ext(func, args);
	else
		func();
	cutscene_end_action();
}