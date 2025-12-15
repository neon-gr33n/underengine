if(live_call()) return live_result;
draw_set_color(c_red);

if (global.debug){
    // Check if joystick variable exists
    if (variable_instance_exists(id, "ui_joystick")) {
        draw_text(10, 50, "Joystick X: " + string(ui_joystick.get_x()));
        draw_text(10, 70, "Joystick Y: " + string(ui_joystick.get_y()));
        draw_text(10, 90, "Joystick: EXISTS");
    } else {
        draw_text(10, 90, "Joystick: NOT CREATED");
    }
    
    // Draw debug circles at button positions
    for (var i = 0; i < array_length(global.touch_button_positions); i++) {
        var btn = global.touch_button_positions[i];
        var _x = btn[0];
        var _y = btn[1];
        var width = btn[2];
        var height = btn[3];
        var type = btn[4];
        
        draw_circle(_x + width/2, _y + height/2, width/2, false);
    }
    
    input_virtual_debug_draw()
}

if (os_type == os_android){
    var touch_scale = global.touch_scale;
    
    // Draw all buttons from saved positions
    for (var i = 0; i < array_length(global.touch_button_positions); i++) {
        var btn = global.touch_button_positions[i];
        var _x = btn[0];
        var _y = btn[1];
        var width = btn[2];
        var height = btn[3];
        var type = btn[4];
        
        var center_x = _x + width/2;
        var center_y = _y + height/2;
        
        draw_set_alpha(global.touch_opacity);
        
        // Draw button based on type
        switch(type) {
            case 0: // Joystick
                // Draw joystick base
                draw_sprite_ext(spr_touch_bg, 0, center_x, center_y, touch_scale, touch_scale, 0, 0x303030, global.touch_opacity);
                
                // Draw joystick handle (moves based on input)
                if (variable_instance_exists(id, "ui_joystick")) {
                    var handle_x = center_x + (ui_joystick.get_x() * width/2 * 0.7);
                    var handle_y = center_y + (ui_joystick.get_y() * height/2 * 0.7);
                    draw_sprite_ext(spr_touch, 0, handle_x, handle_y, touch_scale, touch_scale, 0, 0x696969, global.touch_opacity);
                }
                break;
                
            case 1: // Action (Z)
                var pressed = (variable_instance_exists(id, "ui_btn_action") ? ui_btn_action.check() : false);
                draw_sprite_ext(spr_button_z, pressed ? 1 : 0, center_x, center_y, touch_scale, touch_scale, 0, c_white, global.touch_opacity);
                break;
                
            case 2: // Cancel (X)
                var pressed = (variable_instance_exists(id, "ui_btn_cancel") ? ui_btn_cancel.check() : false);
                draw_sprite_ext(spr_button_x, pressed ? 1 : 0, center_x, center_y, touch_scale, touch_scale, 0, c_white, global.touch_opacity);
                break;
                
            case 3: // Menu (C)
                var pressed = (variable_instance_exists(id, "ui_btn_menu") ? ui_btn_menu.check() : false);
                draw_sprite_ext(spr_button_c, pressed ? 1 : 0, center_x, center_y, touch_scale, touch_scale, 0, c_white, global.touch_opacity);
                break;
                
            case 4: // Pause
                var pressed = (variable_instance_exists(id, "ui_btn_pause") ? ui_btn_pause.check() : false);
                draw_sprite_ext(spr_button_pause, pressed ? 1 : 0, center_x, center_y, touch_scale, touch_scale, 0, c_white, global.touch_opacity);
                break;
        }
    }
    
    draw_set_alpha(1);
}