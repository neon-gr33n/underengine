/// Initializes the flag system, ran in game init as flags_init(true)
/// There's no need to run this manually
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

// Sets a flag
// @arg type - DS Map stored within global variable, normal flags are global.flags,
//persistent data is global.pflags
// @arg flag - The actual flag id, must be a string (e.g "area"
// @arg value - The value to assign to the flag, can be an integer, array or string depending on what
// the flag needs (if you're unsure, check flags_init for the flag you are trying to modify)
function flag_set(type,flag,value){
	return ds_map_set(type,flag,value)
}

// Gets the value of a given flag
// @arg type - DS Map stored within global variable, normal flags are global.flags,
// @arg flag - The actual flag id, must be a string (e.g "area"
function flag_get(type,flag){
	return ds_map_find_value(type,flag);	
}