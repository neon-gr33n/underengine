if(live_call()) return live_result;

draw_set_alpha(image_alpha)
draw_set_color(c_white)
_alpha = (image_alpha/0.8*1)
draw_set_halign(fa_center)
draw_set_font(loc_get_font(fnt_main))

draw_rectangle_color(0,0,640,480,c_black,c_black,c_black,c_black,false)
draw_rectangle_color(0,0,GAME_RES.w,GAME_RES.h/6,c_black,c_black,c_black,c_black,false)	
if _menu != 999 && _menu != 2.21 {
	draw_text_transformed(GAME_RES.w/2*1.5,12,loc_gettext("ui.pause.time")+": "+(hours>0 ? string(hours)+":" : "")+(minutes%60<10 ? "0" : "")+string(minutes%60)+":"+(seconds%60<10 ? "0" : "")+string(seconds%60),1,1,0)
	if room != rm_settings {  draw_text_transformed(GAME_RES.w/2*1.5,40,get_current_room_name(),1,1,0) }
}
draw_sprite_ext(spr_px,0,0,80,GAME_RES.w,4,0,c_white,_alpha)

switch _menu {
    case 0:
        if input.action_pressed {
            switch(_menued){
				case 0:
                    if (room != rm_settings) { 
                        _menu = 1
                    } else { 
                        instance_activate_all()
					   audio_stop_all()
					   room_goto(rm_menu)
					   instance_destroy()
                    }

					break;
				case 1:
					instance_activate_all()
					audio_stop_all()
					room_goto(rm_menu)
					instance_destroy()
					break;
				case 2:
					_menu = 2
					break;
				case 3:
					_menu = 2.2;
                    _menued = 0;
					keys = [["up",0],["left",0],["right",0],["down",0],["action",0],["cancel",0],["menu",0],["pause",0]]
					break;
				case 4:
					_menu = 2.6
					_menued = 0;
					break;
				case 5:
					game_end()
					break;
			}
			_menued = 0
            audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
		} else if input.down_pressed||input.up_pressed {
            _menued = (_menued+6+input.down_pressed-input.up_pressed)%6;
			audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
        } else if input.cancel_pressed {
			_menu = 1
		}
		#region Draw Menu Text
        if room != rm_settings {
            draw_text_transformed(GAME_RES.w/5,30/2,loc_gettext("ui.pause"),1.5,1.5,0)
        } else {
            draw_text_transformed(GAME_RES.w/5,30/2,loc_gettext("ui.config.title"),1.5,1.5,0)
        }
        

        draw_set_color(_menued == 0 ? c_yellow : c_white)
		if image_alpha >= 0.7
			outline_set_text();
        draw_text_transformed(GAME_RES.w/4,GAME_RES.h/4*1,loc_gettext("ui.pause.return"),1,1,0)
		outline_end()
			
        draw_set_color(_menued == 1 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1.3,loc_gettext("ui.pause.menu"),1,1,0)
		outline_end()

        draw_set_color(_menued == 2 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/6,GAME_RES.h/4*1.6,loc_gettext("ui.title.settings"),1,1,0) // Using ui.config.title instead of ui.pause.config
		outline_end()
		
		draw_set_color(_menued == 3 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5.3,GAME_RES.h/4*1.9,loc_gettext("ui.config.controls"),1,1,0) // Using ui.config.controls instead of ui.pause.controls
		outline_end()
		
		draw_set_color(_menued == 4 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5.95,GAME_RES.h/4*2.2,loc_gettext("ui.extras"),1,1,0) // Using ui.extras instead of ui.pause.extras
		outline_end()
		

        draw_set_color(_menued == 5 ? c_yellow : c_white)
		if image_alpha >= 0.7  
			outline_set_text();
        draw_text_transformed(GAME_RES.w/4.65,GAME_RES.h/4*2.5,loc_gettext("ui.pause.end"),1,1,0)
		outline_end()
		
		draw_set_color(c_grey)
		if image_alpha >= 0.7  
			outline_set_text();
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*3.5,_menudesc[0],1,1,0)
		outline_end()
		#endregion
        break;

    case 1:
        //Resume
		instance_activate_all()
		audio_stop_sound(mus_menu)
		audio_resume_all()
		instance_destroy()
        break;

	#region SETTINGS HUB
    case 2:
        //Settings
		#region Draw Menu Text
        draw_text_transformed(GAME_RES.w/5,30/2,loc_gettext("ui.config.title"),3/2,3/2,0)

		
		draw_set_color(_menued == 0 ? c_yellow : c_white)
		if image_alpha >= 0.7
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1,loc_gettext("ui.config.audio"),1,1,0)
		outline_end()
			
        draw_set_color(_menued == 1 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1.3,loc_gettext("ui.config.graphics"),1,1,0)
		outline_end()

        draw_set_color(_menued == 2 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1.6,loc_gettext("ui.config.accessibility"),1,1,0)
		outline_end()
		
		draw_set_color(_menued == 3 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1.93,loc_gettext("ui.config.controls"),1,1,0)
		outline_end()
		
		draw_set_color(_menued == 4 ? c_yellow : c_white)
		if image_alpha >= 0.7 
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*2.25,loc_gettext("ui.config.gameplay"),1,1,0)
		outline_end()
		
		draw_set_color(_menued == 5 ? c_yellow : c_white)
		if image_alpha >= 0.7  
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*2.6,loc_gettext("ui.extras"),1,1,0)
		outline_end()
		
		draw_set_color(_menued == 6 ? c_yellow : c_white)
		if image_alpha >= 0.7  
			outline_set_text();
        draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*3,loc_gettext("choice.back"),1,1,0)
		outline_end()
		
		
		draw_set_color(c_grey)
		if image_alpha >= 0.7  
			outline_set_text();
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*3.5,_menudesc[0],1,1,0)
		outline_end()
		#endregion
		#region Process Input
		if input.action_pressed {
            switch _menued {
				case 0:
					//Volume menu
                    _menu = 2.1;
                    _menued = 0;
					break;
				case 1:
					// Graphics menu
					_menu = 2.3;
                    _menued = 0;
					break;
				case 2:
					// Accessibility menu
					_menu = 2.4;
                    _menued = 0;
					break;
				case 3:
					//Keybinds
                    _menu = 2.2;
                    _menued = 0;
					keys = [["up",0],["left",0],["right",0],["down",0],["action",0],["cancel",0],["menu",0],["pause",0]]
					break;
				case 4:
				   _menu = 2.5;
                    _menued = 0;
					break;
				case 5:
					//Extras 
					_menu = 2.6
					_menued = 0;
                case 6:
                    _menu = 0;
			        _menued = 0;
                    break;
			}
            audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
		} else if input.down_pressed||input.up_pressed {
            _menued = (_menued+7+input.down_pressed-input.up_pressed)%7;
			audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
        } else if input.cancel_pressed {
			_menu = 0
		}
		#endregion
        break;
		#endregion
		
	#region VOLUME MENU
    case 2.1:
        //Volume menu
		#region Draw Menu Text
