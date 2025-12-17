/// @category Cutscenes
/// @title Instance Functions 

/// @func cutscene_move_instance(obj, x, y, [relative], [spd], [facing])
/// @desc Moves an instance to a target position during a cutscene with movement controls
/// @desc Handles both absolute and relative movement with speed and facing direction
/// @param {Instance} obj Instance to move (PLAYER1, NPC, or other object instance)
/// @param {Number} x Target X coordinate (absolute or relative based on relative parameter)
/// @param {Number} y Target Y coordinate (absolute or relative based on relative parameter)
/// @param {Bool} [relative=false] If true, treats x/y as offsets from current position
/// @param {Number} [spd=4] Movement speed in pixels per step (default 4)
/// @param {Number} [facing] Direction to face during movement (0-360 degrees or -1 to maintain current)
/// @example
/// // Move player to absolute position (100, 200) at speed 6, facing right
/// cutscene_move_instance(PLAYER1, 100, 200, false, 6, "right");
/// 
/// @example
/// // Move NPC relative to current position (50 pixels right, 0 up)
/// cutscene_move_instance(obj_npc_sans, 50, 0, true, 4, "up");
/// 
function cutscene_move_instance(){
    /// @arg obj
    /// @arg x
    /// @arg y
    /// @arg relative?
    /// @arg spd
    /// @arg facing
    
    var obj = argument0, relative = argument3, spd = argument4, facing = argument5;
    
    if (x_dest == -1) {
        if (!relative) {
            x_dest = argument1; 
            y_dest = argument2;
        } else { 
            x_dest = obj.x + argument1; 
            y_dest = obj.y + argument2; 
        }
    }
    
    var xx = x_dest;
    var yy = y_dest;
    
    with(obj) { 
        if (point_distance(x, y, xx, yy) >= spd) {
            var _dir = point_direction(x, y, xx, yy);
            var ldirx = lengthdir_x(spd, _dir);
            var ldiry = lengthdir_y(spd, _dir);
            inputdirection = point_direction(x, y, xx, yy); 
            inputmagnitude = 2;
            x += ldirx;
            y += ldiry;
        } else {
            x = xx;
            y = yy;
            inputmagnitude = 0;
            with(other) { 
                x_dest = -1; 
                y_dest = -1; 
                cutscene_end_action(); 
            }
        }
    }
    
    if (variable_instance_exists(obj, "dir")) {
        with(obj) {
            if (obj == PLAYER1) {
                remdir[0] = facing;
            } else {
                dir = facing;    
            }
        }
    }
    
    if (variable_instance_exists(obj, "npc_moving")) {
        with(obj) {
            npc_moving = true;
        }
    }
    
    if (variable_instance_exists(obj, "party_moving")) {
        with(obj) {
            party_moving = true;
        }
    }
}
	
/// @func cutscene_move_instance_to_slot(obj, slot, spd)
/// @desc Moves an instance to a predefined party slot position during a cutscene
/// @desc Uses obj_ow_party's stored positions for party formation slots
/// @param {Instance} obj Instance to move (NPC or party member)
/// @param {Number} slot Party formation slot index (0-based)
/// @param {Number} spd Movement speed in pixels per step
/// @example
/// // Move NPC to slot 2 (third position in formation) at speed 4
/// cutscene_move_instance_to_slot(obj_npc_sans, 2, 4);
function cutscene_move_instance_to_slot(){
    /// @arg obj
    /// @arg slot
    /// @arg spd
    
    var obj = argument0, spd = argument2  // Fixed: argument2 is spd, argument1 is slot
    
    if (x_dest == -1) {
        x_dest = obj_ow_party.remx[25 * argument1]; 
        y_dest = obj_ow_party.remy[25 * argument1];
    }
    
    var xx = x_dest;
    var yy = y_dest;
    
    with(obj) { 
        if (point_distance(x, y, xx, yy) >= spd) {
            var _dir = point_direction(x, y, xx, yy);
            var ldirx = lengthdir_x(spd, _dir);
            var ldiry = lengthdir_y(spd, _dir);
            inputdirection = point_direction(x, y, xx, yy); 
            inputmagnitude = 2;
            x += ldirx;
            y += ldiry;
        } else {
            x = xx;
            y = yy;
            inputmagnitude = 0;
            with(other) {
                x_dest = -1; 
                y_dest = -1; 
                cutscene_end_action();
            }
        }
    }
    
    if (variable_instance_exists(obj, "dir")) {
        with(obj) {
            dir = round(point_direction(x, y, xx, yy) / 90) * 90;
        }
    }
    
    if (variable_instance_exists(obj, "npc_moving")) {
        with(obj) {
            npc_moving = true;
        }
    }
}

