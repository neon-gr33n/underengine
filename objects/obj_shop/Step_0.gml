// TODO: Add Left/right navigation for selling items
switch(currentState){
	#region Shop Hub
	case "hub":
		obj_shopkeeper.destX = 159.5;
		_menuItemSelection = 0;
		_menuSellSelection = 0;
		if input.up_pressed || input.down_pressed {
					_menuSelection=(_menuSelection+4+input.down_pressed-input.up_pressed)%4
					sfx_play(snd_menu_switch,1,0.7)
		}
		if input.action_pressed {
			switch(_menuSelection){
				// Buy Item Selected
				case 0:
					__text = "";
					var _length = array_length(buy_options);

					// Add buyable items with prices
					for (var i = 0; i < _length; i++) {
					    __text += gold_options[i] + " " + buy_options[i] + "\n";
					}

					// Add exit option
					__text += gold_options[_length];
					typist.skip();
					obj_shopkeeper.destX = 90;
					sfx_play(snd_menu_select,1,0.7)
					currentState = "shopItem";
				break;
				// Sell Item selected
				case 1:
					__text = "";
					typist.skip();
					sfx_play(snd_menu_select,1,0.7)
					if(canSellItems){
						 var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
						if(array_length(inventory) == 1){
						__text = __sellNoItemsText;
						currentState = "hub";
						sfx_play(snd_error,1,0.7)
						} else {						
							//obj_shopkeeper.destX = 90;
							currentState = "shopSell";	
						}
					} else {
						__text = "* I'm trying to sell#\tstuff not get#\tmore of it!"
						currentState = "hub"
					}
				break;
				// Talk selected
				case 2:
					sfx_play(snd_menu_select,1,0.7)
					__text = __talkText;
					currentState = "shopTalk"
				break;
				// Exit selected
				case 3:
					__text = __exitText;
					alarm[0] = 120;
				break;
			}
		}
	break;
	#endregion
	#region Shop Item
	case "shopItem":
		typist2.skip();
		if input.up_pressed || input.down_pressed {
			_menuItemSelection=(_menuItemSelection+5+input.down_pressed-input.up_pressed)%5
			sfx_play(snd_menu_switch,1,0.7)
			
			if _menuItemSelection == 4 {
					obj_shopkeeper.destX = 159.5;
			} else {
				obj_shopkeeper.destX = 90;	
			}
		}
		if input.action_pressed {
			switch(_menuItemSelection){
					case 0:
						if (player_get_gold() < gold_cost[0]){
								__text = __buyFailText;
								currentState = "hub";
						} else if (inven_get_space_left() != 0) {
								inven_add_item(add_options[0]);
								__text = __buyText;
								sfx_play(snd_item_buy,1,0.7)
								player_deduct_gold(gold_cost[0]);
								currentState = "hub";
						} else {
								__text = __buyNoSpaceText;
								currentState = "hub";
						}
					break;
					case 1:
						if (player_get_gold() < gold_cost[1]){
								__text = __buyFailText;
								currentState = "hub";
						} else if (inven_get_space_left() != 0) {
								inven_add_item(add_options[1]);
								__text = __buyText;
								sfx_play(snd_item_buy,1,0.7)
								player_deduct_gold(gold_cost[1]);
								currentState = "hub";
						} else {
								__text = __buyNoSpaceText;
								currentState = "hub";
						}
					break;
					case 2:
						if (player_get_gold() < gold_cost[2]){
								__text = __buyFailText;
								currentState = "hub";
						} else if (inven_get_space_left() != 0) {
								inven_add_item(add_options[2]);
								__text = __buyText;
								sfx_play(snd_item_buy,1,0.7)
								player_deduct_gold(gold_cost[2]);
								currentState = "hub";
						}else  {
								__text = __buyNoSpaceText;
								currentState = "hub";
								sfx_play(snd_error,1,0.7)
						}
					break;
					case 3:
						if (player_get_gold() < gold_cost[3]){
								__text = __buyFailText;
								currentState = "hub";
						} else if (inven_get_space_left() != 0) {
								inven_add_item(add_options[3]);
								__text = __buyText;
								sfx_play(snd_item_buy,1,0.7)
								player_deduct_gold(gold_cost[3]);
						} else  {
								__text = __buyNoSpaceText;
								currentState = "hub";
								sfx_play(snd_error,1,0.7)
						}
					break;
					case 4:
					__text = "* Take your time.";
					sfx_play(snd_menu_select,1,0.7)
					currentState = "hub";
					break;
					sfx_play(snd_menu_select,1,0.7)
			}
		}
	break
	#endregion
	#region Shop Sell
	case "shopSell":
	     var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
	    var valid_items_count = 0;
    
	    // Count non-KEY items
	    for (var i = 0; i < array_length(inventory); i++) {
	        var item = inventory[@ i];
	        if (item != noone) {
	            if (item_get_category(item) != "KEY") {
	                valid_items_count++;
	            }
	        }
	    }
    
	    // Check if there are any valid items to sell (excluding KEY items)
	    if (valid_items_count == 0) {
	        __text = __sellNoItemsText;
	        currentState = "hub";
	        sfx_play(snd_error, 1, 0.7);
	    } else {
	        // Get the count of all items (including KEY)
	        var total_items = array_length(inventory);
        
	        if (input.up_pressed || input.down_pressed) {
	            // Find the next/previous valid item
	            var dir = input.down_pressed - input.up_pressed;
	            var attempts = 0;
	            var original_selection = _menuSellSelection;
	            var found = false;
            
	            while (attempts < total_items && !found) {
	                _menuSellSelection = (_menuSellSelection + dir + total_items) % total_items;
	                var item = inventory[@ _menuSellSelection];
                
	                if (item != noone) {
	                    if (item_get_category(item) != "KEY") {
	                        found = true;
	                        sfx_play(snd_menu_switch, 1, 0.7);
	                    }
	                }
	                attempts++;
	            }
            
	            // If no valid item found, revert to original
	            if (!found) {
	                _menuSellSelection = original_selection;
	            }
            
	        } else if (input.left_pressed || input.right_pressed) {
	            // Horizontal navigation with KEY item skipping
	            var current_index = _menuSellSelection;
	            var current_row = current_index mod 4; // Row position (0-3)
	            var target_col = input.right_pressed ? 1 : 0; // 0 for left, 1 for right
	            var target_index = target_col * 4 + current_row;
            
	            // Make sure target index is within bounds
	            if (target_index < total_items) {
	                var item = inventory[@ target_index];
	                if (item != noone) {
	                    if (item_get_category(item) != "KEY") {
	                        _menuSellSelection = target_index;
	                        sfx_play(snd_menu_switch, 1, 0.7);
	                    } else {
	                        // If target is a KEY item, try to find nearest valid item in that column
	                        var found = false;
	                        for (var offset = 0; offset < 4 && !found; offset++) {
	                            // Try above and below in the target column
	                            var try_indices = [
	                                (target_index - offset + total_items) % total_items,
	                                (target_index + offset) % total_items
	                            ];
                            
	                            for (var t = 0; t < array_length(try_indices) && !found; t++) {
	                                var try_index = try_indices[t];
	                                // Make sure we're staying in the same column (0-3 or 4-7)
	                                if ((try_index div 4) == target_col) {
	                                    var try_item = inventory[@ try_index];
	                                    if (try_item != noone) {
	                                        if (item_get_category(try_item) != "KEY") {
	                                            _menuSellSelection = try_index;
	                                            found = true;
	                                            sfx_play(snd_menu_switch, 1, 0.7);
	                                        }
	                                    }
	                                }
	                            }
	                        }
	                    }
	                }
	            }
	        }
			if input.action_pressed {				
			var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
			switch(_menuSellSelection){
					case 0:
					case 1:
					case 2:
					case 3:
					case 4:
					case 5:
					case 6:
					case 7:
						var SEL = _menuSellSelection
						var item = inven_get_item(SEL);
						player_set_gold(player_get_gold() + item_get_attribute(item,"SELL_VALUE"))
						inven_remove_index(SEL)
						sfx_play(snd_item_buy,1,0.7)
						if(array_length(inventory) <= 0){
							__text = __sellNoItemsText;
							currentState = "hub";
							sfx_play(snd_error,1,0.7)
						}
					break;
					
					
					case 8:
						__text = "* Take your time.";
						currentState = "hub"
						sfx_play(snd_menu_select,1,0.7)
					break;
				}
			}
					
			}
		if input.cancel_pressed {
				__text = "* Take your time."
				currentState = "hub"
		}

	break;
	#endregion
	#region Shop Talk
	case "shopTalk":
		if input.up_pressed || input.down_pressed {
					_menuTalkSelection=(_menuTalkSelection+5+input.down_pressed-input.up_pressed)%5
					sfx_play(snd_menu_switch,1,0.7)
		}
		if input.action_pressed {
			switch(_menuTalkSelection){
				case 0:
		        case 1:
		        case 2:
				case 3:
					dialogueKey = "OPT_" + chr(65 + _menuTalkSelection);
					currentState = "shopTalkLock";
					if array_length(talkPortraits[_menuTalkSelection]) >= 1
						obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][0]];
					else
						obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
					break;
				case 4:
						__text = __shopkeeperText;
						sfx_play(snd_menu_select,1,0.7)
						currentState = "hub";
				break;
			}
		}
	break;
	case "shopTalkLock":
		if (input.action_pressed) {
    dialogueKey = "OPT_" + chr(65 + _menuTalkSelection);
    
    if (dialogueKey != "" && global.characters[$ character].type == SPEAKER_TYPE.SHOP) {
        // Check if the key exists in the struct and is a valid array
        if (variable_struct_exists(talkDialogue, dialogueKey)) {
            var dialogueArray = talkDialogue[$ dialogueKey];
            
            // Make sure it's an array and has elements
            if (is_array(dialogueArray) && array_length(dialogueArray) > 0) {
                // Initialize dialogueIndex if it doesn't exist for this key
                if (!variable_global_exists("dialogueIndex_" + dialogueKey)) {
                    global[$ "dialogueIndex_" + dialogueKey] = 0;
                }
                
                var dialogueIndex = global[$ "dialogueIndex_" + dialogueKey];
                var arrayLength = array_length(dialogueArray);
				
				if array_length(talkPortraits[_menuTalkSelection]) > dialogueIndex
					obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][dialogueIndex]];
				else
					obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                
                // Check if we're at the last dialogue
                if (dialogueIndex == arrayLength - 1) {
                    // Reset state back to shopTalk
                    currentState = "shopTalk";
                    // Reset the dialogue index for next time
                    global[$ "dialogueIndex_" + dialogueKey] = 0;
                    sfx_play(snd_menu_select, 1, 0.7);
					obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral
                } else {
                    // Move to next dialogue
                    dialogueIndex = (dialogueIndex + 1) % arrayLength;
                    global[$ "dialogueIndex_" + dialogueKey] = dialogueIndex;
                    sfx_play(snd_menu_select, 1, 0.7);
					
					if array_length(talkPortraits[_menuTalkSelection]) > dialogueIndex
						obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][dialogueIndex]];
					else
						obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                }
			 }
			}
        }
    }
	break;
	#endregion
	
}