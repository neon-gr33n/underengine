/// @category Cutscenes
/// @title Variable/Flag Functions 


/// @func cutscene_change_global(var_name_as_string, value)
/// @desc Sets or changes a global variable during a cutscene
/// @desc Only sets the variable if it doesn't already exist (safe initialization)
/// @param {String} var_name_as_string Name of global variable as string (e.g., "game_progress")
/// @param {Any} value Value to assign to the global variable (any data type)
/// @example
/// // Initialize or set a progress flag
/// cutscene_change_global("met_sans", true);
function cutscene_change_global(){
    /// @arg var_name_as_string
    /// @arg value
    
    if (!variable_global_exists(argument0)) {
        variable_global_set(argument0, argument1);
    }
    
    cutscene_end_action();
}

/// @func cutscene_change_variable(obj, var_name_as_string, value)
/// @desc Changes an instance variable during a cutscene
/// @desc Sets a specific variable on an instance using variable_instance_set()
/// @param {Instance} obj Instance to modify (must exist)
/// @param {String} var_name_as_string Name of instance variable as string (e.g., "health", "state", "counter")
/// @param {Any} value Value to assign to the instance variable (any data type)
function cutscene_change_variable(){
    /// @arg obj
    /// @arg var_name_as_string
    /// @arg value
    
    with(argument0) {
        variable_instance_set(id, argument1, argument2);
    }
    
    cutscene_end_action();
}

// and flag stuff too because why not

/// @func cutscene_flag_set()
/// @desc Sets a flag during a cutscene and advances to the next cutscene action
/// @desc Wrapper function that combines flag_set() with automatic cutscene progression
/// @param {DS_Map} type The ds_map to set flag in (global.flags or global.pflags)
/// @param {String} key Name of the flag to set
/// @param {Any} value Value to assign to the flag (can be any data type)
/// @example
/// // Set a global flag
/// cutscene_flag_set(global.flags, "met_sans", true);
/// 
/// @example  
/// // Set a persistent flag with numeric value
/// cutscene_flag_set(global.pflags, "times_visited", 5);
/// 
/// @example
/// // Set flag with string value
/// cutscene_flag_set(global.flags, "last_location", "ruins");
function cutscene_flag_set(type, key, value){
    flag_set(type, key, value);
    cutscene_end_action();
}