draw_text_transformed(GAME_RES.w/5,30/2,string_upper(loc_gettext("ui.config.audio")),3/2,3/2,0)

draw_set_color(_menued == 0 ? c_yellow : c_white)
draw_text_transformed(GAME_RES.w/2,GAME_RES.h/3*1,loc_gettext("ui.config.audio.master_vol")+": "+string(round(global.master_volume * 100))+"%",1,1,0)

draw_set_color(_menued == 1 ? c_yellow : c_white)
draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2,loc_gettext("ui.config.audio.bgm_vol")+": "+string(round(global.mus_volume * 100))+"%",1,1,0)

// note: this is intentional, voice volume should be able to be adjusted seperate from SFX
// also, honestly same should go with ambient sounds
draw_set_color(_menued == 2 ? c_yellow : c_white)
draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.4,loc_gettext("ui.config.audio.v_vol")+": "+string(round(global.voice_volume * 100))+"%",1,1,0)

draw_set_color(_menued == 3 ? c_yellow : c_white)
draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.8,loc_gettext("ui.config.audio.se_vol")+": "+string(round(global.sfx_volume * 100))+"%",1,1,0)

draw_set_color(_menued == 4 ? c_yellow : c_white)
draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*3.5,loc_gettext("choice.back"),1,1,0)
#endregion

#region Process Input
if input.action_pressed {
    switch _menued {
        case 4:
            _menu = 2;
            _menued = 0;
            break;
    }
    audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
} else if input.down_pressed||input.up_pressed {
    _menued = (_menued+5+input.down_pressed-input.up_pressed)%5;
    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
} else if input.left_pressed {
    switch _menued {
        case 0:
            if global.master_volume > 0 {
                global.master_volume = max(0, global.master_volume - 0.1);
                audio_play_sound(snd_dogsalad,50,false,global.master_volume,0,random_range(1,1.5))
                master_adjust_vol()
            }
            break;        
        case 1:
            if global.mus_volume > 0 {
                global.mus_volume = max(0, global.mus_volume - 0.1);
                audio_play_sound(snd_dogsalad,50,false,global.mus_volume,0,random_range(1,1.5))
            }
            break;
        case 2:
            if global.voice_volume > 0 {
                global.voice_volume = max(0, global.voice_volume - 0.1);
                audio_play_sound(snd_sans_v,50,false,global.voice_volume,0,random_range(1,1.5))
            }
            break;
        case 3:
            if global.sfx_volume > 0 {
                global.sfx_volume = max(0, global.sfx_volume - 0.1);
                audio_play_sound(snd_dogsalad,50,false,global.sfx_volume,0,random_range(1,1.5))
            }
            break;
    }
} else if input.right_pressed {
    switch _menued {
        case 0:
            if global.master_volume < 1 {
                global.master_volume = min(1, global.master_volume + 0.1);
                master_adjust_vol()
                audio_play_sound(snd_dogsalad,50,false,global.master_volume,0,random_range(1,1.5))
            }
            break;                
        case 1:
            if global.mus_volume < 1 {
                global.mus_volume = min(1, global.mus_volume + 0.1);
                audio_play_sound(snd_dogsalad,50,false,global.mus_volume,0,random_range(1,1.5))
            }
            break;
        case 2:
            if global.voice_volume < 1 {
                global.voice_volume = min(1, global.voice_volume + 0.1);
                audio_play_sound(snd_sans_v,50,false,global.voice_volume,0,random_range(1,1.5))
            }
            break;
        case 3:
            if global.sfx_volume < 1 {
                global.sfx_volume = min(1, global.sfx_volume + 0.1);
                audio_play_sound(snd_dogsalad,50,false,global.sfx_volume,0,random_range(1,1.5))
            }
            break;
    }
} else if input.cancel_pressed {
    _menu = 2
}
#endregion
        break;
		
	#endregion
	
	#region CONTROLS MENU
