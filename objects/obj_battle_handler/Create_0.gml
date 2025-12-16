_death=noone // Instance of a dead enemy
serious=true // "SERIOUS" Mode (shortens item names and removes puns)
_death_speed = 2; // Determines the speed of the "dusting" effect
_procs=0
battleMenuSelection = 1  // Set to 1 by default inside of 0 so that ACT is the default option
battleButtonTweenable = false;  // Automatically updated via global.__ute_tween_battle_button
spare_sound_played = false; // Has the spare sound played?

with (obj_text_writer){
	dialogue.dialogueFont = scribble_get_font("fnt_main_bt")
	dialoguePosition = "battle_generic"
	_speed = 0.95;
}
tweened=0	
selected_enemy_id = noone;
selected_enemy_acts = [];
current_act = "";
act_response_index = 0;  // The index to use for the current ACTs response
completed_acts = []; // keeps track of what ACTs you have completed
enemy_mercy_state = {}; 
act_choice = 0; // The currently selected act index
encounterMenuText = "" // The text to display during your turn
fightAlpha = 0;
enemyChoice = 0; // The currently selected enemy index
itemChoice = 0; // The currently selected item index (CONSUMABLES ONLY)
mercyChoice=0; 
currentTurn = 0;
ranAway = false; // Is the player trying to run away?
MERCY_OPTIONS=[loc_gettext("bt.mercy.0"),loc_gettext("bt.mercy.1")] // The list of options that'll dis
showEnemyList = false;  // Determines whether or not to display the enemy list
totalGainEXP = 0;	// Total EXP gained during a fight
totalGainGOLD = 0;	// Total GOLD gained during a fight
_death_particles = []

_inven=global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"]
_max_inven=global.PARTY_INFO[$ "__PARTY__"][$ "MAXINVSIZE"]
			
_invcol0 = ""
_invcol1 = ""

use_text = "";



_menu1 = noone;
_menu2 = noone;
//display_set_gui_size(640,480)
checkTweenable = function()
{
	if(UTE_TWEEN_BATTLE_BUTTON){
		battleButtonTweenable = true;
	} else {
		battleButtonTweenable = false;
	}
}

function awardBattleRewards(canGainXP = false, spared = false) {
    // Debug: check what's in totalGainEXP and totalGainGOLD
    show_debug_message("=== BATTLE END ===");
    show_debug_message("totalGainEXP value: " + string(totalGainEXP));
    show_debug_message("totalGainGOLD value: " + string(totalGainGOLD));

    // Handle XP gain logic
    var xp_gained = 0;
    if (canGainXP) {
        if (spared) {
            // For sparing: Only gain XP if it's negative (player loses XP)
            if (totalGainEXP < 0) {
                xp_gained = totalGainEXP;
            }
            // If XP is positive or zero, no XP gain when sparing
        } else {
            // For violent win: Gain all XP normally
            xp_gained = totalGainEXP;
        }
    }

    // Handle gold gain logic
    var gold_gained = 0;
    if (spared) {
        // For sparing: Triple gold
        gold_gained = totalGainGOLD;
    } else {
        // For violent win: Normal gold
        gold_gained = totalGainGOLD * 3;
    }

    // Debug: show what we're about to award
    show_debug_message("Awarding XP: " + string(xp_gained));
    show_debug_message("Awarding GOLD: " + string(gold_gained));
    
    var old_level = member_get_stat(party_get_leader(), "LV");
    show_debug_message("Previous party EXP: " + string(member_get_stat(party_get_leader(), "EXP")));
    show_debug_message("Previous party LV: " + string(old_level));

    // Build victory message based on battle type
    var msg = "";
    msg = loc_gettext("bt.victory.msg.0");
    
    // Add XP info if applicable
    if (xp_gained != 0) {
        if (xp_gained > 0) {
            msg += loc_gettext("bt.earn.msg") + " " + string(xp_gained) + " EXP";
        } else {
            msg +=loc_gettext("bt.lost.msg") + " " + string(abs(xp_gained)) + " EXP";
        }
    }
    
    // Add gold info if applicable
    if (gold_gained > 0) {
        if (xp_gained != 0) {
            msg += loc_gettext("bt.and.msg") + " " +  string(gold_gained) + " gold.";
        } else {
            msg += loc_gettext("bt.earn.msg") + " " + string(gold_gained) + " gold.";
        }
    }

    // Actually award the XP to the player (negative values will subtract)
    if (xp_gained != 0) {
        member_change_stat(party_get_leader(), "EXP", xp_gained);
    }
    
    // Actually award GOLD to the player
    if (gold_gained != 0) {
        party_change_stat("GOLD", gold_gained);
    }
    
    // Check if LOVE has increased (only if XP was gained)
    if (xp_gained > 0) {
        var old_exp = member_get_stat(party_get_leader(), "EXP") - xp_gained; // EXP before award
        member_update_stats(party_get_leader());
        var new_level = member_get_stat(party_get_leader(), "LV");

        if (new_level > old_level) {
            msg += "#* My LOVE increased!";
        }

        // Debug: show new stats
        show_debug_message("New party EXP: " + string(member_get_stat(party_get_leader(), "EXP")));
        show_debug_message("New party LV: " + string(new_level));
    } else if (xp_gained < 0) {
        // Handle XP loss
        member_update_stats(party_get_leader());
    }

    WRITER.dialogue.dialogueText = msg;

    // Mark as processed
    rewards_awarded = true;
}


