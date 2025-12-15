// Set depth
depth = -99999999;

// Touch button layout editing
touch_editing = false;
selected_button = -1;
button_drag_offset_x = 0;
button_drag_offset_y = 0;

// Default button positions (relative to screen edges)
// Format: [x, y, width, height, button_type, label]
// button_type: 0=joystick, 1=action, 2=cancel, 3=menu, 4=pause
if (!variable_global_exists("touch_button_positions")) {
    // Load saved layout if it exists, otherwise use defaults
    load_touch_layout();
    
    // If still not set (file didn't exist or load failed), use defaults
    if (!variable_global_exists("touch_button_positions") || array_length(global.touch_button_positions) == 0) {
        global.touch_button_positions = get_default_touch_positions();
        show_debug_message("Using default touch layout");
    }
}

// Set alarm to create virtual buttons after a short delay
if (os_type == os_android) {
    alarm[0] = 3; // 3 frames delay to ensure display dimensions are ready
}