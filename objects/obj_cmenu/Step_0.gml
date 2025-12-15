switch currentState {
	case"hub":
			if input.up_pressed || input.down_pressed {
				num_buttons = inven_get_item_by_name("CELL_PHONE") != noone ? 3 : 2 + (member_get_attribute(party_get_leader(), "RACE") == "Monster");
				_menu_selection=(_menu_selection + num_buttons + input.down_pressed - input.up_pressed) % num_buttons;
				sfx_play(snd_menu_switch,1,global.sfx_volume);
			} else if(input.cancel_pressed){
				instance_destroy();
			} else if(input.action_pressed){
				switch _menu_selection {
					case 0:
						state = stateMenuItemOpened();
					break;
					
					case 1:
						state = stateMenuStat();
					break;
					
					case 2:
						state = stateMenuCell();
					break;
				} sfx_play(snd_menu_select,1,global.sfx_volume)
			}
	break;
	
	case "viewStat":
		if(input.cancel_pressed){
			_menu_item_option_selection = 0;
			instance_destroy(__stat);
			instance_destroy(__stat2);
			state = stateMenuHub();
		}
	break;
	
#region INVENTORY STATES
	case "itemOpened":
		if ((input.up_pressed || input.down_pressed) && _invcount > 0) {
			use_text = "";
			_menu_item_selection = (_menu_item_selection + input.down_pressed - input.up_pressed + _invcount) % _invcount;
			sfx_play(snd_menu_switch,1,global.sfx_volume)
		} else if(input.cancel_pressed){
			use_text = "";
			_menu_item_option_selection = 0;
			instance_destroy(__invmain);
			state = stateMenuHub();
		} else if(input.menu_pressed){
			use_text = "";
			_menu_item_section = (_menu_item_section + 1) % 5;
			switch(_menu_item_section){
				case 0:
					activeSection = "ALL";
				break;
				case 1:
					activeSection = "CONSUMABLES";
				break;
				case 2:
					activeSection = "ARMOUR";
				break;
				case 3:
					activeSection = "WEAPONS";
				break;
				case 4:
					activeSection = "KEY";
				break;
			}
			_menu_item_selection=0
			sfx_play(snd_menu_switch,1,global.sfx_volume)
		} else if(input.action_pressed && _invcount > 0){
			use_text = "";
			currentState="itemAction";
			_action_selction=0;
		}  
	break;
	
	case "itemAction":
		if (input.right_pressed || input.left_pressed) {
			_action_selction = !_action_selction;
		} else if (input.cancel_pressed) {
			currentState = "itemOpened";
		} else if input.action_pressed {
			if _action_selction {
				inven_remove_item(_item_index);
			} else {
				use_text = item_get_use_text(inven_get_item(_item_index))
				inven_use_item(_item_index, 0);
			}
			currentState = "itemOpened";
			if (_menu_item_selection == _invcount - 1) {
				_menu_item_selection = 0;
			}
		}  
	break;
	
	case "itemUsing":
		if input.action_pressed {
			currentState = "itemOpened";
		}
	break;
#endregion
	
#region CELL STATES
	case "viewContacts":
		if instance_exists(__info) { instance_destroy(__info) }
		if instance_exists(__invmain) { instance_destroy(__invmain) }
		if instance_exists(__invarm) { instance_destroy(__invarm) }
		if instance_exists(__invkey) { instance_destroy(__invkey) }
		if instance_exists(__invwep) { instance_destroy(__invwep) }
		if (input.up_pressed||input.down_pressed) {
			_menu_contact_selection=(_menu_contact_selection+input.down_pressed-input.up_pressed+array_length(_contacts))%array_length(_contacts)
			sfx_play(snd_menu_switch,1,global.sfx_volume)
		}
		if (input.cancel_pressed){
			if instance_exists(__contacts) { instance_destroy(__contacts) }
			_menu_item_option_selection = 0;
			_menu_active = 0;
			currentState = "hub"
			state = stateMenuHub();
		}
		if (input.action_pressed){
					if instance_exists(__info) { instance_destroy(__info) }
					if instance_exists(__invmain) { instance_destroy(__invmain) }
					if instance_exists(__invarm) { instance_destroy(__invarm) }
					if instance_exists(__invkey) { instance_destroy(__invkey) }
					if instance_exists(__invwep) { instance_destroy(__invwep) }
					if instance_exists(__contacts) { instance_destroy(__contacts) }
			_menu_active = 4;
			currentState = "contactChoices"
		}  
	break;
	case "contactChoices":
			if (input.up_pressed||input.down_pressed) {
				var contactChoices = global.CONTACTS[$ _contacts[_menu_contact_selection]].CHOICES;
				_menu_contact_choice_selection=(_menu_contact_choice_selection+input.down_pressed-input.up_pressed+array_length(contactChoices))%array_length(contactChoices)
				sfx_play(snd_menu_switch,1,global.sfx_volume)
			}
			if (input.cancel_pressed){
				instance_destroy(__contacts_call_choices);
				_menu_item_option_selection = 0;
				_menu_active = 0;
				currentState = "hub"
				state = stateMenuHub();
			}
			if (input.action_pressed){
			    _menu_active = 5;
			    instance_destroy(__contacts_call_choices);
			    var cs_data = get_cutscene_data_safe()
				show_debug_message("Cutscene data: " + string(cs_data));
			    show_debug_message("Flag: " + flag);
			    show_debug_message("Flag func: " + flag_func);
				
				flag_func = (array_length(cs_data) > 1) ? "increment" : "default";
			    if cs_data != undefined {
					show_debug_message("Cutscene data length: " + string(array_length(cs_data)));
			        switch flag_func {
			            case "increment":
			                // Check if we have multiple scenes and current flag is within bounds
			                if (is_array(cs_data) && array_length(cs_data) > 0) {
			                    var current_flag_value = global.flags[? flag];
			                    // Make sure we don't go out of bounds
			                    if (current_flag_value < array_length(cs_data)) {
			                        create_cutscene(cs_data[current_flag_value]);
			                        // Only increment if there are more scenes available
			                        if (current_flag_value < array_length(cs_data) - 1) {
			                            global.flags[? flag]++;
			                        }
			                    } else {
			                        // If flag is out of bounds, use the last scene
			                        create_cutscene(cs_data[array_length(cs_data) - 1]);
			                    }
			                }
			                break;
            
			            default:
			                // For single-scene interactions like T_DADDY
			                if (is_array(cs_data) && array_length(cs_data) > 0) {
			                    // If it's a nested array with multiple scenes, use the first one
			                    // If it's already a scene array, use it directly
			                    if (is_array(cs_data[0])) {
			                        create_cutscene(cs_data[0]);
			                    } else {
			                        create_cutscene(cs_data);
			                    }
			                }
			                break;
			        }
			    } else {
			        show_message("Failed to create cutscene")
			    }
			}
	break;
}

#endregion