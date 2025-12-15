puzzle_code = undefined;
current_input = "";
max_length = 4;
puzzle_flag = "";
is_solved = false;
active_and_enabled = true;
solve_callback = noone;
solid_enabled = true;
puzzle_solids = []; // Array to store found solid instances
reset_object_positions = false;
objects_to_reset = []; // Array of object types to reset (empty = all objects)
reset_positions = ds_map_create(); // Store original positions
activated_instances = ds_list_create();

find_puzzle_solids();

#region Puzzle state management
// Check if already solved
if (puzzle_flag != "") {
    is_solved = flag_get(global.flags, puzzle_flag);
	
	if(is_solved){
		set_puzzle_solids_active(false);
	} else {
		// Make sure solids are active if puzzle is unsolved
        set_puzzle_solids_active(true);
	}
}

if (reset_object_positions) {
    store_initial_positions();
}

function puzzle_solve() {
    is_solved = true;
	
	// Disable all puzzle solids
	set_puzzle_solids_active(false);
	
    if (puzzle_flag != "") {
        flag_set(global.flags, puzzle_flag, 1);
    }

    // Call function if exists
    if (is_callable(solve_callback)) {
        solve_callback();  // ← simply call it!
    }
}

function puzzle_activate(_key_value, _instance_id) {
    if (is_solved) return;
    
    // Prevent duplicate activations from same instance
    if (ds_list_find_index(activated_instances, _instance_id) != -1) {
        return;
    }
    
    // Add to current input, but respect max length
    if (string_length(current_input) < max_length) {
        current_input += _key_value;
        ds_list_add(activated_instances, _instance_id);
    } else {
        // Optional: cycle input (remove first, add new)
        current_input = string_copy(current_input, 2, max_length - 1) + _key_value;
        // Clear and re-add instances if cycling
        ds_list_clear(activated_instances);
        ds_list_add(activated_instances, _instance_id);
    }
    
	show_debug_message("ACTIVATED by: " + string(_instance_id));
    show_debug_message("Puzzle input: " + current_input + " | Target: " + puzzle_code);
}
	
/// @function puzzle_reset()
function puzzle_reset() {
    current_input = "";
    is_solved = false;
    ds_list_clear(activated_instances);
	
	 // Re-enable all puzzle solids
    set_puzzle_solids_active(true);
    
    // Reset all puzzle keys
    with (obj_puzzle_key) {
        image_index = 0;
        if (variable_instance_exists(id, "is_active")) is_active = false;
        if (variable_instance_exists(id, "is_pressed")) is_pressed = false;
		if (variable_instance_exists(id, "snd_played")) snd_played = false;
    }
	
	// Reset all puzzle locks 
	with (obj_puzzle_lock) {
		image_index = 0;	
	}
    
    // Reset object positions if enabled
    if (reset_object_positions) {
        reset_objects_positions();
    }
    
    if (puzzle_flag != "") {
        flag_set(global.flags, puzzle_flag, 0);
    }
    
    show_debug_message("Puzzle reset" + (reset_object_positions ? " with object positions" : ""));
}
#endregion

#region Position data handling
/// @function reset_objects_positions()
function reset_objects_positions() {
    var _keys = ds_map_find_keys(reset_positions);
    
    for (var i = 0; i < ds_list_size(_keys); i++) {
        var _id = _keys[| i];
        var _pos_data = reset_positions[? _id];
        
        if (instance_exists(_id)) {
            _id.x = _pos_data.start_x;
            _id.y = _pos_data.start_y;
            _id.sprite_index = _pos_data.start_sprite;
            _id.image_index = _pos_data.start_image_index;
        }
    }
    
    ds_list_destroy(_keys);
}
	
/// @function store_initial_positions()
function store_initial_positions() {
    ds_map_clear(reset_positions);
    
    with (all) {
        if (object_index != obj_puzzle_lock && object_index != obj_puzzle_key) {
            // Check if this object type should be reset
            if (array_length(other.objects_to_reset) == 0 || 
                array_contains(other.objects_to_reset, object_index)) {
                
                var _pos_data = {
                    start_x: x,
                    start_y: y,
                    start_sprite: sprite_index,
                    start_image_index: image_index
                };
                
                other.reset_positions[? id] = _pos_data;
            }
        }
    }
}
#endregion
	
#region Puzzle collision management
/// @function find_puzzle_solids()
function find_puzzle_solids() {
    puzzle_solids = [];
    instance_activate_all();
    
    show_debug_message("=== DEBUG: Searching for puzzle solids ===");
    
    var _inst = instance_find(obj_solid_puzzle, 0);
    while (_inst != noone) {
        // Check if collision_group exists AND equals "puzzle"
        var _is_puzzle_solid = false;
        var _group_value = "VARIABLE_NOT_FOUND";
        
        if (variable_instance_exists(_inst, "collision_group")) {
            _group_value = _inst.collision_group;
            _is_puzzle_solid = (_group_value == "puzzle");
        }
        
        show_debug_message("Solid ID: " + string(_inst) + " | collision_group: '" + string(_group_value) + "'");
        
        if (_is_puzzle_solid) {
            array_push(puzzle_solids, _inst);
            show_debug_message("✓ ADDED TO PUZZLE SOLIDS");
        }
        
        _inst = instance_find(obj_solid_puzzle, _inst);
    }
    
    show_debug_message("=== DEBUG: Found " + string(array_length(puzzle_solids)) + " puzzle solids ===");
    
    if (is_solved) {
        set_puzzle_solids_active(false);
    }
}

/// @function set_puzzle_solids_active(active)
function set_puzzle_solids_active(_active) {
    for (var i = 0; i < array_length(puzzle_solids); i++) {
        var _solid = puzzle_solids[i];
        if (instance_exists(_solid)) {
			switch(_active){
				case true:
					instance_activate_object(_solid)
					break;
				case false:
					instance_deactivate_object(_solid)
					break;
			}
        }
    }
    
    show_debug_message("Puzzle solids " + (_active ? "enabled" : "disabled"));
}
#endregion