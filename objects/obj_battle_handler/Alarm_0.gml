HEART.visible = true;
if _death != noone {
    // CALCULATE XP AND GOLD GAINS BEFORE DESTROYING THE ENEMY
    // Use _death_i to get the enemy ID directly from the ENEMIES array
    var enemy_id = noone;
    
    if (_death_i != noone) {
        enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][_death_i];
    }
    
    // Now get the enemy info using the string ID
    if (enemy_id != noone && enemy_id != "") {
        // Use struct accessor with $ to get the enemy info
        var enemy_info = global.ENEMY_INFO[$ enemy_id];
        if (is_struct(enemy_info)) {
            var enemy_xp = enemy_info[$ "XP_GAIN"] ?? 0;
			var enemy_gold = enemy_info[$ "GOLD_GAIN"] ?? 0;
            
            // Debug: show what we found
            show_debug_message("Enemy ID: " + string(enemy_id) + " | XP: " + string(enemy_xp));
            
            // Add to total gains
            totalGainEXP += enemy_xp;
			totalGainGOLD += enemy_gold;
            
            // Debug: show total so far
            show_debug_message("Total Gain EXP: " + string(totalGainEXP));
        }
    } else {
        show_debug_message("Could not find enemy ID for _death_i: " + string(_death_i));
    }
    
	if (variable_instance_exists(_death,"hurtSprite")){
	    _procs = sprite_get_height(_death.hurtSprite);
	    _sprites = _death.hurtSprite;
	} else {
		_procs = sprite_get_height(_death.sprite_index);
		_sprites = _death.sprite_index;
	}
    _xs = _death.x;
    _ys = _death.y;
    _xscales = _death.image_xscale;
    _yscales = _death.image_yscale;
    _blends = _death.image_blend;
    _alphas = _death.image_alpha;
    instance_destroy(_death);
    global.enc_slot[_death_i] = noone;
    global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][@ _death_i] = noone;
    _death_i = noone;
    _death = noone;
    wiped = true;
    sfx_play(snd_dusted,1,global.sfx_volume)
    var kills = flag_get(global.flags,"section_kills");
    flag_set(global.flags,"section_kills",kills + 1)
    party_set_stat("KILLS",party_get_stat("KILLS")+1)
    array_foreach(global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"], function(_e, _i) {
        if (_e != noone) {
            wiped = false;
        }
    });
    if (wiped) { 
        battle_set_menu_state("menuViolentWin");
    } else {
        battle_set_menu_state("enemyTurn");
    }
} else {
    battle_set_menu_state("enemyTurn");
}