case 2.2:
    // Check if we should show desktop controls (gamepad connected on mobile) or mobile touch controls
    var show_desktop_controls = (os_type != os_android) || (os_type == os_android && global.input_device == "gamepad");
    
    if (!show_desktop_controls) {
        // MOBILE TOUCHSCREEN CONTROLS SETTINGS (only when no gamepad connected)
        #region Draw Mobile Controls Menu Text
        draw_text_transformed(GAME_RES.w/5,30/2,string_upper(loc_gettext("ui.config.controls")),3/2,3/2,0)
        
        draw_set_color(_menued == 0 ? c_yellow : c_white)
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*1,loc_gettext("ui.config.controls.touch_opacity")+": " + string(round(global.touch_opacity * 100)) + "%",1,1,0)
		
		 draw_set_color(_menued == 1 ? c_yellow : c_white)
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*1.5,loc_gettext("ui.config.controls.touch_scale")+": " + string(global.touch_scale) + "x",1,1,0)
		
		 draw_set_color(_menued == 2 ? c_yellow : c_white)
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*2,loc_gettext("ui.config.controls.touch_layout"),1,1,0)
        
        draw_set_color(_menued == 3 ? c_yellow : c_white)
        draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*5,loc_gettext("choice.back"),1,1,0)
        #endregion
        
        #region Process Mobile Controls Input
        if input.action_pressed {
            switch _menued {
				case 2:
					_menu = 2.21;
					_menued = 0;
					break;
                case 3:
                    _menu = 2;
                    _menued = 0;
                    break;
            }
            audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
        } else if input.down_pressed||input.up_pressed {
            _menued = (_menued+4+input.down_pressed-input.up_pressed)%4;
            audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
        } else if input.left_pressed && _menued == 0 {
            if global.touch_opacity > 0.1 {
                global.touch_opacity = max(0.1, global.touch_opacity - 0.1);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
            }
        } else if input.right_pressed && _menued == 0 {
            if global.touch_opacity < 1.0 {
                global.touch_opacity = min(1.0, global.touch_opacity + 0.1);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
            }
		} else if input.left_pressed && _menued == 1 {
            if global.touch_scale > 1.0 {
                global.touch_scale = max(1.0, global.touch_scale - 0.1);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
            }
        } else if input.right_pressed && _menued == 1 {
            if global.touch_scale < 3 {
                global.touch_scale = min(3, global.touch_scale + 0.1);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
            }
        } else if input.cancel_pressed {
            _menu = 2
        }
        #endregion
    } else {
        // DESKTOP KEYBINDS / GAMEPAD REBINDING (shown on desktop OR mobile with gamepad connected)
        #region Draw Menu Text
        draw_text_transformed(GAME_RES.w/5,30/2,string_upper(loc_gettext("ui.config.controls")),3/2,3/2,0)
        
        draw_set_halign(fa_left)
        
        draw_set_color(c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*2,loc_gettext("ui.config.controls.action")+":",1.5,1.5,0) // Using ui.config.controls.action
        
        draw_set_color(floor(_menued) == 0 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*3,loc_gettext("ui.config.controls.up")+":",1,1,0) // Using ui.config.controls.up
        
        draw_set_color(floor(_menued) == 1 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*4,loc_gettext("ui.config.controls.left")+":",1,1,0) // Using ui.config.controls.left
        
        draw_set_color(floor(_menued) == 2 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*5,loc_gettext("ui.config.controls.right")+":",1,1,0) // Using ui.config.controls.right
        
        draw_set_color(floor(_menued) == 3 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*6,loc_gettext("ui.config.controls.down")+":",1,1,0) // Using ui.config.controls.down

        draw_set_color(floor(_menued) == 4 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*7,loc_gettext("ui.config.controls.interact")+":",1,1,0) // Using ui.config.controls.interact

        draw_set_color(floor(_menued) == 5 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*8,loc_gettext("ui.config.controls.cancel")+":",1,1,0) // Using ui.config.controls.cancel
        
        draw_set_color(floor(_menued) == 6 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*9,loc_gettext("ui.config.controls.menu")+":",1,1,0) // Using ui.config.controls.menu
        
        draw_set_color(floor(_menued) == 7 ? c_aqua : c_white)
        draw_text_transformed(4/2,GAME_RES.h/11*10,loc_gettext("ui.config.controls.pause")+":",1,1,0) // Using ui.config.controls.pause
        
        
        draw_set_halign(fa_center)
        draw_set_color(c_white)
        
        // Show different header based on input device
        var header_text = "";
        if (os_type == os_android && global.input_device == "gamepad") {
            header_text = loc_gettext("ui.config.controls.gamepad_binding");
        } else {
            header_text = _menued%1 == 0 ? loc_gettext("ui.config.controls.binding")+":" : loc_gettext("ui.config.controls.alt")+":";
        }
        draw_text_transformed(GAME_RES.w/1.5,GAME_RES.h/11*2,header_text,1.5,1.5,0)
        
        for (i = 0;i<8;i++) {
            draw_set_color((floor(_menued) == i) ? c_aqua : c_white)
            var _controller_connected = input_gamepad_is_connected(0)
            var _binding_set = _menued % 1 * 2

            if (!_controller_connected || global.input_device == "keyboard") {
                // Keyboard/Mouse display
                draw_text_transformed(
                    GAME_RES.w/1.5, 
                    GAME_RES.h/11*(i+3),
                    (keys[i][1] != 1 ? string(input_binding_get(keys[i][0], 0, _binding_set)) : "?"),
                    1, 1, 0
                )
            } else if global.input_device == "gamepad" {
                // Gamepad display - ensure we're getting gamepad bindings
                var _binding = input_binding_get(keys[i][0], 0, _binding_set) // Use player 1 for gamepad
                if (_binding != -1) {
                    var _string = sprite_get_name(input_binding_get_icon(_binding))
                    scribble("[" + _string + "]").draw(GAME_RES.w/1.5, GAME_RES.h/11*(i+3))
                } else {
                    // Fallback if no gamepad binding found
                    draw_text_transformed(GAME_RES.w/1.5, GAME_RES.h/11*(i+3), "?", 1, 1, 0)
                }
            }
        }
        #endregion
        #region Process Input
        if _menued%0.5 == 0.25 {
            input_binding_scan_start(function(_binding)
            { 
                //On success, set a binding and show positive feedback
                if !((string_length(_binding) == 2||string_length(_binding) == 3)&&(string_char_at(_binding,1) == "f")) {
                    input_binding_set_safe(keys[floor(_menued)][0], _binding,0,(_menued%1 == 0.35||_menued%0.5 == 0.25 ? 0 : 1));
                    _menued -= _menued%0.5
                    keys[floor(_menued)][1] = 0
                } else
                    _menued -= _menued%0.25
            })
            _menued += 0.1
        } else {
            if input.action_pressed {
                switch _menued {
                    case 8:
                    case 8.5:
                        _menu = 2;
                        _menued = 0;
                        break;
                    default:
                        _menued += 0.25
                        keys[floor(_menued)][1] = ((_menued%0.5)+0.25)*2
                        break;
                }
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
            } else if input.down_pressed||input.up_pressed {
                _menued = (_menued+8+input.down_pressed-input.up_pressed)%8;
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
            } else if input.left_pressed||input.right_pressed {
                _menued += (frac(_menued) == 0 ? 0.5 : -0.5);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
            } else if input.cancel_pressed {
                _menu = 2
            }
        }
        #endregion
    }
    break;
