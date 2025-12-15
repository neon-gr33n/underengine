event_inherited();

SPAREABLE = true;
event_user(0)

remaining_enemies = 0;

function console_spare_enemy() {
    // This function mimics the sparing process from menuMercySparing
    // but without awarding XP or gold
	show_debug_message("Whimsun is consoled!")
    // Create visual effect
    var spare_effect = instance_create_depth(x, y, -9999, obj_spared);
    
    // Play sound
    sfx_play(snd_spare);
    
    // Mark as spared
    spared = true;
    
    // Visual changes
    image_alpha = 0.5;
    image_blend = c_gray;
    
    // Find this enemy in the slot array
    var enemy_index = -1;
    for (var i = 0; i < 3; i++) {
        if (global.enc_slot[i] == id) {
            enemy_index = i;
            break;
        }
    }
    
    if (enemy_index != -1) {
        // Remove from arrays (like in menuMercySparing)
        global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][enemy_index] = noone;
        global.enc_slot[enemy_index] = noone;
    }
    
    // Check if battle should end
    remaining_enemies = 0;
    for (var i = 0; i < 3; i++) {
        if (global.enc_slot[i] != noone && instance_exists(global.enc_slot[i])) {
            remaining_enemies++;
        }
    }
    
    if (remaining_enemies == 0) {
        // No enemies left - schedule battle end
        // Use a short delay to show the text
        alarm[0] = 60; // 1 second at 30 FPS
    } else {
        // Other enemies remain - continue battle
		if (instance_exists(WRITER)){
			WRITER.dialogue.dialogueText=""	
		}
        battle_set_menu_state("enemyTurn");
    }
}
	