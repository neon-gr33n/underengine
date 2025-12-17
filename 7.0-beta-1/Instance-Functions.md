# Instance Functions

## `cutscene_move_instance(obj, x, y, [relative], [spd], [facing])` → `undefined`
Moves an instance to a target position during a cutscene with movement controls
Handles both absolute and relative movement with speed and facing direction

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj` |Instance |Instance to move (PLAYER1, NPC, or other object instance) |
|`x` |Number |Target X coordinate (absolute or relative based on relative parameter) |
|`y` |Number |Target Y coordinate (absolute or relative based on relative parameter) |
|`[relative=false]` |Bool |If true, treats x/y as offsets from current position |
|`[spd=4]` |Number |Movement speed in pixels per step (default 4) |
|`[facing]` |Number |Direction to face during movement (0-360 degrees or -1 to maintain current) |
```gml
 // Move player to absolute position (100, 200) at speed 6, facing right
 cutscene_move_instance(PLAYER1, 100, 200, false, 6, "right");
 
```gml
 // Move NPC relative to current position (50 pixels right, 0 up)
 cutscene_move_instance(obj_npc_sans, 50, 0, true, 4, "up");
 
```

## `cutscene_move_instance_to_slot(obj, slot, spd)` → `undefined`
Moves an instance to a predefined party slot position during a cutscene
Uses obj_ow_party's stored positions for party formation slots

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj` |Instance |Instance to move (NPC or party member) |
|`slot` |Number |Party formation slot index (0-based) |
|`spd` |Number |Movement speed in pixels per step |
```gml
 // Move NPC to slot 2 (third position in formation) at speed 4
 cutscene_move_instance_to_slot(obj_npc_sans, 2, 4);
```

## `cutscene_move_instances_multi(obj1, x1, y1, relative1, spd1, obj2, x2, y2, relative2, spd2)` → `undefined`
Moves two instances simultaneously to target positions during a cutscene
Both instances move in parallel; cutscene advances only when both reach destinations

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj1` |Instance |First instance to move |
|`x1` |Number |Target X coordinate for first instance (absolute or relative) |
|`y1` |Number |Target Y coordinate for first instance (absolute or relative) |
|`relative1` |Bool |If true, treats x1/y1 as offsets from obj1's current position |
|`spd1` |Number |Movement speed for first instance in pixels per step |
|`obj2` |Instance |Second instance to move |
|`x2` |Number |Target X coordinate for second instance (absolute or relative) |
|`y2` |Number |Target Y coordinate for second instance (absolute or relative) |
|`relative2` |Bool |If true, treats x2/y2 as offsets from obj2's current position |
|`spd2` |Number |Movement speed for second instance in pixels per step |
```gml
 // Move two characters to different positions at different speeds
 cutscene_move_instances_multi(
     PLAYER1, 100, 200, false, 4,     // Player to (100,200) at speed 4
     obj_npc_sans, 150, 180, false, 3 // Sans to (150,180) at speed 3
 );
 
```gml
 // Move characters relative to their current positions
 cutscene_move_instances_multi(
     obj_party_member1, 50, 0, true, 5,   // Move right 50 pixels
     obj_party_member2, 0, -30, true, 5   // Move up 30 pixels
 );
```

## `cutscene_move_player(x, y, [relative], [spd], [facing])` → `undefined`
Moves the player (PLAYER1) to a target position during a cutscene
Player-specific version of cutscene_move_instance with simplified parameters

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`x` |Number |Target X coordinate (absolute or relative based on relative parameter) |
|`y` |Number |Target Y coordinate (absolute or relative based on relative parameter) |
|`[relative=false]` |Bool |If true, treats x/y as offsets from player's current position |
|`[spd=4]` |Number |Movement speed in pixels per step (default 4) |
|`[facing]` |Number |Direction player faces during movement (0-360 degrees) |
```gml
 // Move player to absolute position (300, 200) at default speed
 cutscene_move_player(300, 200);
 
```gml
 // Move player relative to current position (50 pixels right, 20 up) at speed 6
 cutscene_move_player(50, -20, true, 6, 0);
 
```gml
 // Move player to specific coordinates, facing up (90 degrees)
 cutscene_move_player(100, 150, false, 5, 90);
