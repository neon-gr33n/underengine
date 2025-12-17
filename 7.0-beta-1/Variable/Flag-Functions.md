# Variable/Flag Functions

## `cutscene_change_global(var_name_as_string, value)` → `undefined`
Sets or changes a global variable during a cutscene
Only sets the variable if it doesn't already exist (safe initialization)

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`var_name_as_string` |String |Name of global variable as string (e.g., "game_progress") |
|`value` |Any |Value to assign to the global variable (any data type) |
```gml
 // Initialize or set a progress flag
 cutscene_change_global("met_sans", true);
```

## `cutscene_change_variable(obj, var_name_as_string, value)` → `undefined`
Changes an instance variable during a cutscene
Sets a specific variable on an instance using variable_instance_set()

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj` |Instance |Instance to modify (must exist) |
|`var_name_as_string` |String |Name of instance variable as string (e.g., "health", "state", "counter") |
|`value` |Any |Value to assign to the instance variable (any data type) |












## `cutscene_flag_set()` → `undefined`
Sets a flag during a cutscene and advances to the next cutscene action
Wrapper function that combines flag_set() with automatic cutscene progression

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`type` |DS_Map |The ds_map to set flag in (global.flags or global.pflags) |
|`key` |String |Name of the flag to set |
|`value` |Any |Value to assign to the flag (can be any data type) |
```gml
 // Set a global flag
 cutscene_flag_set(global.flags, "met_sans", true);
 
```gml
 // Set a persistent flag with numeric value
 cutscene_flag_set(global.pflags, "times_visited", 5);
 
```gml
 // Set flag with string value
 cutscene_flag_set(global.flags, "last_location", "ruins");
```
