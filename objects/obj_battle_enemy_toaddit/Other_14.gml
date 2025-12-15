//@desc Turn End
with (obj_battle_handler){
	battleMenuSelection	= 1;
}
if (instance_exists(obj_battle_enemy_whimsun) && !obj_battle_enemy_whimsun.spared){
	encounter_set_menu_text(choose(loc_gettext("bt.group.toaddit_whimsun.0"),loc_gettext("bt.group.toaddit_whimsun.1")));
} else {

	if (id.SPAREABLE){
		encounter_set_menu_text(loc_gettext("enemy.toaddit.spare.condition"));
	} else {
		if (id == global.enc_slot[obj_battle_handler.enemyChoice] && _hp < _hp_max / 2){
			encounter_set_menu_text(loc_gettext("enemy.toaddit.low_hp"));
		} else {
			encounter_set_menu_text(choose(loc_gettext("enemy.toaddit.flavor.0"),loc_gettext("enemy.toaddit.flavor.1"),loc_gettext("enemy.toaddit.flavor.2"),loc_gettext("enemy.toaddit.flavor.3"),loc_gettext("enemy.toaddit.flavor.4")));
		}
	}
}