```

## `cutscene_set_npc_dir(target, dir)` → `undefined`
Sets the facing direction of an NPC during a cutscene
Updates the NPC's 'dir' variable and advances to next cutscene action

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`target` |Instance |NPC instance to modify (must have 'dir' variable) |
|`dir` |Number |Direction to face (0-360 degrees, typically 0=right, 90=up, 180=left, 270=down) |
```gml
 // Make Sans face left (180 degrees)
 cutscene_set_npc_dir(obj_npc_sans, 180);
 
```gml
 // Make Papyrus face up (90 degrees) 
 cutscene_set_npc_dir(obj_npc_papyrus, 90);
```

## `cutscene_change_scale(obj_id, image_xscale, image_yscale)` → `undefined`
Changes the scale of an instance during a cutscene
Modifies both X and Y scale of the instance's sprite

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj_id` |Instance |Instance to modify (any object with image_xscale/yscale properties) |
|`image_xscale` |Number |Horizontal scale multiplier (1.0 = normal, 2.0 = double width, 0.5 = half width) |
|`image_yscale` |Number |Vertical scale multiplier (1.0 = normal, 2.0 = double height, 0.5 = half height) |
```gml
 // Double the size of an NPC
 cutscene_change_scale(obj_npc_sans, 2.0, 2.0);
 
```gml
 // Flip character horizontally (mirror)
 cutscene_change_scale(PLAYER1, -1.0, 1.0);
 
```gml
 // Squash character vertically
 cutscene_change_scale(obj_boss, 1.0, 0.7);
 
```gml
 // Restore normal size
 cutscene_change_scale(obj_effect, 1.0, 1.0);
```

## `cutscene_instance_create(x, y, layer_id, obj, [struct])` → *Instance*
Creates an instance during a cutscene with optional struct initialization
Wrapper for instance_create_layer() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`x` |Number |X coordinate for new instance |
|`y` |Number |Y coordinate for new instance |
|`layer_id` |String|Layer |Layer name or layer ID to create instance on |
|`obj` |Object|Asset |Object asset to create instance of |
|`[struct]` |Struct |Optional struct for initializing instance variables |

**Returns:** Instance ID of the created object, or noone if creation failed
```gml
 // Create a simple effect at player position
 cutscene_instance_create(PLAYER1.x, PLAYER1.y, "Effects", obj_sparkle);
```

## `cutscene_instance_destroy(obj_id)` → `undefined`
Destroys an instance during a cutscene
Wrapper for instance_destroy() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`obj_id` |Instance |Instance to destroy (must exist) |
```gml
 // Destroy a temporary effect
 cutscene_instance_destroy(obj_sparkle_effect);
 
```gml
 // Destroy an NPC after dialogue
 cutscene_instance_destroy(obj_npc_ghost);
 
```gml
 // Destroy multiple instances in sequence
 cutscene_instance_destroy(obj_portal_effect);
 cutscene_instance_destroy(obj_portal_collider);
```

## `cutscene_instance_destroy_nearest(x, y, obj_id)` → `undefined`
Destroys the nearest instance of a specified object during a cutscene
Finds the closest instance to (x,y) and destroys it via cutscene_instance_destroy()

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`x` |Number |X coordinate to search from |
|`y` |Number |Y coordinate to search from |
|`obj_id` |Object|Asset |Object type to search for (e.g., obj_enemy, obj_item) |
```gml
 // Destroy nearest item at specific position
 cutscene_instance_destroy_nearest(100, 200, obj_collectible);
```

## `cutscene_replace_instance(target_instance, replacer_instance)` → `undefined`
Replaces one instance with another during a cutscene
Copies position from target to replacer, then destroys the target instance

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`target_instance` |Instance |Instance to be replaced/destroyed |
|`replacer_instance` |Instance |Instance to take target's position (must already exist) |
```gml
 // Replace NPC with happy version at same position
 cutscene_replace_instance(obj_npc_sad, obj_npc_happy);
```

## `cutscene_replace_instance_nearest(target_type, replacer_instance, x, y)` → `undefined`
Finds and replaces the nearest instance of a type with another instance during a cutscene
Searches for nearest instance of target type, copies position to replacer, then destroys target

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`target_type` |Object|Asset |Object type to find and replace (e.g., obj_enemy, obj_item) |
|`replacer_instance` |Instance |Instance to take target's position (must already exist) |
|`x` |Number |X coordinate to search from |
|`y` |Number |Y coordinate to search from |













