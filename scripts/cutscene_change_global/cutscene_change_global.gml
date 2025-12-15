/**
 * Sets or changes a global variable during a cutscene.
 * 
 * @param {string} var_name_as_string - Name of global variable as string
 * @param {any} value - Value to assign to the global variable
 */
function cutscene_change_global(){
///@description cutscene_change_variable
///@arg var_name_as_string
///@arg value

if(!variable_global_exists(argument0)){
	variable_global_set(argument0,argument1)
}

cutscene_end_action();
}