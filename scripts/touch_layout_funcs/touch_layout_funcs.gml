/**
 * Saves the current touch button layout to a file.
 * @example
 * // Save player's custom button layout
 * save_touch_layout();
 */
function save_touch_layout() {
    // Save touch button positions to a file
    var buffer = buffer_create(1024, buffer_grow, 1);
    
    // Write number of buttons
    buffer_write(buffer, buffer_u8, array_length(global.touch_button_positions));
    
    // Write each button's data
    for (var i = 0; i < array_length(global.touch_button_positions); i++) {
        var btn = global.touch_button_positions[i];
        buffer_write(buffer, buffer_f32, btn[0]); // x
        buffer_write(buffer, buffer_f32, btn[1]); // y
        buffer_write(buffer, buffer_f32, btn[2]); // width
        buffer_write(buffer, buffer_f32, btn[3]); // height
        buffer_write(buffer, buffer_u8, btn[4]);  // type
        // Optional: Save label string if needed
        // buffer_write_string(buffer, btn[5]);
    }
    
    // Save to file
    buffer_save(buffer, "touch_layout.dat");
    buffer_delete(buffer);
    
    show_debug_message("Touch layout saved");
}

/**
 * Loads touch button layout from saved file.
 * @example
 * // Load saved layout on game start
 * if (!load_touch_layout()) {
 *     // Use defaults if no saved layout
 *     global.touch_button_positions = get_default_touch_positions();
 * }
 * 
 * @returns {boolean} True if layout loaded successfully, false otherwise
 */
function load_touch_layout() {
    // Load touch button positions from file
    if (file_exists("touch_layout.dat")) {
        var buffer = buffer_load("touch_layout.dat");
        var num_buttons = buffer_read(buffer, buffer_u8);
        
        // Clear existing positions
        global.touch_button_positions = [];
        
        // Read each button's data
        for (var i = 0; i < num_buttons; i++) {
            var _x = buffer_read(buffer, buffer_f32);
            var _y = buffer_read(buffer, buffer_f32);
            var width = buffer_read(buffer, buffer_f32);
            var height = buffer_read(buffer, buffer_f32);
            var type = buffer_read(buffer, buffer_u8);
            
            // FIXED: Correct ternary operator syntax
	        var label = "";
			switch (type) {
			    case 0: label = "joystick"; break;
			    case 1: label = "Z"; break;
			    case 2: label = "X"; break;
			    case 3: label = "C"; break;
			    case 4: label = "P"; break;
			    default: label = "?"; break;
			}
			
            
            array_push(global.touch_button_positions, [_x, _y, width, height, type, label]);
        }
        
        buffer_delete(buffer);
        show_debug_message("Touch layout loaded");
        return true; // Return success
    } else {
        show_debug_message("No saved touch layout found, using defaults");
        return false; // Return failure
    }
}

/**
 * Returns the default touch button positions.
 * @example
 * // Reset to default layout
 * global.touch_button_positions = get_default_touch_positions();
 * 
 * @returns {array} Array of default button positions with [x, y, width, height, type, label]
 */
function get_default_touch_positions() {
    return [
        [100, 480 - 150, 80, 80, 0, "joystick"],
        [655-200 + 25, 305+55 + 25, 40, 40, 1, "Z"],
        [755-200 + 25, 30 + 25, 40, 40, 4, "P"],
        [710-200 + 25, 360+55 + 25, 40, 40, 2, "X"],
        [765-200 + 25, 305+55 + 25, 40, 40, 3, "C"]
    ];
}