#region DEFINE MENU BEGIN STATE
stateMenuBegin = function ()
{
	HEART.stateMenuSoul();
	currentState = "menuBegin";
	checkTweenable();
	HEART.image_alpha = 1;
	HEART.visible = true;
}
#endregion

#region DEFINE FIGHT STATE
stateMenuFight = function ()
{
	for (i = 0; i < 3; i++) {
			if global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i] != noone {
				enemyChoice = i;
				break;
			}
		}
		 with WRITER {
		    dialogue.dialogueText = "";
		    HEART.visible = true;
    
		    // Build all 3 lines, with empty lines for missing enemies
		    for (var i = 0; i < 3; i++) {
		        var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i];
				show_debug_message("Slot " + string(i) + ": " + (enemy_id == noone ? "EMPTY" : enemy_id));
        
		        if (enemy_id == noone) {
		            // Empty line for missing enemy
		            dialogue.dialogueText += "[EMPTY]";
		            continue;
		        }
        
		        // Add bullet point for existing enemy
		        dialogue.dialogueText += "\t\t* ";
        
		        var enemy_info = global.ENEMY_INFO[$ enemy_id];
		        var enemy_name = enemy_info[$ "NAME"];
		        var enemy_obj = global.enc_slot[i];
        
		         var is_spareable = instance_exists(enemy_obj) && enemy_obj.SPAREABLE;
        
				
		        if (is_spareable) {
		            dialogue.dialogueText += "[c_yellow]" + enemy_name + "[/c]";
		        } else {
		            dialogue.dialogueText += enemy_name;
		        }
        
		        dialogue.dialogueText += "\n";
		    }
    
		    self.typist.skip();
		}
	///@desc Initialize
	image_xscale = 0;
	image_yscale = 1;
	_indexed = 0;
	bar_info = item_get_attribute(member_get_stat(party_get_member(_indexed), "WEAPON"), "BARS");
	for (i=0;i<array_length(bar_info[$ "INFO"]);i++) {
		rec_speed[i]=bar_info[$ "INFO"][i][$ "SPEED"];
		rec_x[i]=40
		rec_alpha[i]=1
		missed[i]=false
		done[i]=false
		tween[i]=noone
		rec_img[i]=0
		done_proc[i]=0
		undone_proc[i]=0
		rec_side[i]=(bar_info[$ "INFO"][i][$ "SIDE"]=="RAND" ? choose("LEFT","RIGHT") : bar_info[$ "INFO"][i][$ "SIDE"])
		//tweenrec[i] = TweenFire(self,EaseLinear,0,0,,566/rec_speed[i],"rec_x[| i]",40,640-40);
	}
	fight_done=false
	fight_anim_i=-1
	target_xs=0
	currentState = "menuFightSelect"
	//var inst=instance_create_depth(320,300,-99999,obj_battle_fight_target);
	//inst.enemyChoice = enemyChoice;
	//instance_create_depth(37,300,-999999,obj_battle_fight_reticle);
}
#endregion

