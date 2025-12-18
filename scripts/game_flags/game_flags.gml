/// @category Game
/// @title Flags

/// @function flags_init([argument0])
/// @description Initializes the flag system
/// @param {boolean} [argument0] Create new ds_maps if true
function flags_init(argument0){
		if argument0
			global.flags	=	ds_map_create();
		ds_map_set(global.flags, "plot", 0); 
		ds_map_set(global.flags, "world", 0); 
		ds_map_set(global.flags, "enc", -1);
		ds_map_set(global.flags,"geno",0);
		ds_map_set(global.flags,"section",0);
		ds_map_set(global.flags,"section_kills",0);
		ds_map_set(global.flags, "rm_r", -1);   // Room Return- this sets the room prior to starting an encounter, and takes us back to it after
		// Custom flags go below this line		
		//End custom flags
		if argument0
			global.pflags	=	ds_map_create();
		ds_map_set(global.pflags, "resets", 0);
		ds_map_set(global.pflags, "last_reset_slot", -1);
}

/// @function flag_set(type, flag, value)
/// @description Sets a flag value
/// @param {ds_map} type DS Map (global.flags or global.pflags)
/// @param {string} flag Flag identifier
/// @param {any} value Value to assign to flag
/// @returns {number} Returns result of ds_map_set
function flag_set(type,flag,value){
	return ds_map_set(type,flag,value)
}

/// @function flag_get(type, flag)
/// @description Gets the value of a given flag
/// @param {ds_map} type DS Map (global.flags or global.pflags)
/// @param {string} flag Flag identifier
/// @returns {any} Flag value
function flag_get(type,flag){
	return ds_map_find_value(type,flag);	
}