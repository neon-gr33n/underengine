if(live_call()) return live_result;

draw_set_alpha(image_alpha)
draw_rectangle_color(0,0,640,480,c_black,c_black,c_black,c_black,false)

_alpha = (image_alpha/0.8*1)

draw_set_halign(fa_center)
draw_set_font(loc_get_font(fnt_main))
d_width = window_get_fullscreen() ? window_get_width() : surface_get_width(application_surface)
d_height = window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface)

// Header background
//draw_rectangle_color(0,0,window_get_width(),window_get_height()/11,c_black,c_black,c_black,c_black,false)
draw_sprite_centered_ext(spr_gj_logo,0,d_width/2,40/960*d_height*2,1,1,0,c_white,_alpha)
draw_sprite_ext(spr_px,0,0,78,GAME_RES.w,4,0,c_white,_alpha)

// Initialize scroll variables
if (!variable_global_exists("trophy_scroll_y")) {
    global.trophy_scroll_y = 0;
    global.trophy_scroll_max = 0;
    global.trophy_scroll_velocity = 0;
    global.trophy_scroll_target = 0;
}

switch(_state)
{
    case "gj_hub":
        draw_set_color(c_white)
        draw_text_transformed(d_width/2,d_height/6*1.2,"Welcome, " + "@"+global.gj_username +"!",1.5/960*d_height,1.5/960*d_height,0)
        draw_set_color(_menued == 0 ? c_aqua : c_white)
        draw_text_transformed(d_width/6,d_height/4*1,"Sign out",2/960*d_height,2/960*d_height,0)
        draw_set_color(_menued == 1 ? c_aqua : c_white)
        draw_text_transformed(d_width/4.4,d_height/4*1.3,"View trophies",2/960*d_height,2/960*d_height,0)
		
		draw_sprite_centered_ext(global.__gj_avatar,0,d_width/2*1.4,40/960*d_height*5.5,0.2,0.2,0,c_white,_alpha)
		
		  // Draw instructions
        draw_set_color(c_gray);
        draw_set_halign(fa_center);
        draw_text_transformed(d_width/2, d_height - 40, "Use UP/DOWN to change selection - C/CTRL to confirm choice - X to Return to Previous Page", 1.0/960*d_height, 1.0/960*d_height, 0);

        // Process Input
        if input.down_pressed||input.up_pressed {
            _menued=(_menued+4+input.down_pressed-input.up_pressed)%4;
            audio_play_sound(snd_menu_switch,50,false)
        } else if input.menu_pressed {
            switch(_menued){
                case 0:
                     gj_logout()
					instance_destroy(obj_gjmenu)
					if (room == rm_gj_menu){
						room_goto(rm_menu)	
					}
                break;
                case 1:
                    _state = "trophies_hub"
                    // Reset scroll when entering trophy view
                    global.trophy_scroll_y = 0;
                    global.trophy_scroll_velocity = 0;
                break;
            }
        } else if input.cancel_pressed {
			cancel_pressed = true;	
			instance_destroy(obj_gjmenu)
		}
    break;
    
    case "trophies_hub":
        draw_text_transformed(d_width/1.95,d_height/4*0.85,"TROPHIES" ,1.5/960*d_height,1.5/960*d_height,0)
        
        // Calculate progress percentage
        var _achieved = __areas[0].achieved_value;
        var _total = __areas[0].achieved_total;
        var _percentage = (_achieved / _total) * 100;
        
        // Draw progress bar
        var _bar_width = d_width * 0.8;
        var _bar_height = 25;
        var _bar_x = d_width/2 - _bar_width/2;
        var _bar_y = d_height/4*0.69 + 50;
        
        // Progress bar background
        draw_set_color(c_dkgray);
        draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false);
        
        // Progress bar fill
        draw_set_color(c_lime);
        draw_rectangle(_bar_x, _bar_y, _bar_x + (_bar_width * _percentage / 100), _bar_y + _bar_height, false);
        
        // Progress bar border
        draw_set_color(c_white);
        draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, true);
        
        // Progress text
        draw_set_color(c_white);
        draw_text_transformed(d_width/2, _bar_y + _bar_height + 15, 
            string_format(_achieved, 0, 0) + "/" + string_format(_total, 0, 0) + 
            " (" + string_format(_percentage, 1, 1) + "%)", 
            1.3/960*d_height, 1.3/960*d_height, 0);
        
        draw_set_color(_menued == 0 ? c_aqua : c_white)
        draw_text_transformed(d_width/2, _bar_y + _bar_height + 45, 
            string(__areas[0].name) + " - " + string_format(_percentage, 1, 1) + "% Complete", 
            1.6/960*d_height, 1.6/960*d_height, 0)
			
		  // Draw instructions
        draw_set_color(c_gray);
        draw_set_halign(fa_center);
        draw_text_transformed(d_width/2, d_height - 40, "Use UP/DOWN to change selection - Back X/SHIFT to go back", 1.0/960*d_height, 1.0/960*d_height, 0);
        
        if input.down_pressed||input.up_pressed {
            _menued=(_menued+2+input.down_pressed-input.up_pressed)%2;
            audio_play_sound(snd_menu_switch,50,false)
        } else if input.action_pressed {
            _state = "view_trophies";
            global.trophy_scroll_y = 0;
            global.trophy_scroll_velocity = 0;
        } else if input.cancel_pressed {
            _state = "gj_hub";
        }
    break;
    
    case "view_trophies":
        // Wider Scrollable area
		var _scroll_area_width = d_width * 0.8;  // 80% of screen width
		var _scroll_area_height = d_height * 0.6; // 60% of screen height
		var _scroll_area_x = (d_width - _scroll_area_width) / 2; // Center horizontally
		var _scroll_area_y = (d_height - _scroll_area_height)/2; // Center vertically
        
        var _scissor = gpu_get_scissor();
        gpu_set_scissor(_scroll_area_x, _scroll_area_y, _scroll_area_width*4, _scroll_area_height*3);
        
        // Calculate scroll limits
        var _trophy_count = array_length(global.gj_trophies[_menued]);
        var _trophy_height = 100;
        var _total_content_height = _trophy_count * _trophy_height;
        global.trophy_scroll_max = max(0, _total_content_height - _scroll_area_height);
        
        // Scrolling physics
        var _scroll_speed = 8;
        var _friction = 0.9;
        
        // Handle scrolling input
        if (input.down) {
            global.trophy_scroll_velocity += _scroll_speed;
        }
        if (input.up) {
            global.trophy_scroll_velocity -= _scroll_speed;
        }
        
        // Mouse wheel scrolling
            var _mouse_wheel = mouse_wheel_up() - mouse_wheel_down();
            if (_mouse_wheel != 0) {
                global.trophy_scroll_velocity -= _mouse_wheel * 30;
                audio_play_sound(snd_menu_switch, 20, false);
            }
        
        // Apply scrolling physics
        global.trophy_scroll_y += global.trophy_scroll_velocity;
        global.trophy_scroll_velocity *= _friction;
        
        // Apply bounds with elastic edges
        if (global.trophy_scroll_y < 0) {
            global.trophy_scroll_y -= global.trophy_scroll_y * 0.5;
            global.trophy_scroll_velocity *= 0.8;
        } else if (global.trophy_scroll_y > global.trophy_scroll_max) {
            var _overshoot = global.trophy_scroll_y - global.trophy_scroll_max;
            global.trophy_scroll_y -= _overshoot * 0.5;
            global.trophy_scroll_velocity *= 0.8;
        }
        
        // Clamp final position
        global.trophy_scroll_y = clamp(global.trophy_scroll_y, 0, global.trophy_scroll_max);
        
        // Draw trophy list with smooth scrolling
        for (var i = 0; i < _trophy_count-1; i++) {
            var _y_pos = _scroll_area_y + (i * _trophy_height) - global.trophy_scroll_y;
            var _trophy = global.gj_trophies[_menued][i];
            
            // Only draw if within visible area
            if (_y_pos + _trophy_height > _scroll_area_y - 60 && _y_pos < _scroll_area_y + _scroll_area_height + 50) {
                
                // Get trophy tier color and label
                var _tier_color = c_white;
                var _tier_label = "";
                switch(_trophy.tier) {
                    case "bronze":
                        _tier_color = make_color_rgb(205, 127, 50); // Bronze color
                        _tier_label = "BRONZE";
                        break;
                    case "silver":
                        _tier_color = make_color_rgb(192, 192, 192); // Silver color
                        _tier_label = "SILVER";
                        break;
                    case "gold":
                        _tier_color = make_color_rgb(255, 215, 0); // Gold color
                        _tier_label = "GOLD";
                        break;
                    case "platinum":
                        _tier_color = make_color_rgb(229, 228, 226); // Platinum color
                        _tier_label = "PLATINUM";
                        break;
                    default:
                        _tier_color = c_white;
                        _tier_label = "STANDARD";
                }
                
                // Trophy background
                var _bg_color = (i mod 2 == 0) ? make_color_rgb(40, 40, 40) : make_color_rgb(30, 30, 30);
                if (_trophy.unlocked) {
                    _bg_color = (i mod 2 == 0) ? make_color_rgb(60, 40, 80) : make_color_rgb(50, 30, 70);
                }
                
				var _entry_padding = 20; // Padding on left/right sides
				var _content_width = _scroll_area_width - (_entry_padding * 2);
				var _content_x = _scroll_area_x + _entry_padding;

                draw_set_color(_bg_color);
            draw_rectangle(_content_x, _y_pos, _content_x + _content_width, _y_pos + _trophy_height, false);
                
                // Trophy border with tier color if unlocked
                if (_trophy.unlocked) {
                    draw_set_color(_tier_color);
                } else {
                    draw_set_color(c_gray);
                }
                draw_rectangle(_content_x, _y_pos, _content_x + _content_width, _y_pos + _trophy_height, true);
                
                // Trophy icon - ALWAYS use spr_trophy_locked when locked, custom icon when unlocked
                var _trophy_sprite = _trophy.unlocked ? _trophy.icon : spr_trophy_locked;
                // Fallback to default trophy sprites if custom icon doesn't exist
                if (!sprite_exists(_trophy_sprite)) {
                    if (_trophy.unlocked) {
                        // Fallback to tier-specific default sprites
                        switch(_trophy.tier) {
                            case "bronze": _trophy_sprite = spr_trophy_bronze; break;
                            case "silver": _trophy_sprite = spr_trophy_silver; break;
                            case "gold": _trophy_sprite = spr_trophy_gold; break;
                            case "platinum": _trophy_sprite = spr_trophy_platinum; break;
                            default: _trophy_sprite = spr_trophy_unlocked;
                        }
                    } else {
                        _trophy_sprite = spr_trophy_locked;
                    }
                }
                
                var _icon_color = _trophy.unlocked ? c_white : make_color_rgb(150, 150, 150);
                
                var _icon_x = _scroll_area_x + 80;
                var _icon_y = _y_pos + _trophy_height /3 ;
                
                draw_sprite_ext(_trophy_sprite, 0, _icon_x, _icon_y-6, 1.8, 1.8, 0, _icon_color, 1);
                
                // Trophy name and info
                draw_set_halign(fa_left);
                
                // Trophy name with tier color if unlocked
                if (_trophy.unlocked) {
                    draw_set_color(_tier_color);
                } else {
                    draw_set_color(c_white);
                }
                draw_set_font(loc_get_font(fnt_main));
                draw_text_transformed(_scroll_area_x + 160, _y_pos + 20, _trophy.name, 1.4/960*d_height, 1.4/960*d_height, 0);
                
                // Trophy tier badge
                if (_trophy.unlocked) {
                    draw_set_color(_tier_color);
                    draw_set_halign(fa_left);
                    draw_text_transformed(_scroll_area_x + 160, _y_pos + 45, "* " + _tier_label + " *", 1.0/960*d_height, 1.0/960*d_height, 0);
                }
                
                // Trophy description
                draw_set_color(_trophy.unlocked ? c_white : c_gray);
                draw_set_font(loc_get_font(fnt_main_small));
                var _desc_text = _trophy.unlocked ? _trophy.description : "Unlock to see description";
                draw_text_transformed(_scroll_area_x + 160, _y_pos + 65, _desc_text, 1.1/960*d_height, 1.1/960*d_height, 0);
                
                // Difficulty indicator
                if (!_trophy.unlocked) {
                    draw_set_color(c_gray);
                    var _difficulty = "";
                    switch(_trophy.tier) {
                        case "bronze": _difficulty = "Easy"; break;
                        case "silver": _difficulty = "Medium"; break;
                        case "gold": _difficulty = "Hard"; break;
                        case "platinum": _difficulty = "Very Hard"; break;
                        default: _difficulty = "Standard";
                    }
                    draw_text_transformed(_scroll_area_x + 160, _y_pos + 85, "Difficulty: " + _difficulty, 0.9/960*d_height, 0.9/960*d_height, 0);
                }
                
                // Trophy status (right side)
                draw_set_halign(fa_right);
                if (_trophy.unlocked) {
                    draw_set_color(_tier_color);
                    draw_text_transformed(_scroll_area_x + _scroll_area_width - 30, _y_pos + 30, "* UNLOCKED *", 1.5/960*d_height, 1.5/960*d_height, 0);
                    if (_trophy.unlock_date != undefined) {
                        draw_set_color(c_lime);
                        draw_text_transformed(_scroll_area_x + _scroll_area_width - 30, _y_pos + 55, _trophy.unlock_date, 0.9/960*d_height, 0.9/960*d_height, 0);
                    }
                } else {
                    draw_set_color(c_red);
                    draw_text_transformed(_scroll_area_x + _scroll_area_width - 40, _y_pos + 40, "LOCKED", 1.5/960*d_height, 1.5/960*d_height, 0);
                }
                
                draw_set_halign(fa_center);
                draw_set_font(loc_get_font(fnt_main));
            }
        }
        gpu_set_scissor(_scissor);
        
        // Draw instructions
        draw_set_color(c_gray);
        draw_set_halign(fa_center);
        draw_text_transformed(d_width/2, d_height - 40, "Use UP/DOWN to scroll - Back X/SHIFT to go back", 1.0/960*d_height, 1.0/960*d_height, 0);
        
        if input.cancel_pressed {
            _state = "trophies_hub";
        }
    break;
}