#region DEFINE ACT STATE
stateMenuAct = function ()
{
	for (i=0;i<3;i++) {
		if global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i]!=noone {
			enemyChoice=i
			break;
		}
	}
	currentState = "menuActSelect"
	showEnemyList = true;
	 with WRITER {
		    dialogue.dialogueText = "";
		    HEART.visible = true;
    
		    // Build all 3 lines, with empty lines for missing enemies
		    for (var i = 0; i < 3; i++) {
		        var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i];
				show_debug_message("Slot " + string(i) + ": " + (enemy_id == noone ? "EMPTY" : enemy_id));
        
		        if (enemy_id == noone) {
		            // Empty line for missing enemy
		            dialogue.dialogueText += "[EMPTY]";
		            continue;
		        }
        
		        // Add bullet point for existing enemy
		        dialogue.dialogueText += "\t\t* ";
        
		        var enemy_info = global.ENEMY_INFO[$ enemy_id];
		        var enemy_name = enemy_info[$ "NAME"];
		        var enemy_obj = global.enc_slot[i];
        
		         var is_spareable = instance_exists(enemy_obj) && enemy_obj.SPAREABLE;
        
		        if (is_spareable) {
		            dialogue.dialogueText += "[c_yellow]" + enemy_name + "[/c]";
		        } else {
		            dialogue.dialogueText += enemy_name;
		        }
        
		        dialogue.dialogueText += "\n";
		    }
    
		    self.typist.skip();
		}
}
#endregion

#region DEFINE ITEM STATE
stateMenuItem = function()
{
	currentState = "menuItemSelect"
	WRITER.dialogue.dialogueText=""
}
#endregion

#region DEFINE MERCY STATE
stateMenuMercy = function()
{
	for (i=0;i<2;i++) {
		if MERCY_OPTIONS[i]!=noone {
			mercyChoice=i
			break;
		}
	}
	with WRITER {
		dialogue.dialogueText=""
		var a_noone_c=0
		for (i=0;i<2;i++) {
			var option_text = obj_battle_handler.MERCY_OPTIONS[i]==noone ? "" : obj_battle_handler.MERCY_OPTIONS[i]
			
			// Check if any enemy is spareable for the Spare option (index 0)
			if (i == 0 && option_text ==loc_gettext("bt.mercy.0")) {
				var any_spareable = false;
				for (var j = 0; j < 3; j++) {
					var enemy_obj = global.enc_slot[j];
					if (instance_exists(enemy_obj) && enemy_obj.SPAREABLE) {
						any_spareable = true;
						break;
					}
				}
				
				if (any_spareable) {
					dialogue.dialogueText += "\t\t* [c_yellow]" + option_text + "[/c]\n"
				} else {
					dialogue.dialogueText += "\t\t* " + option_text + "\n"
				}
			} else if (obj_battle_handler.MERCY_OPTIONS[i]==noone) {
				a_noone_c++
			} else {
				dialogue.dialogueText += "\t\t* " + option_text + "\n"
			}
		}
		for (i=0;i<a_noone_c;i++)
			dialogue.dialogueText+="[c_grey]------------[/c]\n"
		self.typist.skip();
	}
	currentState = "menuMercySelect"
}
#endregion

#region Helper functions
// Helper function for array_contains if not already defined

