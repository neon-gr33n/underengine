if (id == global.enc_slot[obj_battle_handler.enemyChoice]) {
    if (_boss == 0 && _hp < _hp_max / 2) {
        _tired = true;
    }
}

if (hurtSprite != undefined && instance_exists(battle_damage)){
	sprite_index = hurtSprite;
	alarm[0] = 5;
}