if (os_type == os_android) {
    // Create virtual buttons at saved positions
    show_debug_message("Creating virtual buttons...");
    
    // First, validate the button positions
    for (var i = 0; i < array_length(global.touch_button_positions); i++) {
        var btn = global.touch_button_positions[i];
        show_debug_message("Button " + string(i) + ": x=" + string(btn[0]) + " y=" + string(btn[1]) + " width=" + string(btn[2]) + " height=" + string(btn[3]) + " type=" + string(btn[4]));
        
        // Validate the button data
        if (!is_array(btn) || array_length(btn) < 5) {
            show_debug_message("ERROR: Button " + string(i) + " is invalid!");
            continue;
        }
        
        var _x = btn[0];
        var _y = btn[1];
        var width = btn[2];
        var type = btn[4];
        
        // Check for valid values
        if (!is_real(_x) || !is_real(_y) || !is_real(width) || width <= 0) {
            show_debug_message("ERROR: Button " + string(i) + " has invalid position/size!");
            continue;
        }
        
        var radius = width/2;
        var center_x = _x + radius;
        var center_y = _y + radius;
        
        // Check for valid center coordinates
        if (!is_real(center_x) || !is_real(center_y)) {
            show_debug_message("ERROR: Button " + string(i) + " has invalid center coordinates!");
            continue;
        }
        
        show_debug_message("Creating button " + string(i) + " at (" + string(center_x) + "," + string(center_y) + ") with radius " + string(radius));
        
        switch(type) {
            case 0: // Joystick
                ui_joystick = input_virtual_create()
                    .circle(center_x, center_y, radius)
                    .thumbstick("", "left", "right", "up", "down");
                show_debug_message("Created joystick");
                break;
                
            case 1: // Action (Z)
                ui_btn_action = input_virtual_create()
                    .circle(center_x, center_y, radius)
                    .button("action");
                show_debug_message("Created action button");
                break;
                
            case 2: // Cancel (X)
                ui_btn_cancel = input_virtual_create()
                    .circle(center_x, center_y, radius)
                    .button("cancel");
                show_debug_message("Created cancel button");
                break;
                
            case 3: // Menu (C)
                ui_btn_menu = input_virtual_create()
                    .circle(center_x, center_y, radius)
                    .button("menu");
                show_debug_message("Created menu button");
                break;
                
            case 4: // Pause
                ui_btn_pause = input_virtual_create()
                    .circle(center_x, center_y, radius)
                    .button("pause");
                show_debug_message("Created pause button");
                break;
                
            default:
                show_debug_message("WARNING: Unknown button type: " + string(type));
                break;
        }
    }
    
    show_debug_message("Virtual button creation complete");
} else {
    // do not create on windows    
}