#region ACTing funcs
// Helper functions for ACT system (must be outside the switch statement)
// Helper functions for ACT system (must be outside the switch statement)
function create_act_menu_display() {
    if (instance_exists(_menu1)) instance_destroy(_menu1);
    if (instance_exists(_menu2)) instance_destroy(_menu2);

    _menu1 = instance_create(0, 0, obj_text_writer);
    with (_menu1) {
        dialogue.dialogueFont = loc_get_font("fnt_main_bt");
        dialoguePosition = "battle_generic";
        _speed = 0.95;
        dialogue.dialogueText = "";
    }

    _menu2 = instance_create(0, 0, obj_text_writer);
    with (_menu2) {
        dialogue.dialogueFont = loc_get_font("fnt_main_bt");
        dialoguePosition = "battle_generic";
        _speed = 0.95;
        dialogue.dialogueText = "";
    }

    // Get the enemy info and ACTs struct
    var enemy_info = global.ENEMY_INFO[$ selected_enemy_id];
    var enemy_acts_struct = enemy_info[$ "ACTS"];
	
	_on_act_called = false;
    
    // Get the ACT names in the order they appear in the struct
    var act_names = variable_struct_get_names(enemy_acts_struct);
	 show_debug_message("Available ACTs for " + selected_enemy_id + ": " + string(act_names));
    
    // Reorder the array so "Check" is first if it exists
    var ordered_acts = [];
    var has_check = false;
    
    // First, add "Check" if it exists
    if (array_contains(act_names, "Check")) {
        array_push(ordered_acts, "Check");
        has_check = true;
    }
    
    // Then add all other ACTs in their original order
    for (var i = 0; i < array_length(act_names); i++) {
        var act_name = act_names[i];
        if (act_name != "Check") {
            array_push(ordered_acts, act_name);
        }
    }
    
    // Use the ordered array for display
    var half = ceil(array_length(ordered_acts) / 2);
    for (var i = 0; i < half; i++) {
        var act1 = ordered_acts[i];
        var act2 = (i + half < array_length(ordered_acts)) ? ordered_acts[i + half] : "";
        
        // Get the act structs
        var act1_struct = enemy_acts_struct[$ act1];
        var act2_struct = (act2 != "") ? enemy_acts_struct[$ act2] : undefined;
        
        // Call the display_name() function from each act struct
        var display_act1 = act1_struct.display_name();
        
        _menu1.dialogue.dialogueText += "\t\t* " + display_act1 + "\n";
        
        if (act2 != "") {
            // Call the display_name() function for act2
            var display_act2 = act2_struct.display_name();
             if (global.LOC == "JAPANESE") {
                // Fewer tabs for Japanese (proportional font needs less spacing)
                _menu2.dialogue.dialogueText += "\t\t\t\t\t\t\t* " + display_act2 + "\n";
            } else {
                // Original spacing for English/French
                _menu2.dialogue.dialogueText += "\t\t\t\t\t\t\t\t\t\t\t\t\t\t* " + display_act2 + "\n";
            }
        }

        _menu1.typist.skip();
        _menu2.typist.skip();
    }
    
    // Update the selected_enemy_acts array to match the new order
    selected_enemy_acts = ordered_acts;
}

function handle_act_completion() {
    var enemy_info = global.ENEMY_INFO[$ selected_enemy_id];
    var act_data = enemy_info[$ "ACTS"][$ current_act];

    var act_key = selected_enemy_id + "_" + current_act;
    if (!array_contains(completed_acts, act_key)) {
        array_push(completed_acts, act_key);
    }

    // Only process mercy effect if it exists and is > 0
    if (variable_struct_exists(act_data, "mercy_effect") && act_data.mercy_effect > 0) {
        update_mercy_progress(selected_enemy_id, current_act, act_data.mercy_effect);
    }

    // Only check mercy requirements for enemies that HAVE them
    if (variable_struct_exists(enemy_info, "MERCY_REQUIREMENTS")) {
        check_mercy_requirements(selected_enemy_id);
    }
}
function update_mercy_progress(enemy_id, act_name, mercy_value) {
    show_debug_message("=== update_mercy_progress: " + act_name + " for enemy: " + string(enemy_id) + ", value: " + string(mercy_value));
    
    var enemy_info = global.ENEMY_INFO[$ enemy_id];
    
    // Only track mercy progress for enemies that HAVE requirements
    if (!variable_struct_exists(enemy_info, "MERCY_REQUIREMENTS")) {
        show_debug_message("Enemy has no MERCY_REQUIREMENTS, skipping mercy tracking");
        return;
    }
    
    if (!variable_struct_exists(enemy_mercy_state, enemy_id)) {
        enemy_mercy_state[$ enemy_id] = {
            mercy_points: 0,
            completed_acts: []
        };
    }

    var state = enemy_mercy_state[$ enemy_id];
    state.mercy_points += mercy_value;

    if (!array_contains(state.completed_acts, act_name)) {
        array_push(state.completed_acts, act_name);
        show_debug_message("Added " + act_name + " to completed_acts for enemy " + string(enemy_id));
    }
    
    show_debug_message("Current state - mercy_points: " + string(state.mercy_points) + ", completed_acts: " + string(state.completed_acts));
    
    // Only check requirements for enemies that have them
    check_mercy_requirements(enemy_id, global.enc_slot[obj_battle_handler.enemyChoice]);
}
	