case 2.21:
    // Touch Controls Layout Editor
    
    #region Draw Layout Editor
    draw_text_transformed(GAME_RES.w/2,8,string_upper(loc_gettext("ui.config.controls.touch_layout")),2,2,0)
    
    // Instructions
    draw_set_color(c_grey)
    outline_set_text()
    draw_text_transformed(GAME_RES.w/2,85,loc_gettext("ui.config.controls.layout_instructions"),1,1,0)
    outline_end()
    
    // Draw all buttons
    for (var i = 0; i < array_length(global.touch_button_positions); i++) {
        var btn = global.touch_button_positions[i];
        var _x = btn[0];
        var _y = btn[1];
        var width = btn[2];
        var height = btn[3];
        var type = btn[4];
        var label = btn[5];
        
        // Highlight selected button
        if (obj_mobile_ui.selected_button == i) {
            draw_set_color(c_yellow);
            draw_rectangle(_x - 5, _y - 5, _x + width + 5, _y + height + 5, false);
        } else {
            draw_set_color(c_white);
        }
        
        // Draw button with appropriate sprite
        switch(type) {
            case 0: // Joystick
                draw_sprite_ext(spr_touch_bg, 0, _x + width/2, _y + height/2, global.touch_scale, global.touch_scale, 0, c_gray, global.touch_opacity);
                break;
            case 1: // Action (Z)
                obj_mobile_ui.button_dragging = 1;
                draw_sprite_ext(spr_button_z, 0, _x + width/2, _y + height/2, global.touch_scale, global.touch_scale, 0, c_white, global.touch_opacity);
                break;
            case 2: // Cancel (X)
                obj_mobile_ui.button_dragging = 2;
                draw_sprite_ext(spr_button_x, 0, _x + width/2, _y + height/2, global.touch_scale, global.touch_scale, 0, c_white, global.touch_opacity);
                break;
            case 3: // Menu (C)
                obj_mobile_ui.button_dragging = 3;
                draw_sprite_ext(spr_button_c, 0, _x + width/2, _y + height/2, global.touch_scale, global.touch_scale, 0, c_white, global.touch_opacity);
                break;
            case 4: // Pause
                obj_mobile_ui.button_dragging = 4;
                draw_sprite_ext(spr_button_pause, 0, _x + width/2, _y + height/2, global.touch_scale, global.touch_scale, 0, c_white, global.touch_opacity);
                break;
        }
    }
    
    // Menu options
    var option_y = GAME_RES.h - 100;
    var option_height = 40;
    var save_x = GAME_RES.w/5;
    var reset_x = GAME_RES.w/2;
    var back_x = GAME_RES.w/1.2;
    var option_width = 200;
	
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
    
    // Draw menu options with highlighting if mouse is over them
    var mouse_over_save = (_mx >= save_x - option_width/2 && _mx <= save_x + option_width/2 && _my >= option_y - option_height/2 && _my <= option_y + option_height/2);
    var mouse_over_reset = (_mx >= reset_x - option_width/2 && _mx <= reset_x + option_width/2 && _my >= option_y - option_height/2 && _my <= option_y + option_height/2);
    
    draw_set_color(mouse_over_save ? c_yellow : c_white);
    draw_text_transformed(save_x, option_y, loc_gettext("ui.config.controls.save_layout"), 1, 1, 0);
    
    draw_set_color(mouse_over_reset ? c_yellow : c_white);
    draw_text_transformed(reset_x, option_y, loc_gettext("ui.config.controls.reset_layout"), 1, 1, 0);
    
    #endregion
    
    #region Process Input
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Handle touch/mouse clicking
    if (device_mouse_check_button_pressed(0, mb_left) || (os_type == os_android && mouse_check_button_pressed(mb_left))) {
        // Check if clicked on a button for dragging
        for (var i = 0; i < array_length(global.touch_button_positions); i++) {
            var btn = global.touch_button_positions[i];
            var _x = btn[0];
            var _y = btn[1];
            var width = btn[2];
            var height = btn[3];
            
            if (_mx >= _x && _mx <= _x + width && _my >= _y && _my <= _y + height) {
                obj_mobile_ui.selected_button = i;
                obj_mobile_ui.button_drag_offset_x = _mx - _x;
                obj_mobile_ui.button_drag_offset_y = _my - _y;
                audio_play_sound(snd_menu_select, 50, false, global.sfx_volume);
                break;
            }
        }
        
        // Check if clicked on menu options (only if not dragging a button)
        if (obj_mobile_ui.selected_button == -1) {
            // Save Layout clicked
            if (_mx >= save_x - option_width/2 && _mx <= save_x + option_width/2 && 
                _my >= option_y - option_height/2 && _my <= option_y + option_height/2) {
                save_touch_layout();
                // Re-enable virtual inputs before leaving
                _menu = 2.2;
                _menued = 2;
                audio_play_sound(snd_menu_select, 50, false, global.sfx_volume);
            }
            // Reset Layout clicked
            else if (_mx >= reset_x - option_width/2 && _mx <= reset_x + option_width/2 && 
                     _my >= option_y - option_height/2 && _my <= option_y + option_height/2) {
                global.touch_button_positions = get_default_touch_positions();
                audio_play_sound(snd_menu_select, 50, false, global.sfx_volume);
            }
        }
    }
    
    // Handle button dragging
    if (obj_mobile_ui.selected_button != -1 && (device_mouse_check_button(0, mb_left) || (os_type == os_android && mouse_check_button(mb_left)))) {
        var btn = global.touch_button_positions[obj_mobile_ui.selected_button];
        var new_x = _mx - obj_mobile_ui.button_drag_offset_x;
        var new_y = _my - obj_mobile_ui.button_drag_offset_y;

        // Keep within screen bounds
        new_x = clamp(new_x, 0, display_get_gui_width() - btn[2]);
        new_y = clamp(new_y, 0, display_get_gui_height() - btn[3]);

        // Update position
        global.touch_button_positions[obj_mobile_ui.selected_button][0] = new_x;
        global.touch_button_positions[obj_mobile_ui.selected_button][1] = new_y;

        // Get button type and clear button mapping if type > 0
        var btn_type = btn[4];
        if (btn_type > 0) {
            // Clear the button mapping for the corresponding button type
            switch (btn_type) {
                case 1: // Action (Z)
                    if (variable_instance_exists(id, "ui_btn_action") && ui_btn_action != noone) {
                        ui_btn_action.button(""); // Clear the button mapping
                    }
                    break;
            
                case 2: // Cancel (X)
                    if (variable_instance_exists(id, "ui_btn_cancel") && ui_btn_cancel != noone) {
                        ui_btn_cancel.button(""); // Clear the button mapping
                    }
                    break;
            
                case 3: // Menu (C)
                    if (variable_instance_exists(id, "ui_btn_menu") && ui_btn_menu != noone) {
                        ui_btn_menu.button(""); // Clear the button mapping
                    }
                    break;
            
                case 4: // Pause
                    if (variable_instance_exists(id, "ui_btn_pause") && ui_btn_pause != noone) {
                        ui_btn_pause.button(""); // Clear the button mapping
                    }
                    break;
            }
        }
    }
    
    // Release button
    if (device_mouse_check_button_released(0, mb_left) || (os_type == os_android && mouse_check_button_released(mb_left))) {
        if (obj_mobile_ui.selected_button != -1) {
            var btn = global.touch_button_positions[obj_mobile_ui.selected_button];
            var btn_type = btn[4];
            if (btn_type > 0) {
                // Restore the button mapping for the corresponding button type
                switch (btn_type) {
                    case 1: // Action (Z)
                        if (variable_instance_exists(id, "ui_btn_action") && ui_btn_action != noone) {
                            ui_btn_action.button("action"); // Restore the mapping
                        }
                        break;
                
                    case 2: // Cancel (X)
                        if (variable_instance_exists(id, "ui_btn_cancel") && ui_btn_cancel != noone) {
                            ui_btn_cancel.button("cancel"); // Restore the mapping
                        }
                        break;
                
                    case 3: // Menu (C)
                        if (variable_instance_exists(id, "ui_btn_menu") && ui_btn_menu != noone) {
                            ui_btn_menu.button("menu"); // Restore the mapping
                        }
                        break;
                
                    case 4: // Pause
                        if (variable_instance_exists(id, "ui_btn_pause") && ui_btn_pause != noone) {
                            ui_btn_pause.button("pause"); // Restore the mapping
                        }
                        break;
                }
            }
        }
        obj_mobile_ui.selected_button = -1;
    }
	#endregion
    break;
