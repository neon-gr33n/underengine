if (player_is_dead() && encounter_exists()) {
    encounter_end();
}

switch (currentState) {
	#region Player Turn Starts
    case "menuBegin":
        encounter_set_menu_text(encounterMenuText);
		if speech_bubble_exists(){
			instance_destroy(obj_text_writer_bubble)
			instance_destroy(obj_battle_speech_bubble)	
		}
		spare_sound_played = false;
        if (input.left_pressed) {
            battleMenuSelection = (battleMenuSelection - 1) % 3;
            tweened = (tweened + 72) % 360;
        } else if (input.right_pressed) {
            battleMenuSelection = (battleMenuSelection + 1) % 4;
            tweened = -((-(tweened - 72)) % 360);
        } else if (input.action_pressed) {
            switch (battleMenuSelection) {
                case 0:
                    battle_set_menu_state("menuFightSelect");
                    break;
                case 1:
                    battle_set_menu_state("menuActSelect");
                    break;
                case 2:
                    if (array_length(global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"]) > 0) {
                        battle_set_menu_state("menuItemSelect");
                        _temped = 0;
                    }
                    break;
                case 3:
                    battle_set_menu_state("menuMercySelect");
                    break;
            }
        }
        break;
	#endregion
	
	case "enemyTurn":
		//show_debug_message("===== ENEMY TURN ======")
		//show_debug_message("Heart state == " + HEART.currentState)
		//show_debug_message("Heart X == " + string(HEART.x))
		//show_debug_message("Heart X == " + string(HEART.y))
	break;
	
    #region FIGHT STATES
    #region Select Target
    case "menuFightSelect":
		   // FIRST: Make sure enemyChoice points to a valid enemy
    if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice] == noone) {
        // Find first non-empty slot
        for (var i = 0; i < 3; i++) {
            if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] != noone) {
                enemyChoice = i;
                break;
            }
        }
    }
	
        noone_c = 0;
        incr = function(_e, _i) {
            if (_i < enemyChoice && global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][_i] == noone) {
                noone_c++;
            }
        };
        array_foreach(global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"], incr);
        HEART.x = 72;
        HEART.y = 270 + 30 * (enemyChoice - noone_c);
        if (input.action_pressed) {
            battle_set_menu_state("menuFightEye");
            with (WRITER) {
                dialogue.dialogueText = "";
            }
        } else if (input.up_pressed || input.down_pressed) {
            do {
                enemyChoice = (enemyChoice + 3 + input.down_pressed - input.up_pressed) % 3;
            } until (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][@ enemyChoice] != noone);
            sfx_play(snd_menu_switch);
        } else if (input.cancel_pressed) {
            WRITER.dialogue.dialogueText = "";
            battle_set_menu_state("menuBegin");
        }
        break;
    #endregion

    #region Eye Display
    case "menuFightEye":
        with (obj_text_writer) { visible = false; }
        for (i = array_length(bar_info[$ "INFO"]) - 1; i >= 0; i--) {
            if (rec_x[i] >= 420 && !done[i]) {
                done[i] = true;
                missed[i] = true;
            } else if (input.action_pressed && rec_x[i] > 50 && (i == 0 ? true : done[i - 1]) && !done[i]) {
                done[i] = true;
                if (bar_info[$ "INFO"][i][$ "CRIT_SOUND"] == noone) {
                    sfx_play(bar_info[$ "INFO"][i][$ "SOUND"],1,global.sfx_volume);
                } else {
                    sfx_play(((array_length(bar_info[$ "INFO"]) == 1 && abs(320 - rec_x[i]) <= 12) || (array_length(bar_info[$ "INFO"]) > 1 && abs(floor(rec_x[i] / rec_speed[i]) - floor(320 / rec_speed[i])) < 1) ? bar_info[$ "INFO"][i][$ "CRIT_SOUND"] : bar_info[$ "INFO"][i][$ "SOUND"]),1,global.sfx_volume);
                }
            }

            if (done[i]) {
                if (missed[i]) {
                    rec_x[i] += rec_speed[i];
                    rec_alpha[i] -= 0.1;
                } else {
                    rec_img[i] += 0.5;
                    if (done_proc[i] >= 50) {
                        rec_alpha[i] -= 0.1;
                    }
                    done_proc[i]++;
                }
            } else {
                if (undone_proc[i] > bar_info[$ "INFO"][i][$ "DELAY"]) {
                    rec_x[i] += rec_speed[i];
                }
                undone_proc[i]++;
            }
        }
        if (!done[array_length(bar_info[$ "INFO"]) - 1]) {
            target_xs += (1 - target_xs) / 5;
            TweenFire(self, EaseLinear, 0, 0, 0, 15, "fightAlpha", fightAlpha, 1);
        } else {
            battle_set_menu_state("menuFightAnim");
        }
        break;
    #endregion

    #region Animation Handling
    case "menuFightAnim":
        for (i = array_length(bar_info[$ "INFO"]) - 1; i >= 0; i--) {
            if (done[i]) {
                if (missed[i]) {
                    rec_x[i] += rec_speed[i];
                    rec_alpha[i] -= 0.2;
                } else {
                    rec_img[i] += 0.5;
                    if (done_proc[i] >= 50) {
                        rec_alpha[i] -= 0.1;
                    }
                    done_proc[i]++;
                }
            }
        }

        if (fight_anim_i == -1) {
            p_index = 0;
            dmg = atk_dmg_calc();
        }

        if (fight_done && fight_anim_i >= 7) {
            //pass
        } else if (fight_done && fight_anim_i >= 6) {
            var inst = instance_create_depth(global.enc_slot[enemyChoice].x, global.enc_slot[enemyChoice].y - 100, -99999, battle_damage);
            var _hped = global.enc_slot[enemyChoice]._hp;
			with(global.enc_slot[enemyChoice]){
			event_user(5);
			}
            inst.damage = dmg;
            inst.bar_hp_max = global.enc_slot[enemyChoice]._hp_max;
            inst.bar_hp_original = _hped;
            inst.bar_hp_target = (_hped - dmg <= 0 ? 0 : _hped - dmg);
            global.enc_slot[enemyChoice]._hp = (_hped - dmg <= 0 ? 0 : _hped - dmg);
            fight_anim_i = 7;
            if (global.enc_slot[enemyChoice]._hp <= 0) {
                _death = global.enc_slot[enemyChoice];
            } 
            _death_i = enemyChoice;
            alarm[0] = 65;
            TweenFire(self, EaseLinear, 0, 0, 50, 15, "target_xs", target_xs, 0);
            TweenFire(self, EaseLinear, 0, 0, 50, 15, "fightAlpha", fightAlpha, 0);
            if (dmg > 0) {
                sfx_play(global.enc_slot[enemyChoice].hurtSound,_death != noone ? 0.8 : 1,global.sfx_volume);
				sfx_play(snd_hurt,1,global.sfx_volume);
                shaker_create(global.enc_slot[enemyChoice], "x", 15, 4, 3);
            }
        } else {
            fight_anim_i += 0.5;
            fight_done = true;
        }
        break;
    #endregion

    #region Victory (Violent & Pacifist)
   case "menuViolentWin":
	   HEART.visible = false;
	    with HEART {
			 if (layer_exists(layer_get_id("menuHeart"))) layer_destroy(layer_get_id("menuHeart"));
		}
        if (!variable_instance_exists(id, "rewards_awarded")) {
            // Determine if this is a spared victory or violent victory
            var was_spared = false;
            
            // Check if any enemies were spared (not destroyed)
            for (var i = 0; i < 3; i++) {
                var slot_enemy = global.enc_slot[i];
                if (slot_enemy != noone && instance_exists(slot_enemy)) {
                    if (slot_enemy.spared) {
                        was_spared = true;
                        break;
                    }
                }
            }
            
			if (was_spared){
			   awardBattleRewards(false, was_spared);
			} else {
				   awardBattleRewards(true, was_spared);
			}
        }

        if (input.action_pressed) {
            encounter_end();
        }
        break;
    #endregion
    #endregion

    #region ACT STATES
    #region Select Target
    case "menuActSelect":
		   // FIRST: Make sure enemyChoice points to a valid enemy
	    if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice] == noone) {
	        // Find first non-empty slot
	        for (var i = 0; i < 3; i++) {
	            if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] != noone) {
	                enemyChoice = i;
	                break;
	            }
	        }
	    }
        noone_c = 0;
        incr = function(_e, _i) {
            if (_i < enemyChoice && global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][_i] == noone) {
                noone_c++;
            }
        };
        array_foreach(global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"], incr);
        HEART.x = 72;
        HEART.y = 270 + 30 * (enemyChoice - noone_c);
        if (input.action_pressed) {
            // Get selected enemy
            var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice];
            selected_enemy_id = enemy_id;
            
            // Get enemy info and ACTs
            var enemy_info = global.ENEMY_INFO[$ enemy_id];
            selected_enemy_acts = variable_struct_get_names(enemy_info[$ "ACTS"]);
            
            // Reset ACT selection
            act_choice = 0;
            act_response_index = 0;
            current_act = "";
			
			WRITER.dialogue.dialogueText = "";
            
            // Create ACT menu display
            create_act_menu_display();
            
            battle_set_menu_state("menuActCall");
            
        } else if (input.up_pressed || input.down_pressed) {
            // Reuse your existing enemy selection logic
            do {
                enemyChoice = (enemyChoice + 3 + input.down_pressed - input.up_pressed) % 3;
            } until (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][@ enemyChoice] != noone);
            sfx_play(snd_menu_switch);
            
        } else if (input.cancel_pressed) {
            WRITER.dialogue.dialogueText = "";
            battle_set_menu_state("menuBegin");
           
        }
        break;
    #endregion

       #region Display ACTs