/// @func cutscene_move_instances_multi(obj1, x1, y1, relative1, spd1, obj2, x2, y2, relative2, spd2)
/// @desc Moves two instances simultaneously to target positions during a cutscene
/// @desc Both instances move in parallel; cutscene advances only when both reach destinations
/// @param {Instance} obj1 First instance to move
/// @param {Number} x1 Target X coordinate for first instance (absolute or relative)
/// @param {Number} y1 Target Y coordinate for first instance (absolute or relative)
/// @param {Bool} relative1 If true, treats x1/y1 as offsets from obj1's current position
/// @param {Number} spd1 Movement speed for first instance in pixels per step
/// @param {Instance} obj2 Second instance to move
/// @param {Number} x2 Target X coordinate for second instance (absolute or relative)
/// @param {Number} y2 Target Y coordinate for second instance (absolute or relative)
/// @param {Bool} relative2 If true, treats x2/y2 as offsets from obj2's current position
/// @param {Number} spd2 Movement speed for second instance in pixels per step
/// @example
/// // Move two characters to different positions at different speeds
/// cutscene_move_instances_multi(
///     PLAYER1, 100, 200, false, 4,     // Player to (100,200) at speed 4
///     obj_npc_sans, 150, 180, false, 3 // Sans to (150,180) at speed 3
/// );
/// 
/// @example  
/// // Move characters relative to their current positions
/// cutscene_move_instances_multi(
///     obj_party_member1, 50, 0, true, 5,   // Move right 50 pixels
///     obj_party_member2, 0, -30, true, 5   // Move up 30 pixels
/// );
function cutscene_move_instances_multi(){
    /// @arg obj
    /// @arg x
    /// @arg y
    /// @arg relative
    /// @arg spd
    /// @arg obj_2
    /// @arg x_2
    /// @arg y_2
    /// @arg relative_2
    /// @arg spd_2
    
    var obj1moved = false, obj2moved = false;
    
    //--------------------------INSTANCE 1----------------------------------------------------
    var obj = argument0, relative = argument3, spd = argument4;
    
    if (x_dest == -1) {
        if (!relative) {
            x_dest = argument1; 
            y_dest = argument2;
        } else { 
            x_dest = obj.x + argument1; 
            y_dest = obj.y + argument2; 
        }
    }
    
    var xx = x_dest;
    var yy = y_dest;
    
    with(obj) { 
        if (point_distance(x, y, xx, yy) >= spd) {
            var dir = point_direction(x, y, xx, yy);
            var ldirx = lengthdir_x(spd, dir);
            var ldiry = lengthdir_y(spd, dir);
            inputdirection = point_direction(x, y, xx, yy); 
            inputmagnitude = 2;
            x += ldirx;
            y += ldiry;
        } else {
            x = xx;
            y = yy;
            inputmagnitude = 0;
            with(other) {
                x_dest = -1; 
                y_dest = -1; 
                obj1moved = true;
            }
        }
    }
    
    //--------------------------INSTANCE 2----------------------------------------------------
    var obj_2 = argument5, relative_2 = argument8, spd_2 = argument9;
    
    if (x_dest_2 == -1) {
        if (!relative_2) {
            x_dest_2 = argument6; 
            y_dest_2 = argument7;
        } else { 
            x_dest_2 = obj_2.x + argument6; 
            y_dest_2 = obj_2.y + argument7; 
        }
    }
    
    var xx_2 = x_dest_2;
    var yy_2 = y_dest_2;
    
    with(obj_2) { 
        if (point_distance(x, y, xx_2, yy_2) >= spd_2) {
            var dir_2 = point_direction(x, y, xx_2, yy_2);
            var ldirx_2 = lengthdir_x(spd_2, dir_2);
            var ldiry_2 = lengthdir_y(spd_2, dir_2);
            inputdirection = point_direction(x, y, xx_2, yy_2); 
            inputmagnitude = 2;
            x += ldirx_2;
            y += ldiry_2;
        } else {
            x = xx_2;
            y = yy_2;
            inputmagnitude = 0;
            with(other) {
                x_dest_2 = -1; 
                y_dest_2 = -1; 
                obj2moved = true;
            }
        }
    }
    
    //-------------------------------------END CHECKS------------------------------
    if (obj1moved == true && obj2moved == true) {
        cutscene_end_action();
    }
}

