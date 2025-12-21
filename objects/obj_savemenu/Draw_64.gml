if(live_call()) return live_result;
HEART.visible=true;
switch _state {
	case 1:
		HEART.visible=false;
	case 0:
		draw_sprite_ext(global.boxout, -1, 320, 246,9.5,3.6,0,c_white,1)
		draw_sprite_ext(global.boxin, -1, 320, 246,9.5,3.6,0,c_white,__DRAW_BOX_OPACITY)
		draw_sprite_ext(global.boxout, -1, 320, 88, 3, 0.8,0,c_white,1);
		draw_sprite_ext(global.boxin, -1, 320, 88, 3, 0.8,0,c_white,__DRAW_BOX_OPACITY);
		draw_sprite_ext(global.boxout, -1, 320, 134, 9.5, 1.4,0,c_white,1);
		draw_sprite_ext(global.boxin, -1, 320, 134, 9.5, 1.4,0,c_white,__DRAW_BOX_OPACITY);
		draw_set_color(savecount="y" ? c_yellow : c_white);
		draw_sprite_ext(spr_ui_icons,0,408,175,2,2,0,savecount="y" ? c_yellow : c_white,1)
		draw_set_font(fnt_main_small);
		draw_text_transformed(80+6+20+20,110+6+50,string(member_get_attribute(party_get_leader(), "NAME")),2,2,0)

		// Player data/stats
		draw_set_halign(fa_center)
		draw_text_transformed(320/*230+6+20*/,18+6+50,"File "+string(global.filechoice),2,2,0)
		draw_set_halign(fa_left)
		
		draw_text_transformed(80+6+20+20,54+10+50,get_room_name(global.currentroom),2,2,0)
		draw_text_transformed(245+6+20+20,111+6+50,"LV: "+string(member_get_stat(party_get_leader(), "LV")),2,2,0)
		draw_text_transformed(250+2+20+20,146+6+50,"EXP: "+string(member_get_stat(party_get_leader(), "EXP")),2,2,0)
		draw_text_transformed(368+20+20,146+6+50,"GOLD: "+string(party_get_stat("GOLD")),2,2,0)
		
		// Time
		
		if(savecount=="y")
			draw_text_transformed(392+4+20+20,111+6+50,
			(global.timeHoursPrevious>0 ? string(global.timeHoursPrevious)+":" : "")
			+ (global.timeMinutesPrevious % 60 < 10 ? "0" : "") + string(global.timeMinutesPrevious%60)
			+":"+(global.timeSecondsPrevious%60<10 ? "0" : "") + string(global.timeSecondsPrevious%60),2,2,0);
		else
			draw_text_transformed(392+4+20+20,111+6+50,(hours>0 ? string(hours)+":" : "")+(minutes%60<10 ? "0" : "")+string(minutes%60)+":"+(seconds%60<10 ? "0" : "")+string(seconds%60),2,2,0)
		
		// Menu choices
		if(savecount!="y"){
			draw_rpgtext(155+6+20+20,183+6+50,"Save",fnt_main_small,1,16,1,2,2,_choice==0 ?  c_yellow : c_white )
			draw_rpgtext(300+6+20+20,183+6+50,"Return",fnt_main_small,1,16,1,2,2,_choice==1 ? c_yellow : c_white )
			draw_rpgtext(220+6+20+20,225+6+50,"Storage",fnt_main_small,1,16,1,2,2,_choice==0.5 ? c_yellow : c_white )
		} else if(savecount=="y"){
			draw_rpgtext(155+6+20+20,183+6+50,"Save",fnt_main_small,1,16,1,2,2,c_yellow )
			draw_rpgtext(300+6+20+20,183+6+50,"Return",fnt_main_small,1,16,1,2,2,c_yellow )
			draw_rpgtext(220+6+20+20,225+6+50,"Storage",fnt_main_small,1,16,1,2,2,c_yellow )
		}

		if(_state==0){
			_sep=6
			if (_choice != 0.5){
				HEART.x=108+(147*(_choice div 1))+6+37+20
			} else {
				HEART.x=108+(147*(_choice div 1))+6+130
			}
			HEART.y=118+(84*(_choice%1))+6+125+_sep
		}
	break;
	
	#region Storage Menu
	case 3:
    //draw_sprite_stretched(spr_textborder, -1, 240, 10+54-35, 160, 132/2.5);
    //draw_sprite_ext(spr_textborder, -1, 320, 285-35,14,7,0,c_white,1)
    //draw_sprite_stretched(spr_textborder, -1, 50, 42+54-35, 540, 140);
    draw_sprite_ext(global.boxout, -1, 320, 47,3.4,0.8,0,c_white,1)
    draw_sprite_ext(global.boxin, -1, 320, 47,3.4,0.8,0,c_white,__DRAW_BOX_OPACITY)
    draw_sprite_ext(global.boxout, -1, 320, 245,12,8,0,c_white,1)
    draw_sprite_ext(global.boxin, -1, 320,245,12,8,0,c_white,__DRAW_BOX_OPACITY)
    draw_sprite_ext(global.boxout, -1, 320, 116,12,2.4,0,c_white,1)
    draw_sprite_ext(global.boxout, -1, 320, 300,12,5.7,0,c_white,1)
    draw_set_font(fnt_main_small);

    draw_set_halign(fa_center)
    draw_text_transformed(320/*230+6+20*/,18+6+47-55+14,"Storage",2,2,0)
    draw_set_halign(fa_left)
    
    var _col0=""
    var _col1=""
    var _col2=""
    
    var _storage = party_get_attribute("STORAGE");
    var _max_storage = party_get_attribute("MAXSTORAGESIZE");
    var _inven = party_get_attribute("INVENTORY");
    var _max_inven = party_get_attribute("MAXINVSIZE");
    var _placeholder = "[c_grey]---------[/c]";
    
    // Helper function to count non-KEY items in an array up to a certain index
    function get_non_key_item_at_index(arr, target_index) {
        var non_key_count = 0;
        for (var i = 0; i < array_length(arr); i++) {
            var item = arr[@ i];
            if (item != noone && item_get_category(item) != "KEY") {
                if (non_key_count == target_index) {
                    return {item: item, actual_index: i};
                }
                non_key_count++;
            }
        }
        return {item: noone, actual_index: -1};
    }
    
    // Count non-KEY items in inventory
    var _inven_non_key_count = 0;
    for (var i = 0; i < array_length(_inven); i++) {
        if (_inven[@ i] != noone && item_get_category(_inven[@ i]) != "KEY") {
            _inven_non_key_count++;
        }
    }
    
    // Count non-KEY items in storage
    var _storage_non_key_count = 0;
    for (var i = 0; i < array_length(_storage); i++) {
        if (_storage[@ i] != noone && item_get_category(_storage[@ i]) != "KEY") {
            _storage_non_key_count++;
        }
    }
    
    // Build inventory columns (skip KEY items)
    for (var i = 0; i < ceil(_max_inven / 3); ++i) {
        var col0_item = get_non_key_item_at_index(_inven, i * 3);
        var col1_item = get_non_key_item_at_index(_inven, i * 3 + 1);
        var col2_item = get_non_key_item_at_index(_inven, i * 3 + 2);
        
        _col0 += (_max_inven > (i * 3) ? (col0_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col0_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
        _col1 += (_max_inven > (i * 3 + 1) ? (col1_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col1_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
        _col2 += (_max_inven > (i * 3 + 2) ? (col2_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col2_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
    }
    
    _col0 += "\n";
    _col1 += "\n";
    _col2 += "\n";
    
    // Build storage columns (skip KEY items)
    for (var i = 0; i < ceil(_max_storage / 3); ++i) {
        var col0_item = get_non_key_item_at_index(_storage, i * 3);
        var col1_item = get_non_key_item_at_index(_storage, i * 3 + 1);
        var col2_item = get_non_key_item_at_index(_storage, i * 3 + 2);
        
        _col0 += (_max_storage > (i * 3) ? (col0_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col0_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
        _col1 += (_max_storage > (i * 3 + 1) ? (col1_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col1_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
        _col2 += (_max_storage > (i * 3 + 2) ? (col2_item.item != noone ? "  [scale,0.75]" + item_get_attribute(col2_item.item, "SHORT_NAME") + "[scale,1]" : _placeholder) : "") + "\n";
    }
    
    if instance_exists(__col2) {
        if input.action_pressed {
            if _swapping != -1 {
                // Modified swapping logic to handle KEY item skipping
                var swap_from_actual = -1;
                var swap_to_actual = -1;
                
                // Get actual indices accounting for KEY items
                if (_choice < 300) {
                    var from_item = get_non_key_item_at_index(_inven, _choice);
                    swap_from_actual = from_item.actual_index;
                } else {
                    var from_item = get_non_key_item_at_index(_storage, _choice - 300);
                    swap_from_actual = from_item.actual_index;
                }
                
                if (_swapping < 300) {
                    var to_item = get_non_key_item_at_index(_inven, _swapping);
                    swap_to_actual = to_item.actual_index;
                } else {
                    var to_item = get_non_key_item_at_index(_storage, _swapping - 300);
                    swap_to_actual = to_item.actual_index;
                }
                
                if (swap_from_actual != -1 && swap_to_actual != -1) {
                    inven_storage_swap(swap_from_actual, swap_to_actual);
                }
                _swapping = -1;
            } else {
                if _choice>=300
                    if array_length(_inven) >= _max_inven {
                        _swapping = _choice;
                        _choice = 0;
                        //sfx_play(snd_error)
                    } else {
                        var storage_item = get_non_key_item_at_index(_storage, _choice-300);
                        if (storage_item.actual_index != -1) {
                            sfx_play(snd_menu_select)
                            storage_to_inven(storage_item.actual_index);
                            if _storage_non_key_count<=0 _choice=((((_inven_non_key_count-1) div 3)-((_inven_non_key_count-1)%3<_choice%3))*3)+(_choice%3) else clamp(_choice,300,300+_storage_non_key_count-1)
                        }
                    }
                else
                    if array_length(_storage) >= _max_storage {
                        _swapping = _choice;
                        _choice = 300;
                        //sfx_play(snd_error)
                    } else {
                        var inven_item = get_non_key_item_at_index(_inven, _choice);
                        if (inven_item.actual_index != -1) {
                            sfx_play(snd_menu_select)
                            inven_to_storage(inven_item.actual_index);
                            if _inven_non_key_count<=0 {_choice=300+_choice%3} else clamp(_choice,0,_inven_non_key_count-1)
                        }
                    }
                }
            if (_choice>=300 ? _storage_non_key_count : _inven_non_key_count)<=0 _choice=(_choice>=300 ? (_choice<300 ? (_choice-300+3>=_storage_non_key_count ? (_choice%3) : _choice+3) : (_choice-3<300 ? (((_inven_non_key_count div 3)+( ((_inven_non_key_count-1)%3-(_choice%3))<=-1 ? -1 : 0))*3)+(_choice%3) : _choice-3)) : (_choice<300 ? (_choice+3>=_inven_non_key_count ? (300+_choice%3) : _choice+3) : (_choice-3<0 ? 300+(((_storage_non_key_count div 3)+( ((_storage_non_key_count-1)%3-(_choice%3))<=-1 ? -1 : 0))*3)+(_choice%3) : _choice-3))) else _choice=(_choice>=300 ? clamp(_choice,300,300+_storage_non_key_count-1) : clamp(_choice,0,_inven_non_key_count-1))
        } else if input.cancel_pressed {
            _swapping = -1;
            if instance_exists(__col0) instance_destroy(__col0)
            if instance_exists(__col1) instance_destroy(__col1)
            if instance_exists(__col2) instance_destroy(__col2)
            _state=0
            _choice=1.5
            _swapping = -1;
            sfx_play(snd_menu_select)
            break;
        } else if (input.up_pressed) || (input.down_pressed) {
            // Updated navigation to use non-KEY counts
            var _inv_len = _swapping != -1 && _swapping < 300 ? 0 : _inven_non_key_count;
            var _store_len = _swapping != -1 && _swapping >= 300 ? 0 : _storage_non_key_count;
            if _choice >= 300 {
                _choice += (input.down_pressed - input.up_pressed) * 3;
                if _choice >= 300 + _store_len {
                    _choice %= 3;
                    if _inv_len <= _choice
                        _choice = 300 + _choice;
                } else if _choice < 300 {
                    _choice = ((((_inv_len - 1) div 3)-((_inv_len - 1) % 3 < _choice % 3)) * 3) + (_choice % 3);
                    if _inv_len<=_choice || _choice < 0 {
                        _choice += 3;
                        _choice = 300 + ((((_store_len - 1) div 3)-((_store_len - 1) % 3 < _choice % 3)) * 3) + (_choice % 3);
                    }
                }
            } else {
                _choice += (input.down_pressed - input.up_pressed) * 3;
                if _choice >= _inv_len {
                    _choice = 300 + _choice % 3;
                    if _store_len <= _choice - 300
                        _choice %= 3
                } else if _choice<0 {
                    _choice += 3;
                    _choice = 300 + ((((_store_len - 1) div 3) - ((_store_len - 1) % 3 < _choice % 3)) * 3) + (_choice % 3);
                    if _store_len <= _choice - 300 || _choice < 300
                        _choice=((((_inv_len - 1) div 3) - ((_inv_len - 1) % 3 < _choice % 3)) * 3) + (_choice % 3);
                }
            }
            sfx_play(snd_menu_switch);
        } else if(input.left_pressed) || (input.right_pressed) {
            var _inv_len = _swapping != -1 && _swapping < 300 ? 0 : _inven_non_key_count;
            var _store_len = _swapping != -1 && _swapping >= 300 ? 0 : _storage_non_key_count;
            _choice=(_choice div 3)*3+clamp(((_choice)-1+3)%3,0,(_choice>=300 ? clamp(_store_len-((_choice-300) div 3)*3,1,3) : clamp(_inv_len-(_choice div 3)*3,1,3))-1)*input.left_pressed+(	(((_choice)+(1)+3)%3)%(_choice>=300 ? clamp(_store_len-((_choice-300) div 3)*3,1,3) : clamp(_inv_len-(_choice div 3)*3,1,3)))*input.right_pressed;
            sfx_play(snd_menu_switch);
        }
    } else {
        __col0=instance_create(100,67,obj_text_writer)
        __col1=instance_create(273,67,obj_text_writer)
        __col2=instance_create(446,67,obj_text_writer)
    }

    // Update heart position calculation to use non-KEY counts
    HEART.x=90+(_choice%3)*173
    HEART.y=(_choice>=300 ? 201 : 85)+((_choice%300) div 3)*29
    
    __col0.dialogue.dialogueFont = "fnt_main_bt"
    __col0._speed = 0.95;
    __col0.dialogue.dialogueText=_col0
    __col0.dialoguePosition="none" 
    __col0.typist.skip();
    
    __col1.dialogue.dialogueFont = "fnt_main_bt"
    __col1._speed = 0.95;
    __col1.dialogue.dialogueText=_col1
    __col1.dialoguePosition="none"
    __col1.typist.skip();
    
    __col2.dialogue.dialogueFont = "fnt_main_bt"
    __col2._speed = 0.95;
    __col2.dialogue.dialogueText=_col2
    __col2.dialoguePosition="none"
    __col2.typist.skip();
    break;
	#endregion
}