case "menuActCall":
    var total_acts = array_length(selected_enemy_acts);
    var half = ceil(total_acts / 2);
    
    // Make sure menu is visible
    if (instance_exists(_menu1)) _menu1.visible = true;
    if (instance_exists(_menu2)) _menu2.visible = true;
    
    // Heart positioning
    if (act_choice < half) {
        HEART.x = 72;
        HEART.y = 270 + 32 * act_choice;
    } else {
        HEART.x = 72 + 283;
        HEART.y = 270 + 32 * (act_choice - half);
    }
    
    if (input.action_pressed) {
        // Get selected ACT
        current_act = selected_enemy_acts[act_choice];
		 show_debug_message("Selected ACT: " + current_act);
        
        // Check if ACT is repeatable and get current response index
        var enemy_info = global.ENEMY_INFO[$ selected_enemy_id];
        var act_data = enemy_info[$ "ACTS"][$ current_act];
        var act_key = selected_enemy_id + "_" + current_act;
		
        WRITER.dialogue.dialogueText = "";
        
        if (act_data.repeatable) {
            // For repeatable ACTs: use stored progress
            if (!variable_instance_exists(id, "act_progress_" + act_key)) {
                self[$ "act_progress_" + act_key] = 0;
            }
            act_response_index = self[$ "act_progress_" + act_key];
        } else {
            // For non-repeatable: check if already completed
            if (array_contains(completed_acts, act_key)) {
                // Already completed - show final response
                act_response_index = array_length(act_data.responses) - 1;
            } else {
                // First time - start from beginning
                act_response_index = 0;
            }
        }
        
        WRITER.dialogue.dialogueText = "";
        battle_set_menu_state("menuActResponse");
        HEART.visible = false;
        sfx_play(snd_menu_select);
        
    } else if (input.up_pressed || input.down_pressed) {
        var old_choice = act_choice;
        if (input.up_pressed) {
            act_choice = (act_choice - 1 + total_acts) % total_acts;
        } else if (input.down_pressed) {
            act_choice = (act_choice + 1) % total_acts;
        }
        sfx_play(snd_menu_switch);
    } else if (input.left_pressed || input.right_pressed) {
        // Switch between left and right columns
        var old_choice = act_choice;
        if (input.left_pressed && act_choice >= half) {
            act_choice = act_choice - half;
        } else if (input.right_pressed && act_choice < half && (act_choice + half) < total_acts) {
            act_choice = act_choice + half;
        }
        if (act_choice != old_choice) {
            sfx_play(snd_menu_switch);
        }
    } else if (input.cancel_pressed) {
        // Return to enemy selection
        if (instance_exists(_menu1)) instance_destroy(_menu1);
        if (instance_exists(_menu2)) instance_destroy(_menu2);
        battle_set_menu_state("menuActSelect");
         
    }
    break;
