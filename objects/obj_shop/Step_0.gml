// obj_shop Step Event
// First, handle shop initialization if needed
if (currentState == "initializing" && !_shop_initialized) {
    var shop = ShopGetCurrent();
    if (shop) {
        // Load shop data from struct
        character = shop.SHOPKEEPER;
        __font = global.characters[$ character].font;
        
        // Set all text fields from shop struct
        __text = shop.GREETING;
        __shopkeeperText = shop.GREETING;
        __talkText = shop.TALK_TEXT;
        __exitText = shop.EXIT_TEXT;
        __buyText = shop.BUY_TEXT;
        __buyFailText = shop.BUY_FAIL_TEXT;
        __buyNoSpaceText = shop.BUY_NO_SPACE_TEXT;
        __sellNoItemsText = shop.SELL_NO_ITEMS_TEXT;
        __sellFailText = shop.SELL_FAIL_TEXT;
        
        // Set talk system data
        talk_options = shop.TALK_OPTIONS;
        talkDialogue = shop.TALK_DIALOGUE;
        talkPortraits = shop.TALK_PORTRAITS;
        
        // Update shopkeeper sprite
        if (instance_exists(obj_shopkeeper)) {
            obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
        }
        
        _shop_initialized = true;
        currentState = "hub";
    }
}

