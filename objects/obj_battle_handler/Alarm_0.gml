HEART.visible = true;

if (_death != noone) {
    // --- Existing XP & GOLD logic ---
    var enemy_id = noone;
	var enemy_name = "";
    if (_death_i != noone) {
        enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][_death_i];
    }

    if (enemy_id != noone && enemy_id != "") {
        var enemy_info = global.ENEMY_INFO[$ enemy_id];
		var enemy_name = global.ENEMY_INFO[$ enemy_id][$ "NAME"]
        if (is_struct(enemy_info)) {
            var enemy_xp = enemy_info[$ "XP_GAIN"] ?? 0;
            var enemy_gold = enemy_info[$ "GOLD_GAIN"] ?? 0;
            totalGainEXP += enemy_xp;
            totalGainGOLD += enemy_gold;
        }
    }

    // --- Capture sprite & properties for vaporizer ---
    if (variable_instance_exists(_death,"hurtSprite")) {
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

    // --- CREATE VAPORIZER ---
    var v_inst = create_vaporizer(_death,
        string_lower(enemy_name) + ".vap"  // vapor file, adjust naming as needed
    );

    if (v_inst != noone) {
        v_inst.image_xscale = _xscales;
        v_inst.image_yscale = _yscales;
        v_inst.image_blend = _blends;
        v_inst.image_alpha = _alphas;
    }

    // --- Destroy the enemy instance ---
    instance_destroy(_death);
    global.enc_slot[_death_i] = noone;
    global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][@ _death_i] = noone;
    _death_i = noone;
    _death = noone;

    // --- Rest of the battle & flags logic ---
    wiped = true;
    sfx_play(snd_dusted,1,global.sfx_volume);
    var kills = flag_get(global.flags,"section_kills");
    flag_set(global.flags,"section_kills",kills + 1);
    party_set_stat("KILLS",party_get_stat("KILLS")+1);
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
