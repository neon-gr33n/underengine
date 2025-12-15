///@desc Init
event_inherited();

hurtSprite = spr_battle_enemy_whimsun_hurt

// enemy specific variables
_terrorized = false;
_consoled = false;

if (instance_exists(obj_battle_enemy_toaddit)){
	encounter_set_menu_text(choose(loc_gettext("bt.group.toaddit_whimsun.0"),loc_gettext("bt.group.toaddit_whimsun.1")));
} else {
	encounter_set_menu_text(choose(loc_gettext("enemy.whimsun.flavor.0"),loc_gettext("enemy.whimsun.flavor.1"),loc_gettext("enemy.whimsun.flavor.2"),loc_gettext("enemy.whimsun.flavor.3")));
}