#endregion
	
	#region GRAPHICS MENU
case 2.3:
    //Visuals/Graphics menu
    #region Draw Menu Text
    draw_text_transformed(GAME_RES.w/5,30/2,string_upper(loc_gettext("ui.config.graphics")),3/2,3/2,0)
    
    draw_set_color(_menued == 0 ? c_yellow : c_white)
    if image_alpha >= 0.7
        outline_set_text();
    draw_text_transformed(GAME_RES.w/5,GAME_RES.h/4*1,loc_gettext("ui.config.graphics.vsync")+": " +(global.vsync ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)
    outline_end()
    
    draw_set_color(_menued == 1 ? c_yellow : c_white)
    if image_alpha >= 0.7 
        outline_set_text();
    draw_text_transformed(GAME_RES.w/2.45,GAME_RES.h/4*1.3,loc_gettext("ui.config.graphics.maxfps")+": "+(game_get_speed(gamespeed_fps) == 60 ? "60" : "30"),1,1,0)
    outline_end()

    // Simplify VFX option - show on all platforms
    draw_set_color(_menued == 2 ? c_yellow : c_white)
    if image_alpha >= 0.7 
        outline_set_text();
    var simplify_text = loc_gettext("ui.config.graphics.simplify_vfx") + ": " + (global.simplify_vfx ? loc_gettext("choice.on") : loc_gettext("choice.off"));
    draw_text_transformed(GAME_RES.w/2.66,GAME_RES.h/4*1.6,simplify_text,1,1,0)
    outline_end()
    
    // Desktop-only options: resolution, display mode, aspect ratio
    if (os_type != os_android) {
        // Show resolution option on desktop
        draw_set_color(_menued == 3 ? c_yellow : c_white)
        if image_alpha >= 0.7 
            outline_set_text();
        var res_text = loc_gettext("ui.config.graphics.game_res")+": " + string(global._display_width)+"x"+string(global._display_height);
        draw_text_transformed(GAME_RES.w/2.66,GAME_RES.h/4*1.93,res_text,1,1,0)
        outline_end()
        
        // Display mode on desktop
        draw_set_color(_menued == 4 ? c_yellow : c_white)
        if image_alpha >= 0.7 
            outline_set_text();
        draw_text_transformed(GAME_RES.w/2.84,GAME_RES.h/4*2.26,loc_gettext("ui.config.graphics.dmode")+": " + _dmode[_dmodec] ,1,1,0)
        outline_end()
        
        // Aspect ratio option on desktop
        draw_set_color(_menued == 5 ? c_yellow : c_white)
        if image_alpha >= 0.7 
            outline_set_text();
        var ratio_text = "";
        if (global.asp_ratio == 0) {
            ratio_text = loc_gettext("ui.config.graphics.aspratio.square");
        } else {
            ratio_text = loc_gettext("ui.config.graphics.aspratio.widescreen");
        }
        var display_text = loc_gettext("ui.config.graphics.aspratio") + ": " + ratio_text;
        draw_text_transformed(GAME_RES.w/2.66,GAME_RES.h/4*2.6,display_text,1,1,0)
        outline_end()
        
        // Back option for desktop
        var back_option_index = 6;
        draw_set_color(_menued == back_option_index ? c_yellow : c_white)
        if image_alpha >= 0.7 
            outline_set_text();
        draw_text_transformed(GAME_RES.w/4,GAME_RES.h/4*3.2,loc_gettext("choice.back"),1,1,0)
        outline_end()
    } else {
        // Mobile (Android): Only show the 3 options + back
        var back_option_index = 3;
        draw_set_color(_menued == back_option_index ? c_yellow : c_white)
        if image_alpha >= 0.7 
            outline_set_text();
        draw_text_transformed(GAME_RES.w/4,GAME_RES.h/4*2.6,loc_gettext("choice.back"),1,1,0)
        outline_end()
    }
    
    draw_set_color(c_grey)
    if image_alpha >= 0.7  
        outline_set_text();
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/4*3.5,_menudesc[0],1,1,0)
    outline_end()
    #endregion
    #region Process Input
    // Calculate total menu items based on platform
    var total_menu_items = (os_type != os_android) ? 7 : 4; // 3 options + back on mobile
    
    if input.down_pressed||input.up_pressed {
        _menued = (_menued+total_menu_items+input.down_pressed-input.up_pressed)%total_menu_items;
        audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
    } else if input.action_pressed {
        switch(_menued){
            case 0:
                global.vsync = !global.vsync
                display_set_vsync_safe(global.vsync)
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
            break;
            case 2:
                // Simplify VFX option - works on all platforms
                global.simplify_vfx = !global.simplify_vfx;
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume);
            break;
            case (os_type != os_android ? 6 : 3): // Back option
                _menu = 2;
                _menued = 0;
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
            break;
        }
    } else if input.left_pressed||input.right_pressed {
        switch _menued {  
            case 1:
                game_set_speed((!(game_get_speed(gamespeed_fps) / 30 - 1) + 1) * 30, gamespeed_fps);
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                break;
            case 2:
                // Simplify VFX can also be toggled with left/right
                global.simplify_vfx = !global.simplify_vfx;
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                break;
            case 3:
                // Resolution change - desktop only
                if (os_type != os_android) {
                    var old_index = global.resolution_index;
                    
                    // Calculate new index with wrapping
                    if (input.right_pressed) {
                        global.resolution_index = (global.resolution_index + 1) % 15;
                    } else if (input.left_pressed) {
                        global.resolution_index = (global.resolution_index - 1 + 15) % 15;
                    }
                    
                    set_display_sizes();
                    with (obj_master_camera) set_resolution(global._display_width);
                    set_gui_size();
                    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                }
                break;
            case 4:
                // Display mode change - desktop only
                if (os_type != os_android) {
                    _dmodec = ((_dmodec+3-input.left_pressed+input.right_pressed))%3
                    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                }
                break;
            case 5:
                // Aspect ratio - desktop only
                if (os_type != os_android) {
                    if (input.right_pressed) {
                        _bmodec = 1;
                        global.asp_ratio = 1; // Widescreen
                        show_debug_message("Setting to WIDESCREEN (1)");
                    } else if (input.left_pressed) {
                        _bmodec = 2;
                        global.asp_ratio = 0; // Square
                        show_debug_message("Setting to SQUARE (0)");
                    }
                    show_debug_message("After: global.asp_ratio = " + string(global.asp_ratio));
                    set_display_sizes();
                    with (obj_master_camera) set_resolution(global._display_width);
                    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                }
                break;
        }
    } else if input.cancel_pressed {
        _menu = 2;
        audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
    }
    break;
    #endregion
