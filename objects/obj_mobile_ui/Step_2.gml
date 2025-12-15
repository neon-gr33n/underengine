//if (!is_android() || global.input_device == "gamepad") {
//	visible = false;	
//} else {
//	visible = true;	
//}

for (var i = 0; i < array_length(global.touch_button_positions); i++) {
    var btn = global.touch_button_positions[i];
  //  show_debug_message("Button " + string(i) + ": x=" + string(btn[0]) + " y=" + string(btn[1]) + " width=" + string(btn[2]) + " height=" + string(btn[3]) + " type=" + string(btn[4]));
    
    // Validate the button data
    if (!is_array(btn) || array_length(btn) < 5) {
     //   show_debug_message("ERROR: Button " + string(i) + " is invalid!");
        continue;
    }
    
    var _x = btn[0];
    var _y = btn[1];
    var width = btn[2];
    var type = btn[4];
    
    // Check for valid values
    if (!is_real(_x) || !is_real(_y) || !is_real(width) || width <= 0) {
        //show_debug_message("ERROR: Button " + string(i) + " has invalid position/size!");
        continue;
    }
    
    var radius = width/2;
    var center_x = _x + radius;
    var center_y = _y + radius;
    
    // Check for valid center coordinates
    if (!is_real(center_x) || !is_real(center_y)) {
      //  show_debug_message("ERROR: Button " + string(i) + " has invalid center coordinates!");
        continue;
    }
    
  //  show_debug_message("Updating button " + string(i) + " at (" + string(center_x) + "," + string(center_y) + ") with radius " + string(radius));
    
    switch(type) {
        case 0: // Joystick
            if (variable_instance_exists(id, "ui_joystick") && ui_joystick != noone) {
                ui_joystick.circle(center_x, center_y, radius);
       //         show_debug_message("Updated joystick circle");
            }
            break;
            
        case 1: // Action (Z)
            if (variable_instance_exists(id, "ui_btn_action") && ui_btn_action != noone) {
                ui_btn_action.circle(center_x, center_y, radius);
     //           show_debug_message("Updated action button circle");
            }
            break;
            
        case 2: // Cancel (X)
            if (variable_instance_exists(id, "ui_btn_cancel") && ui_btn_cancel != noone) {
                ui_btn_cancel.circle(center_x, center_y, radius);
     //           show_debug_message("Updated cancel button circle");
            }
            break;
            
        case 3: // Menu (C)
            if (variable_instance_exists(id, "ui_btn_menu") && ui_btn_menu != noone) {
                ui_btn_menu.circle(center_x, center_y, radius);
       //         show_debug_message("Updated menu button circle");
            }
            break;
            
        case 4: // Pause
            if (variable_instance_exists(id, "ui_btn_pause") && ui_btn_pause != noone) {
                ui_btn_pause.circle(center_x, center_y, radius);
        //        show_debug_message("Updated pause button circle");
            }
            break;
            
        default:
            show_debug_message("WARNING: Unknown button type: " + string(type));
            break;
    }
}