# Flags

## `flags_init([argument0])` → `undefined`
Initializes the flag system

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[argument0]` |boolean |Create new ds_maps if true |



















## `flag_set(type, flag, value)` → *number*
Sets a flag value

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`type` |ds_map |DS Map (global.flags or global.pflags) |
|`flag` |string |Flag identifier |
|`value` |any |Value to assign to flag |

**Returns:** Returns result of ds_map_set

## `flag_get(type, flag)` → *any*
Gets the value of a given flag

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`type` |ds_map |DS Map (global.flags or global.pflags) |
|`flag` |string |Flag identifier |

**Returns:** Flag value