#endregion

        case "menuActResponse":
    HEART.visible = false;
    with HEART {
        if (layer_exists(layer_get_id("menuHeart"))) layer_destroy(layer_get_id("menuHeart"));
    }
    
    // Hide ACT menu display
    if (instance_exists(_menu1)) _menu1.visible = false;
    if (instance_exists(_menu2)) _menu2.visible = false;
    
    var enemy_info = global.ENEMY_INFO[$ selected_enemy_id];
    var act_data = enemy_info[$ "ACTS"][$ current_act];
    var responses = act_data.responses;
    
    // Show current response
    if (WRITER.dialogue.dialogueText != string(responses[act_response_index])) {
        WRITER.dialogue.dialogueText = string(responses[act_response_index]);
        WRITER.typist.reset();
    }
    
    // Check if text typing is finished
    if (WRITER.typist.get_state() == 1) {
        // Text finished typing - call on_act NOW (don't wait for button press)
        if (!_on_act_called) {
            show_debug_message("Text finished for: " + current_act);
            
            // Check if we're at the final response for this ACT
            var act_key = selected_enemy_id + "_" + current_act;
            var is_final_response = false;
            
            if (act_data.repeatable) {
                var progress = self[$ "act_progress_" + act_key] || 0;
                is_final_response = (progress == array_length(responses) - 1);
            } else {
                is_final_response = (act_response_index >= array_length(responses) - 1);
            }
            
            if (is_final_response) {
                // Call on_act if it exists
                if (variable_struct_exists(act_data, "on_act")) {
                    var on_act_func = act_data[$ "on_act"];
                    if (typeof(on_act_func) == "function" || typeof(on_act_func) == "method") {
                        show_debug_message("✓ Calling on_act for: " + current_act);
                        on_act_func();
                        _on_act_called = true;
                    }
                }
            } else {
				 // Call on_act if it exists
                if (variable_struct_exists(act_data, "on_act")) {
                    var on_act_func = act_data[$ "on_act"];
                    if (typeof(on_act_func) == "function" || typeof(on_act_func) == "method") {
                        show_debug_message("✓ Calling on_act for: " + current_act);
                        on_act_func();
                        _on_act_called = true;
                    }
				}
			}
        }
        
        // Now wait for button press to continue
        if (input.action_pressed) {
            var act_key = selected_enemy_id + "_" + current_act;
            
            // Handle ACT completion and progression
            if (act_data.repeatable) {
                 // Get current progress
                if (!variable_instance_exists(id, "act_progress_" + act_key)) {
                    self[$ "act_progress_" + act_key] = 0;
                }
                var progress = self[$ "act_progress_" + act_key];
                var current_response_index = progress;
                
                // Increment progress (loop back to 0 if at the end)
                progress = (progress + 1) % array_length(responses);
                self[$ "act_progress_" + act_key] = progress;
                
                show_debug_message("Progress updated: " + string(current_response_index) + " -> " + string(progress));
                
                // Check if we just completed all responses (reached the last one before looping)
                if (current_response_index == array_length(responses) - 1) {
                    show_debug_message("Completed all responses for repeatable ACT");
                    
                    // Only process mercy effect if it exists and is > 0
                    if (variable_struct_exists(act_data, "mercy_effect") && act_data.mercy_effect > 0) {
                        update_mercy_progress(selected_enemy_id, current_act, act_data.mercy_effect);
                        check_mercy_requirements(selected_enemy_id);
                    }
                }
            } else {
                // NON-REPEATABLE ACT logic...
                if (act_response_index < array_length(responses) - 1) {
                    act_response_index++;
                } else {
                    if (!array_contains(completed_acts, act_key)) {
                        array_push(completed_acts, act_key);
                    }
                    
                    // Only process mercy effect if it exists and is > 0
                    if (variable_struct_exists(act_data, "mercy_effect") && act_data.mercy_effect > 0) {
                        update_mercy_progress(selected_enemy_id, current_act, act_data.mercy_effect);
                        check_mercy_requirements(selected_enemy_id);
                    }
                }
            }
            
            // Reset the flag
            _on_act_called = false;
            
            // ALWAYS clear dialogue and go to enemy turn when action is pressed
            WRITER.dialogue.dialogueText = "";
            if (instance_exists(_menu1)) instance_destroy(_menu1);
            if (instance_exists(_menu2)) instance_destroy(_menu2);
            battle_set_menu_state("enemyTurn");
        }
    }
    break;
    #endregion
	
    #region ITEM STATES
    #region Select Item
    case "menuItemSelect":
        noone_c = 0;
        // Count only consumable items and create filtered array
        var consumable_items = [];
        var inventory = global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"];
        for (var i = 0; i < array_length(inventory); i++) {
            if (item_get_category(inventory[i]) == "CONSUMABLE") {
                array_push(consumable_items, i);
            }
        }

        // Update noone_c counting only consumables
        for (var i = 0; i < array_length(consumable_items); i++) {
            if (i < itemChoice && global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"][consumable_items[i]] == noone) {
                noone_c++;
            }
        }

        HEART.x = 72 + 283 * (itemChoice % 1) * 2;
        HEART.y = 305 + _temped;
        WRITER.dialogue.dialogueText = "";
        item_l = array_length(consumable_items);

        if (!instance_exists(_menu1)) {
            _menu1 = instance_create(0, 0, obj_text_writer);
        }
        with (_menu1) {
            dialogue.dialogueFont = loc_get_font("fnt_main_bt");
            x = 52;
            dialoguePosition = "none";
            _speed = 0.95;
            dialogue.dialogueText = "";
        }
        if (!instance_exists(_menu2)) {
            _menu2 = instance_create(0, 0, obj_text_writer);
        }
        with (_menu2) {
            dialogue.dialogueFont = loc_get_font("fnt_main_bt");
            x = 52;
            dialoguePosition = "none";
            _speed = 0.95;
            dialogue.dialogueText = "";
        }

        h_inven = ceil(array_length(consumable_items) / 2);

        if (abs(_temped) >= 3) {
            _temped = (sign(_temped) * (_temped - (sign(_temped) * 3)) % (h_inven * 29)) * sign(_temped);
        } else {
            _temped = 0;
        }

        _menu1.y = 290 - (itemChoice div 1) * 29 + _temped;
        _menu2.y = 290 - (itemChoice div 1) * 29 + _temped;

        for (i = 0; i < h_inven; i++) {
            var left_index = i * 2;
            var right_index = i * 2 + 1;

            _menu1.dialogue.dialogueText += (left_index >= item_l ? "" : ("[alpha," + string(1 + abs((itemChoice div 1) - i - _temped / 29) * -0.5) + "]\t\t* " + item_get_attribute(inven_get_item(consumable_items[left_index]), (serious ? "SERIOUS_NAME" : "SHORT_NAME")))) + "\n";
            _menu2.dialogue.dialogueText += (right_index >= item_l ? "" : ("[alpha," + string(1 + abs((itemChoice div 1) - i - _temped / 29) * -0.5) + "]\t\t\t\t\t\t\t\t\t\t\t\t\t\t* " + item_get_attribute(inven_get_item(consumable_items[right_index]), (serious ? "SERIOUS_NAME" : "SHORT_NAME")))) + "\n";
            _menu1.typist.skip();
            _menu2.typist.skip();
        }

        if (input.up_pressed || input.down_pressed) {
            pchoice = itemChoice;
            itemChoice = (itemChoice + (input.down_pressed - input.up_pressed) + ceil(array_length(consumable_items) / 2 - (itemChoice % 1))) % ceil(array_length(consumable_items) / 2 - (itemChoice % 1));
            sfx_play(snd_menu_switch, 1, global.sfx_volume);
            _temped += (itemChoice - pchoice) * 29;
        } else if (input.left_pressed || input.right_pressed) {
            itemChoice = clamp(itemChoice + ((itemChoice + 0.5) % 1) * 2 - 0.5, 0, (array_length(consumable_items) - 1) / 2);
            sfx_play(snd_menu_switch, 1, global.sfx_volume);
        } else if (input.cancel_pressed) {
            battle_set_menu_state("menuBegin");
        } else if (input.action_pressed && itemChoice < array_length(consumable_items) && member_get_stat(party_get_leader(), "HP") < member_get_stat(party_get_leader(), "MAX_HP")) {
            var actual_index = consumable_items[itemChoice];
            use_text = item_get_use_text(inven_get_item(actual_index));
            inven_use_item(actual_index, 0);
            WRITER.dialogue.dialogueText = use_text;
            if (instance_exists(_menu1)) {
                instance_destroy(_menu1);
            }
            if (instance_exists(_menu2)) {
                instance_destroy(_menu2);
            }
            battle_set_menu_state("menuItemUse");
        } else {
			// do nothing	
		}
        break;
    #endregion

    #region Use Item
    case "menuItemUse":
        if (WRITER.typewriter_state == 1 && input.action_pressed) {
            battle_set_menu_state("enemyTurn");
        }
        break;
    #endregion
    #endregion
	
  #region MERCY STATES
    #region Select Option
    case "menuMercySelect":
        noone_c = 0;
        incr = function(_e, _i) {
            if (_i < mercyChoice && MERCY_OPTIONS[_i] == noone) {
                noone_c++;
            }
        };
        array_foreach(MERCY_OPTIONS, incr);
        HEART.x = 72;
        HEART.y = 270 + 30 * (mercyChoice - noone_c);
        if (input.action_pressed) {
            switch (mercyChoice) {
                case 0:
                    battle_set_menu_state("menuMercySpareSelect");
                    break;
                case 1:
                // FLEE logic
                var fleeChance = random(100) + (10 * currentTurn);
                if (currentTurn >= 1) {
                    fleeChance = (random(100) + (10 * (currentTurn - 1)));
                }
                if (fleeChance > 50) {
                    // SUCCESS: Create runaway soul and end battle
                    ranAway = true;
                    instance_create_depth(HEART.x, HEART.y, -99999999999, obj_runaway_soul);
					HEART.visible = false;
		            if (layer_exists(layer_get_id("menuHeart"))) layer_destroy(layer_get_id("menuHeart"));
                } else {
                    // FAILURE: Show message and return to menuBegin
                    sfx_play(snd_error);
					encounterMenuText = "* I couldn't escape!";
                    battle_set_menu_state("menuBegin");
					 if (layer_exists(layer_get_id("menuHeart"))) layer_destroy(layer_get_id("menuHeart"));
                }
                break;
            }
            with (WRITER) {
                dialogue.dialogueText = "";
            }
        } else if (input.up_pressed || input.down_pressed) {
            mercyChoice = (mercyChoice + 3 + input.down_pressed - input.up_pressed) % 3;
            while (MERCY_OPTIONS[@ mercyChoice] == noone) mercyChoice = (mercyChoice + 3 + input.down_pressed - input.up_pressed) % 3;
            sfx_play(snd_menu_switch);
        } else if (input.cancel_pressed) {
            battle_set_menu_state("menuBegin");
        }
        break;
    #endregion

        #region Select Target To Spare
	    case "menuMercySpareSelect":
			   // FIRST: Make sure enemyChoice points to a valid enemy
		    if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice] == noone) {
		        // Find first non-empty slot
		        for (var i = 0; i < 3; i++) {
		            if (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] != noone) {
		                enemyChoice = i;
		                break;
		            }
		        }
		  }
	
         noone_c = 0;
        incr = function(_e, _i) {
            if (_i < enemyChoice && global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][_i] == noone) {
                noone_c++;
            }
        };
		
		show_debug_message("Enemy choice: " + string(enemyChoice))
        array_foreach(global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"], incr);
        with WRITER {
            dialogue.dialogueText = "";
            HEART.visible = true;
            
            // Build all 3 lines, with empty lines for missing enemies
            for (var i = 0; i < 3; i++) {
                var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i];
                
                 if (enemy_id == noone) {
                    // Empty line for missing enemy
                    dialogue.dialogueText += "[EMPTY]";
                    continue;
                }
                
                var enemy_info = global.ENEMY_INFO[$ enemy_id];
                var enemy_name = enemy_info[$ "NAME"];
                var enemy_obj = global.enc_slot[i];
                
                var is_spareable = instance_exists(enemy_obj) && enemy_obj.SPAREABLE;
                
                // Add bullet point for existing enemy
                dialogue.dialogueText += "\t\t* ";
                
                if (is_spareable) {
                    dialogue.dialogueText += "[c_yellow]" + enemy_name + "[/c]";
                } else {
                    dialogue.dialogueText += enemy_name;
                }
                
                dialogue.dialogueText += "\n";
            }
            
            self.typist.skip();
        }

        
        HEART.x = 72;
        HEART.y = 270 + 30 * (enemyChoice - noone_c);
        HEART.visible = true;
        
        if (input.action_pressed) {
            // Check if selected enemy is spareable
            var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemyChoice];
            var enemy_instance = global.enc_slot[enemyChoice];
            
            show_debug_message("Attempting to spare enemy in slot: " + string(enemyChoice));
            show_debug_message("Enemy instance exists: " + string(instance_exists(enemy_instance)));
            
            if (instance_exists(enemy_instance)) {
                // Check if this enemy is actually spareable
                var is_enemy_spareable = enemy_instance.SPAREABLE;
                show_debug_message("Enemy SPAREABLE flag: " + string(is_enemy_spareable));
                
                // Also check the global enemy info
                var enemy_info = global.ENEMY_INFO[$ enemy_id];
                
                if (is_enemy_spareable) {
                    show_debug_message("Starting sparing process for enemy in slot: " + string(enemyChoice));
                    
                    // Start sparing process - mark the selected enemy for sparing
                    with (enemy_instance) {
                        _is_being_spared = true;
                    }
                    
                    battle_set_menu_state("menuMercySparing");
                    
                } else {
                    // Enemy not spareable - show error
                    sfx_play(snd_error);
					 var enemy_name = global.ENEMY_INFO[$ enemy_id][$ "NAME"];
					 
					encounter_set_menu_text(loc_gettext("bt.spare.fail.0") + " " + enemy_name + loc_gettext("bt.spare.fail.1"))
					battle_set_menu_state("menuBegin")
                }
            } else {
                // Enemy instance doesn't exist
                sfx_play(snd_error);
            }
        } else if (input.up_pressed || input.down_pressed) {
            do {
                enemyChoice = (enemyChoice + 3 + input.down_pressed - input.up_pressed) % 3;
            } until (global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][@ enemyChoice] != noone);
            sfx_play(snd_menu_switch);
        } else if (input.cancel_pressed) {
            battle_set_menu_state("menuMercySelect");
        }
        break;
    #endregion

    #region Sparing Animation
    case "menuMercySparing":
        HEART.visible = false;
        // Process sparing for ALL enemies (including chain sparing with SPARE_WITH_ALLY)
        var any_enemy_spared = false;
        var all_enemies_spared = true;
        
        // First pass: Mark enemies that should be spared
        for (var i = 0; i < 3; i++) {
            var slot_enemy = global.enc_slot[i];
            
            if (slot_enemy != noone && instance_exists(slot_enemy) && !slot_enemy.spared) {
                // Check if this enemy should be spared
                var should_spare = false;
                
                // Directly marked for sparing
                if (slot_enemy._is_being_spared) {
                    should_spare = true;
                }
                // OR if any other enemy in battle group is being spared AND this enemy should be spared with allies
                else {
                    for (var j = 0; j < 3; j++) {
                        if (i != j) {
                            var other_enemy = global.enc_slot[j];
                            if (other_enemy != noone && instance_exists(other_enemy) && 
                                other_enemy._is_being_spared) {
                                
                                // Check if this enemy should be spared when allies are spared
                                var enemy_id = find_enemy_id_by_instance(slot_enemy);
                                if (enemy_id != noone) {
                                    var enemy_info = global.ENEMY_INFO[$ enemy_id];
                                    
                                    // Check for SPARE_WITH_ALLY flag (default to false)
                                    var spare_with_ally = false;
                                    if (variable_struct_exists(enemy_info, "SPARE_WITH_ALLY")) {
                                        spare_with_ally = enemy_info[$ "SPARE_WITH_ALLY"];
                                    }
                                    
                                    if (spare_with_ally) {
                                        should_spare = true;
                                        slot_enemy._is_being_spared = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (should_spare) {
                    any_enemy_spared = true;
                }
            }
        }
        
        // Second pass: Apply sparing effects
        for (var i = 0; i < 3; i++) {
            var slot_enemy = global.enc_slot[i];
            
            if (slot_enemy != noone && instance_exists(slot_enemy) && slot_enemy._is_being_spared) {
                // Apply sparing effects
                with (slot_enemy) {
                    // Visual effects
                    image_alpha = 0.5;
                    image_blend = c_gray;
                    
                    // Change to spare sprite if available
                    if (variable_instance_exists(id, "spare_sprite")) {
                        sprite_index = spare_sprite;
                    }
                    
                    // Mark as spared
                    spared = true;
                    _is_being_spared = false;
                    
                    instance_create_depth(slot_enemy.x,slot_enemy.y,-9999,obj_spared)
                    
                    // Calculate rewards for this enemy
                    var enemy_id_local = find_enemy_id_by_instance(id);
                    if (enemy_id_local != noone) {
                        var enemy_info_local = global.ENEMY_INFO[$ enemy_id_local];
                        if (is_struct(enemy_info_local)) {
                            var enemy_xp = enemy_info_local[$ "XP_GAIN"] ?? 0;
                            var enemy_gold = enemy_info_local[$ "GOLD_GAIN"] ?? 0;
                            
							if (enemy_xp < 0) {
								obj_battle_handler.totalGainEXP += enemy_xp;
							}
                            obj_battle_handler.totalGainGOLD += enemy_gold;
                        }
                    }
                }
                
                // Remove enemy from the enemy list
                global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] = noone;
                global.enc_slot[i] = noone;
                
                // Play spare sound (only once)
                if (!spare_sound_played) {
                    sfx_play(snd_spare);
					party_set_stat("SPARES",party_get_stat("SPARES")+1)
                    spare_sound_played = true;
                }
                
                show_debug_message("Enemy spared and removed from slot: " + string(i));
            }
        }
        
        // Check if all enemies are now spared
        for (var i = 0; i < 3; i++) {
            var slot_enemy = global.enc_slot[i];
            if (slot_enemy != noone && instance_exists(slot_enemy) && !slot_enemy.spared) {
                all_enemies_spared = false;
                break;
            }
        }
        
        // Determine what to do next
        if (all_enemies_spared) {
            // All enemies spared - go to victory screen
            battle_set_menu_state("menuViolentWin");
        } else if (any_enemy_spared) {
            // Some enemies spared
            battle_set_menu_state("enemyTurn");
        } else {
            // No enemies spared (shouldn't happen) - return to menuBegin as fallback
            battle_set_menu_state("menuBegin");
        }
        break;
    #endregion
    #endregion
}