#endregion
	
	#region ACCESSIBILITY MENU
	 case 2.4:
    // Accessibility menu
    #region Draw Menu Text
    draw_text_transformed(GAME_RES.w/4,30/2,string_upper(loc_gettext("ui.config.accessibility")),3/2,3/2,0)

    draw_set_color(_menued == 0 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/3*1,loc_gettext("ui.config.accessibility.onehand")+": " + (global.one_handed ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)
    
    draw_set_color(_menued == 1 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2,loc_gettext("ui.config.accessibility.epilepsy")+": " + (global.epilepsy_mode ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)
    
    draw_set_color(_menued == 2 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.4,loc_gettext("ui.config.accessibility.shake")+": " + (global.shake_screen ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)
    
    // Difficulty display with arrows
    draw_set_color(_menued == 3 ? c_yellow : c_white)
    var difficulty_label = game_get_difficulty_label();
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.8,loc_gettext("ui.config.accessibility.difficulty")+": " + difficulty_label,1,1,0)
    
    // Draw arrows for difficulty navigation
    if (_menued == 3) {
        draw_set_color(c_white);
        // Left arrow
        draw_text_transformed(GAME_RES.w/2 - 150, GAME_RES.h/5*2.8, "<", 1, 1, 0);
        // Right arrow  
        draw_text_transformed(GAME_RES.w/2 + 150, GAME_RES.h/5*2.8, ">", 1, 1, 0);
    }
    
    draw_set_color(_menued == 4 ? c_yellow : c_white)
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*3.2,loc_gettext("ui.config.gameplay.lang")+": " + current_lang.display_name,1,1,0)
    
    // Draw left/right arrows for language navigation
    if (_menued == 4) {
        // Left arrow
        draw_set_color(c_white);
        draw_text_transformed(GAME_RES.w/2 - 150, GAME_RES.h/5*3.2, "<", 1, 1, 0);
        
        // Right arrow  
        draw_text_transformed(GAME_RES.w/2 + 150, GAME_RES.h/5*3.2, ">", 1, 1, 0);
    }
    
    draw_set_color(_menued == 5 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*4,loc_gettext("choice.back"),1,1,0)
    #endregion
    
    #region Process Input
    if input.action_pressed {
        switch _menued {
            case 0:
                global.one_handed = !global.one_handed
                if global.one_handed {
                    input_profile_set(global.input_device == "gamepad" ? "onehand_gamepad" :"onehand_keyboard")    
                } else {
                    input_profile_set(global.input_device == "gamepad" ? "gamepad" : "keyboard_and_mouse")    
                }
                break;
            case 1:
                global.epilepsy_mode = !global.epilepsy_mode
                break;
            case 2:
                global.shake_screen = !global.shake_screen
                break;
            case 3:
                // Action press on difficulty - could show info or do nothing
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
                break;
            case 4:
                // Action press on language - could show info or do nothing
                audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
                break;
            case 5:
                _menu = 2;
                _menued = 0;
                break;
        }
    } else if input.down_pressed||input.up_pressed {
        _menued = (_menued+6+input.down_pressed-input.up_pressed)%6; // Now 6 items total
        audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
    } else if (input.left_pressed || input.right_pressed) && _menued == 3 {
        // One-liner modulo solution for difficulty cycling
        var dir = input.right_pressed - input.left_pressed; // -1 for left, 1 for right
        var diffs = ["EASY", "NORMAL", "HARD", "LUNATIC"];
        var current = 0;
        for (var i = 0; i < 4; i++) if (string_upper(diffs[i]) == string_upper(global.__difficulty_id)) current = i;
        game_set_difficulty(diffs[(current + dir + 4) % 4]);
        audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
        with (obj_parent_bullet) _damage = game_get_difficulty_damage(_base_damage);
        save_config();
    } else if (input.left_pressed || input.right_pressed) && _menued == 4 {
        // Language navigation
        if input.left_pressed {
            // Navigate to previous language
            var prev_lang = global.LANGUAGE_CONFIG.get_prev(global.lang);
            if (prev_lang != noone) {
                var lang_update_success = loc_update_language_only(prev_lang.id);
                if (lang_update_success) {
                    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                }
            }
        } else if input.right_pressed {
            // Navigate to next language
            var next_lang = global.LANGUAGE_CONFIG.get_next(global.lang);
            if (next_lang != noone) {
                var lang_update_success = loc_update_language_only(next_lang.id);
                if (lang_update_success) {
                    audio_play_sound(snd_menu_switch,50,false,global.sfx_volume);
                }
            }
        }
    } else if input.cancel_pressed {
        _menu = 2
    }
    break;
    #endregion
#endregion
	
	#region GAMEPLAY MENU
case 2.5:
    #region Draw Menu Text
    draw_text_transformed(GAME_RES.w/5,30/2,string_upper(loc_gettext("ui.config.gameplay")),3/2,3/2,0)

    draw_set_color(_menued == 0 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/3*1,loc_gettext("ui.config.gameplay.autorun")+": " + (global.auto_sprint ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)

    draw_set_color(_menued == 1 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2,loc_gettext("ui.config.gameplay.style")+": "+ (global.rounded_box ? loc_gettext("ui.config.gameplay.style.round") : loc_gettext("ui.config.gameplay.style.ut")),1,1,0)
    
    draw_set_color(_menued == 2 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.4,loc_gettext("ui.config.gameplay.cstyle")+": " + (global.camera_lerp ? loc_gettext("ui.config.gameplay.cstyle.smooth") : loc_gettext("ui.config.gameplay.cstyle.ut")),1,1,0)
    
    // Language option removed from here
    
    draw_set_color(_menued == 3 ? c_yellow : c_white) // Back button moved up
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*3.5,loc_gettext("choice.back"),1,1,0)

    #endregion
    #region Process Input
    if input.action_pressed {
        switch _menued {
            case 0:
                global.auto_sprint = !global.auto_sprint
                break;
            case 1:
                global.rounded_box = !global.rounded_box
                if global.rounded_box {
                    global.boxout = spr_textborder_outer_rounded;
                    global.boxin = spr_textborder_inner_rounded;
                } else {
                    global.boxout = spr_textborder_outer;
                    global.boxin = spr_textborder_inner;
                }
                break;
            case 2:
                global.camera_lerp = !global.camera_lerp
                break;
            case 3:
                _menu = 2;
                _menued = 0;
                break;
        }
        audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
    } else if input.down_pressed||input.up_pressed {
        _menued = (_menued+4+input.down_pressed-input.up_pressed)%4; // Now 4 items total
        audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
    } else if input.cancel_pressed {
        _menu = 2
    }
    break;
    #endregion
#endregion
	
	#region EXTRAS MENU
case 2.6:
    // Extras menu
    #region Draw Menu Text
    draw_text_transformed(GAME_RES.w/4,30/2,string_upper(loc_gettext("ui.extras")),3/2,3/2,0)

    draw_set_color(_menued == 0 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/3*1,loc_gettext("ui.extras.discord_rpc")+": " + (global.presence ? loc_gettext("choice.on") : loc_gettext("choice.off")),1,1,0)

    if global._border_type_index == 1 {
        draw_set_color(c_gray)    
    } else {
        draw_set_color(_menued == 1 ? c_yellow : c_white)    
    }

    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2,loc_gettext("ui.extras.border_sel")+": " + _basset[global._border_sel],1,1,0)
    
    draw_set_color(_menued == 2 ? c_yellow : c_white)
    
    // On Android, show a different message if borders are disabled
    if (os_type == os_android && _bmodec > 1) {
        _bmodec = 1; // Force it to max 1 on Android
    }
    
    var border_mode_text = loc_gettext("ui.extras.border_mode") + ": " + _bmode[_bmodec];
    
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.4,border_mode_text,1,1,0)
    
    // leave gamejolt login non functional for now, it's not needed rn
    draw_set_color(_menued == 3 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*2.8,(gj_user_logged_in() == true ? loc_gettext("ui.extras.gjview")+" ("+"@"+global.gj_username+")" : loc_gettext("ui.extras.gjlogin")),1,1,0)
    
    draw_set_color(_menued == 4 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*3.5,loc_gettext("ui.extras.resetsaved"),1,1,0)
    
    draw_set_color(_menued == 5 ? c_yellow : c_white)
    draw_text_transformed(GAME_RES.w/2,GAME_RES.h/5*4,loc_gettext("choice.back"),1,1,0)

    #endregion
    
    #region Process Input
    if input.action_pressed {
        switch _menued {
            case 0:
                global.presence = !global.presence
                break;
            case 3:
                sfx_play(snd_menu_select)
                if gj_user_logged_in() {
                    _menu = 999;
                    instance_create_depth(0,0,-99999,obj_gjmenu)    
                } else {
                    _menu = 999;
                    instance_create_depth(0,0,-99999,obj_gj_login)    
                }
                break;
            case 4:
                // todo: allow saved data, and settings to be cleared with this option
                if file_exists("file0") file_delete("file0");
                if file_exists("file1") file_delete("file1");
                if file_exists("PARTYINFO0") file_delete("PARTYINFO0");
                if file_exists("PARTYINFO1") file_delete("PARTYINFO1");
                if file_exists("settings.cfg") file_delete("settings.cfg");
                break;
            case 5:
                _menu = 0;
                _menued = 0;
                break;
        }
        audio_play_sound(snd_menu_select,50,false,global.sfx_volume)
    } else if input.down_pressed||input.up_pressed {
        _menued = (_menued+6+input.down_pressed-input.up_pressed)%6;
        audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
    } else if input.left_pressed {
        switch _menued {
            case 1:
                if _bassetc != 0 && global._border_type_index != 1 {
                    _bassetc = ((_bassetc-1))%3;
                }
                global._border_sel = _bassetc;
                if global._border_type_index != 1 {
                    CAM.border_alpha = 0;    
                }
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
                break;
            case 2:
                // Save the user's current aspect ratio BEFORE changing it
                var user_aspect_ratio = global.asp_ratio;
                
                // ANDROID LIMIT: Maximum value is 1
                var max_bmode = (os_type == os_android) ? 1 : 3;
                
                if _bmodec != 0 {
                    _bmodec = ((_bmodec-1 + max_bmode + 1)) % (max_bmode + 1);
                } else {
                    _bmodec = 0;    
                }
                
                if _bmodec == 1 {
                    CAM.border_alpha = 0;    
                }
                
                switch(_bmodec) {
                    case 0:
                    case 1:
                        // TEMPORARILY set to 1 for border calculations
                        global.asp_ratio = 1;
                        set_display_sizes();
                        with (obj_master_camera) set_resolution(global._display_width);
                        
                        // RESTORE the user's original choice
                        global.asp_ratio = user_aspect_ratio;
                        break;
                    default:
                        // For other border modes, just update normally
                        set_display_sizes();
                        with (obj_master_camera) set_resolution(global._display_width);
                        break;
                }
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
                break;    
        }
    } else if input.right_pressed {
        switch _menued {
            case 1:
                if _bassetc != 3 && global._border_type_index != 1 {
                    _bassetc = ((_bassetc+1))%3;
                }
                
                global._border_sel = _bassetc;
                if global._border_type_index != 1 {
                    CAM.border_alpha = 0;    
                }
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
                break;
            case 2:
                // Save the user's current aspect ratio BEFORE changing it
                var user_aspect_ratio = global.asp_ratio;
                
                // ANDROID LIMIT: Maximum value is 1
                var max_bmode = (os_type == os_android) ? 1 : 2;
                
                if _bmodec != max_bmode {
                    _bmodec = ((_bmodec+1)) % (max_bmode + 1);
                } else {
                    _bmodec = 0;    
                }
                
                if _bmodec == 1 {
                    CAM.border_alpha = 0;    
                }
                
                switch(_bmodec) {
                    case 0:
                    case 1:
                        // TEMPORARILY set to 1 for border calculations
                        global.asp_ratio = 1;
                        set_display_sizes();
                        with (obj_master_camera) set_resolution(global._display_width);
                        
                        // RESTORE the user's original choice
                        global.asp_ratio = user_aspect_ratio;
                        break;
                    default:
                        // For other border modes, just update normally
                        set_display_sizes();
                        with (obj_master_camera) set_resolution(global._display_width);
                        break;
                }
                audio_play_sound(snd_menu_switch,50,false,global.sfx_volume)
                break;
        }
    } else if input.cancel_pressed {
        _menu = 0
    }
    break;
    #endregion
#endregion
	#endregion

    case 3:
        //End Game
		game_end()
        break;
}