/// @func cutscene_move_player(x, y, [relative], [spd], [facing])
/// @desc Moves the player (PLAYER1) to a target position during a cutscene
/// @desc Player-specific version of cutscene_move_instance with simplified parameters
/// @param {Number} x Target X coordinate (absolute or relative based on relative parameter)
/// @param {Number} y Target Y coordinate (absolute or relative based on relative parameter)
/// @param {Bool} [relative=false] If true, treats x/y as offsets from player's current position
/// @param {Number} [spd=4] Movement speed in pixels per step (default 4)
/// @param {Number} [facing] Direction player faces during movement (0-360 degrees)
/// @example
/// // Move player to absolute position (300, 200) at default speed
/// cutscene_move_player(300, 200);
/// 
/// @example  
/// // Move player relative to current position (50 pixels right, 20 up) at speed 6
/// cutscene_move_player(50, -20, true, 6, 0);
/// 
/// @example
/// // Move player to specific coordinates, facing up (90 degrees)
/// cutscene_move_player(100, 150, false, 5, 90);
function cutscene_move_player(){
    /// @arg x
    /// @arg y
    /// @arg relative?
    /// @arg spd
    /// @arg facing
    
    var relative = argument2, spd = argument3, facing = argument4;
    
    if (x_dest == -1) {
        if (!relative) {
            x_dest = argument0; 
            y_dest = argument1;
        } else { 
            x_dest = PLAYER1.x + argument0; 
            y_dest = PLAYER1.y + argument1; 
        }
    }
    
    var xx = x_dest;
    var yy = y_dest;
    
    with(PLAYER1) { 
        if (point_distance(x, y, xx, yy) >= spd) {
            var _dir = point_direction(x, y, xx, yy);
            var ldirx = lengthdir_x(spd, _dir);
            var ldiry = lengthdir_y(spd, _dir);
            inputdirection = point_direction(x, y, xx, yy); 
            inputmagnitude = 2;
            x += ldirx;
            y += ldiry;
        } else {
            x = xx;
            y = yy;
            inputmagnitude = 0;
            with(other) {
                x_dest = -1; 
                y_dest = -1; 
                cutscene_end_action();
            }
        }
    }
    
    PLAYER1.dir = facing;
    
    if (variable_instance_exists(PLAYER1, "party_moving")) {
        with(PLAYER1) {
            party_moving = true;
        }
    }
}
	
/// @func cutscene_set_npc_dir(target, dir)
/// @desc Sets the facing direction of an NPC during a cutscene
/// @desc Updates the NPC's 'dir' variable and advances to next cutscene action
/// @param {Instance} target NPC instance to modify (must have 'dir' variable)
/// @param {Number} dir Direction to face (0-360 degrees, typically 0=right, 90=up, 180=left, 270=down)
/// @example
/// // Make Sans face left (180 degrees)
/// cutscene_set_npc_dir(obj_npc_sans, 180);
/// 
/// @example  
/// // Make Papyrus face up (90 degrees) 
/// cutscene_set_npc_dir(obj_npc_papyrus, 90);
function cutscene_set_npc_dir(){
    /// @arg target
    /// @arg dir
    
    var target = argument0, _dir = argument1;
    
    with (target) {
        dir = _dir;
    }
    
    cutscene_end_action();
}

/// @func cutscene_change_scale(obj_id, image_xscale, image_yscale)
/// @desc Changes the scale of an instance during a cutscene
/// @desc Modifies both X and Y scale of the instance's sprite
/// @param {Instance} obj_id Instance to modify (any object with image_xscale/yscale properties)
/// @param {Number} image_xscale Horizontal scale multiplier (1.0 = normal, 2.0 = double width, 0.5 = half width)
/// @param {Number} image_yscale Vertical scale multiplier (1.0 = normal, 2.0 = double height, 0.5 = half height)
/// @example
/// // Double the size of an NPC
/// cutscene_change_scale(obj_npc_sans, 2.0, 2.0);
/// 
/// @example  
/// // Flip character horizontally (mirror)
/// cutscene_change_scale(PLAYER1, -1.0, 1.0);
/// 
/// @example
/// // Squash character vertically
/// cutscene_change_scale(obj_boss, 1.0, 0.7);
/// 
/// @example
/// // Restore normal size
/// cutscene_change_scale(obj_effect, 1.0, 1.0);
function cutscene_change_scale(){
    /// @arg obj_id
    /// @arg image_xscale
    /// @arg image_yscale
    
    with argument0 {
        image_xscale = argument1; 
        image_yscale = argument2;
    }
    
    cutscene_end_action();
}
	
