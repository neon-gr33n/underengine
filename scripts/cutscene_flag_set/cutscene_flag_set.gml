/**
 * Sets a flag during a cutscene and advances to the next cutscene action.
 * 
 * @example
 * // Set a global flag
 * cutscene_flag_set(global.flags, "met_sans", true);
 * 
 * @example
 * // Set a persistent flag with numeric value
 * cutscene_flag_set(global.pflags, "times_visited", 5);
 * 
 * @param {ds_map} type - The ds_map to set flag in (global.flags or global.pflags)
 * @param {string} key - Name of the flag to set
 * @param {any} value - Value to assign to the flag
 */
function cutscene_flag_set(type,key,value){
///@description cutscene_flag_set
///@arg  type  - the ds_map of the flag to set (global.flags or global.pflags)
///@arg  key - the name of the flag as set in the ds_map
///@arg value - the value to set to the flag
flag_set(type,key,value);

cutscene_end_action();
}