function check_mercy_requirements(enemy_id, target_instance) {
    show_debug_message("=== check_mercy_requirements called for enemy_id: " + string(enemy_id) + ", instance: " + string(target_instance));
    
    var enemy_info = global.ENEMY_INFO[$ enemy_id];
    
    // If enemy has NO MERCY_REQUIREMENTS, they're immediately spareable (like Whimsun)
    if (!variable_struct_exists(enemy_info, "MERCY_REQUIREMENTS")) {
        show_debug_message("No MERCY_REQUIREMENTS found - enemy is immediately spareable");
        
        // Only update the specific instance that was passed
        if (target_instance != noone && instance_exists(target_instance)) {
            // Verify this is the correct enemy type
            var expected_object = enemy_info[$ "OBJECT"];
            if (target_instance.object_index == expected_object) {
                target_instance.SPAREABLE = true;
                show_debug_message(global.ENEMY_INFO[$ enemy_id][$ "NAME"] + " (instance " + string(target_instance.id) + ") is spareable from the start!");
                return true;
            } else {
                show_debug_message("Warning: Target instance is not the correct enemy type");
            }
        }
        return true;
    }
    
    // Only proceed with mercy requirement checks if MERCY_REQUIREMENTS exists
    var requirements = enemy_info[$ "MERCY_REQUIREMENTS"];
    var state = enemy_mercy_state[$ enemy_id];

    if (!state) {
        show_debug_message("No mercy state found for enemy");
        return false;
    }

    var becomes_spareable = false;

    // Check custom logic first
    if (variable_struct_exists(requirements, "custom_check")) {
        show_debug_message("Using custom_check function");
        becomes_spareable = requirements.custom_check(state);
        show_debug_message("custom_check result: " + string(becomes_spareable));
    } else {
        show_debug_message("Using standard requirements check");
        // Check standard requirements
        var required_count = 0;
        if (variable_struct_exists(requirements, "required_count")) {
            required_count = requirements.required_count;
        }
        
        var required_acts = [];
        if (variable_struct_exists(requirements, "required_acts")) {
            required_acts = requirements.required_acts;
        }

        var completed_count = 0;
        for (var i = 0; i < array_length(required_acts); i++) {
            if (array_contains(state.completed_acts, required_acts[i])) {
                completed_count++;
            }
        }

        becomes_spareable = (completed_count >= required_count);
        show_debug_message("Standard check - completed_count: " + string(completed_count) + ", required_count: " + string(required_count) + ", result: " + string(becomes_spareable));
    }

    if (becomes_spareable) {
        // Only update the specific instance that was passed
        if (target_instance != noone && instance_exists(target_instance)) {
            // Verify this is the correct enemy type
            var expected_object = enemy_info[$ "OBJECT"];
            if (target_instance.object_index == expected_object) {
                target_instance.SPAREABLE = true;
                show_debug_message(global.ENEMY_INFO[$ enemy_id][$ "NAME"] + " (instance " + string(target_instance.id) + ") can now be spared! (instance SPAREABLE set)");
            } else {
                show_debug_message("Warning: Target instance is not the correct enemy type for " + enemy_id);
            }
        } else {
            show_debug_message("Warning: No valid target instance provided to mark as spareable");
        }
    } else {
        show_debug_message("Enemy NOT ready to be spared yet");
    }

    return becomes_spareable;
}

function count_spared_enemies() {
    var count = 0;
    for (var i = 0; i < 3; i++) {
        var slot_enemy = global.enc_slot[i];
        if (slot_enemy != noone && instance_exists(slot_enemy) && slot_enemy.spared) {
            count++;
        }
    }
    return count;
}
#endregion


#endregion

stateMenuBegin(); 
currentState = "menuBegin";
_choice=0
	
	