/// @func cutscene_instance_create(x, y, layer_id, obj, [struct])
/// @desc Creates an instance during a cutscene with optional struct initialization
/// @desc Wrapper for instance_create_layer() that automatically advances cutscene
/// @param {Number} x X coordinate for new instance
/// @param {Number} y Y coordinate for new instance
/// @param {String|Layer} layer_id Layer name or layer ID to create instance on
/// @param {Object|Asset} obj Object asset to create instance of
/// @param {Struct} [struct] Optional struct for initializing instance variables
/// @return {Instance} Instance ID of the created object, or noone if creation failed
/// @example
/// // Create a simple effect at player position
/// cutscene_instance_create(PLAYER1.x, PLAYER1.y, "Effects", obj_sparkle);
function cutscene_instance_create() {
    /// @arg x
    /// @arg y
    /// @arg layer_id
    /// @arg obj
    /// @arg struct (optional) - var_struct for instance_create_layer
    
    // Check if we have the optional struct argument
    var _struct = noone;
    if (argument_count >= 5) {
        _struct = argument[4];
    }
    
    var inst = noone;
    
    // Create instance with or without struct based on argument count
    if (argument_count >= 5 && !is_undefined(_struct)) {
        inst = instance_create_layer(argument0, argument1, argument2, argument3, _struct);
    } else {
        inst = instance_create_layer(argument0, argument1, argument2, argument3);
    }
    
    // Check if instance was successfully created before calling end action
    if (instance_exists(inst)) {
        cutscene_end_action();
    } else {
        // Optional: Handle the case where instance creation failed
        show_debug_message("cutscene_instance_create: Failed to create instance of " + object_get_name(argument3));
    }
    
    return inst;
}
	
/// @func cutscene_instance_destroy(obj_id)
/// @desc Destroys an instance during a cutscene
/// @desc Wrapper for instance_destroy() that automatically advances cutscene
/// @param {Instance} obj_id Instance to destroy (must exist)
/// @example
/// // Destroy a temporary effect
/// cutscene_instance_destroy(obj_sparkle_effect);
/// 
/// @example  
/// // Destroy an NPC after dialogue
/// cutscene_instance_destroy(obj_npc_ghost);
/// 
/// @example
/// // Destroy multiple instances in sequence
/// cutscene_instance_destroy(obj_portal_effect);
/// cutscene_instance_destroy(obj_portal_collider);
function cutscene_instance_destroy(){
    /// @arg obj_id
    
    with(argument0) {
        instance_destroy();
    }
    
    cutscene_end_action();
}
	
/// @func cutscene_instance_destroy_nearest(x, y, obj_id)
/// @desc Destroys the nearest instance of a specified object during a cutscene
/// @desc Finds the closest instance to (x,y) and destroys it via cutscene_instance_destroy()
/// @param {Number} x X coordinate to search from
/// @param {Number} y Y coordinate to search from
/// @param {Object|Asset} obj_id Object type to search for (e.g., obj_enemy, obj_item)
/// @example  
/// // Destroy nearest item at specific position
/// cutscene_instance_destroy_nearest(100, 200, obj_collectible);
function cutscene_instance_destroy_nearest(){
    /// @arg x
    /// @arg y
    /// @arg obj_id
    
    var inst = instance_nearest(argument0, argument1, argument2);
    cutscene_instance_destroy(inst);
}

/// @func cutscene_replace_instance(target_instance, replacer_instance)
/// @desc Replaces one instance with another during a cutscene
/// @desc Copies position from target to replacer, then destroys the target instance
/// @param {Instance} target_instance Instance to be replaced/destroyed
/// @param {Instance} replacer_instance Instance to take target's position (must already exist)
/// @example
/// // Replace NPC with happy version at same position
/// cutscene_replace_instance(obj_npc_sad, obj_npc_happy);
function cutscene_replace_instance(){
    /// @arg target_instance
    /// @arg replacer_instance
    
    var obj1 = argument0, obj2 = argument1;
    
    obj2.x = obj1.x;
    obj2.y = obj1.y;
    
    with obj1 {
        instance_destroy();
    }
    
    cutscene_end_action();
}
	
/// @func cutscene_replace_instance_nearest(target_type, replacer_instance, x, y)
/// @desc Finds and replaces the nearest instance of a type with another instance during a cutscene
/// @desc Searches for nearest instance of target type, copies position to replacer, then destroys target
/// @param {Object|Asset} target_type Object type to find and replace (e.g., obj_enemy, obj_item)
/// @param {Instance} replacer_instance Instance to take target's position (must already exist)
/// @param {Number} x X coordinate to search from
/// @param {Number} y Y coordinate to search from
function cutscene_replace_instance_nearest(){
    /// @arg target_instance
    /// @arg replacer_instance
    /// @arg x
    /// @arg y
    
    var obj1 = instance_nearest(argument2, argument3, argument0), obj2 = argument1;
    
    obj2.x = obj1.x;
    obj2.y = obj1.y;
    
    with obj1 {
        instance_destroy();
    }
    
    cutscene_end_action();
}