// Main state machine
switch (currentState) {
    #region Shop Hub
    case "hub":
        obj_shopkeeper.destX = 159.5;
        _menuItemSelection = 0;
        _menuSellSelection = 0;
        
        if (input.up_pressed || input.down_pressed) {
            _menuSelection = (_menuSelection + 4 + input.down_pressed - input.up_pressed) % 4;
            sfx_play(snd_menu_switch, 1, 0.7);
        }
        
        if (input.action_pressed) {
            var shop = ShopGetCurrent();
            if (!shop) break;
            
            switch (_menuSelection) {
                // Buy Item Selected
                case 0:
                    __text = "";
                    var available_items = shop.get_available_items();
                    
                    // Build item list text
                    for (var i = 0; i < array_length(available_items); i++) {
                        var item = available_items[i];
                        __text += string(item.price) + "G " + item.name + "\n";
                    }
                    
                    __text += "Exit";
                    typist.skip();
                    sfx_play(snd_menu_select, 1, 0.7);
                    currentState = "shopItem";
                    
                    // Find first valid item starting from 0
                    _menuItemSelection = shop_find_first_valid_item(available_items, 0);
                    
                    // Update shopkeeper position
                    if (_menuItemSelection == array_length(available_items)) { // Exit
                        obj_shopkeeper.destX = 159.5;
                    } else {
                        obj_shopkeeper.destX = 90;
                    }
                    break;
                    
                // Sell Item selected
                case 1:
                    __text = "";
                    typist.skip();
                    sfx_play(snd_menu_select, 1, 0.7);
                    
                    if (shop.CAN_SELL) {
                        var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
                        if (array_length(inventory) == 1) {
                            __text = __sellNoItemsText;
                            currentState = "hub";
                            sfx_play(snd_error, 1, 0.7);
                        } else {
                            currentState = "shopSell";
                        }
                    } else {
                        __text = __sellFailText;
                        currentState = "hub";
                    }
                    break;
                    
                // Talk selected
                case 2:
                    sfx_play(snd_menu_select, 1, 0.7);
                    __text = __talkText;
                    currentState = "shopTalk";
                    break;
                    
                // Exit selected
                case 3:
                    __text = __exitText;
                    alarm[0] = 80;
                    break;
            }
        }
        break;
    #endregion
    
    #region Shop Item
    case "shopItem":
        typist2.skip();
        var shop = ShopGetCurrent();
        if (!shop) {
            currentState = "hub";
            break;
        }
        
        var available_items = shop.get_available_items();
        var total_options = array_length(available_items) + 1; // +1 for Exit
        
        // Navigation with sold out item skipping using helper function
        if (input.up_pressed || input.down_pressed) {
            var dir = input.down_pressed ? 1 : -1;
            var original_selection = _menuItemSelection;
            
            // Start searching from next position
            var next_index = (_menuItemSelection + dir + total_options) % total_options;
            var new_selection = shop_find_first_valid_item(available_items, next_index);
            
            // If we found a valid item different from original, update
            if (new_selection != original_selection) {
                _menuItemSelection = new_selection;
                sfx_play(snd_menu_switch, 1, 0.7);
                
                // Update shopkeeper position
                if (_menuItemSelection == total_options - 1) { // Exit
                    obj_shopkeeper.destX = 159.5;
                } else {
                    obj_shopkeeper.destX = 90;
                }
            }
        }
        
        if (input.action_pressed) {
            if (_menuItemSelection == total_options - 1) { // Exit selected
                __text = "* Take your time.";
                sfx_play(snd_menu_select, 1, 0.7);
                currentState = "hub";
            } else {
                // Buy item
                var item = available_items[_menuItemSelection];
                
                // Double-check if sold out (shouldn't happen with skipping, but safety)
                if (item.can_sell_out && item.current_stock == 0) {
                    __text = "* Sorry, that item is sold out!";
                    currentState = "hub";
                    sfx_play(snd_error, 1, 0.7);
                    break;
                }
                
                // Check player gold
                if (player_get_gold() < item.price) {
                    __text = __buyFailText;
                    currentState = "hub";
                    break;
                }
                
                // Check inventory space
                if (inven_get_space_left() == 0) {
                    __text = __buyNoSpaceText;
                    currentState = "hub";
                    break;
                }
                
                // Purchase successful
                inven_add_item(item.id);
                player_deduct_gold(item.price);
                sfx_play(snd_item_buy, 1, 0.7);
                __text = __buyText;
                
                // Update stock if limited
                if (item.can_sell_out) {
                    item.current_stock--;
                    
                    // Update in shop items array
                    for (var i = 0; i < array_length(shop.ITEMS); i++) {
                        if (shop.ITEMS[i].id == item.id) {
                            shop.ITEMS[i].current_stock = item.current_stock;
                            
                            // Mark as sold out if needed
                            if (item.current_stock == 0) {
                                shop.SOLD_OUT_ITEMS[$ item.id] = true;
                                
                                // If we just bought the last one, skip to next valid item
                                var next_index = (_menuItemSelection + 1) % total_options;
                                var next_selection = shop_find_first_valid_item(available_items, next_index);
                                
                                if (next_selection != _menuItemSelection) {
                                    _menuItemSelection = next_selection;
                                    
                                    // Update shopkeeper position
                                    if (_menuItemSelection == total_options - 1) {
                                        obj_shopkeeper.destX = 159.5;
                                    } else {
                                        obj_shopkeeper.destX = 90;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                
                currentState = "hub";
            }
        }
        
        // Cancel button support
        if (input.cancel_pressed) {
            __text = "* Take your time.";
            currentState = "hub";
            sfx_play(snd_menu_select, 1, 0.7);
        }
        break;
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
            
            if (input.action_pressed) {
                var item = inven_get_item(_menuSellSelection);
                if (item != noone) {
                    // Check if it's a KEY item (shouldn't be selectable, but safety check)
                    if (item_get_category(item) != "KEY") {
                        var sell_value = item_get_attribute(item, "SELL_VALUE");
                        player_set_gold(player_get_gold() + sell_value);
                        inven_remove_index(_menuSellSelection);
                        sfx_play(snd_item_buy, 1, 0.7);
                        
                        // Check if any valid items left
                        var remaining_valid = 0;
                        var remaining_inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
                        for (var i = 0; i < array_length(remaining_inventory); i++) {
                            var remaining_item = remaining_inventory[@ i];
                            if (remaining_item != noone && item_get_category(remaining_item) != "KEY") {
                                remaining_valid++;
                            }
                        }
                        
                        if (remaining_valid == 0) {
                            __text = __sellNoItemsText;
                            currentState = "hub";
                            sfx_play(snd_error, 1, 0.7);
                        }
                    }
                }
            }
        }
        
        if (input.cancel_pressed) {
            __text = "* Take your time.";
            currentState = "hub";
            sfx_play(snd_menu_select, 1, 0.7);
        }
        break;
    #endregion
    
    #region Shop Talk
    case "shopTalk":
        if (input.up_pressed || input.down_pressed) {
            _menuTalkSelection = (_menuTalkSelection + 5 + input.down_pressed - input.up_pressed) % 5;
            sfx_play(snd_menu_switch, 1, 0.7);
        }
        
        if (input.action_pressed) {
            switch (_menuTalkSelection) {
                case 0:
                case 1:
                case 2:
                case 3:
                    dialogueKey = "OPT_" + chr(65 + _menuTalkSelection);
                    currentState = "shopTalkLock";
                    if (array_length(talkPortraits[_menuTalkSelection]) >= 1) {
                        obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][0]];
                    } else {
                        obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                    }
                    break;
                case 4:
                    __text = __shopkeeperText;
                    sfx_play(snd_menu_select, 1, 0.7);
                    currentState = "hub";
                    break;
            }
        }
        break;
        
    case "shopTalkLock":
        if (input.action_pressed) {
            dialogueKey = "OPT_" + chr(65 + _menuTalkSelection);
            
            if (dialogueKey != "") {
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
                        
                        if (array_length(talkPortraits[_menuTalkSelection]) > dialogueIndex) {
                            obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][dialogueIndex]];
                        } else {
                            obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                        }
                        
                        // Check if we're at the last dialogue
                        if (dialogueIndex == arrayLength - 1) {
                            // Reset state back to shopTalk
                            currentState = "shopTalk";
                            // Reset the dialogue index for next time
                            global[$ "dialogueIndex_" + dialogueKey] = 0;
                            sfx_play(snd_menu_select, 1, 0.7);
                            obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                        } else {
                            // Move to next dialogue
                            dialogueIndex = (dialogueIndex + 1) % arrayLength;
                            global[$ "dialogueIndex_" + dialogueKey] = dialogueIndex;
                            sfx_play(snd_menu_select, 1, 0.7);
                            
                            if (array_length(talkPortraits[_menuTalkSelection]) > dialogueIndex) {
                                obj_shopkeeper.sprite_index = global.characters[$ character].portraits[$ talkPortraits[_menuTalkSelection][dialogueIndex]];
                            } else {
                                obj_shopkeeper.sprite_index = global.characters[$ character].portraits.neutral;
                            }
                        }
                    }
                }
            }
        }
        break;
    #endregion
    
    case "initializing":
        // Already handled at the top
        break;
}