///@desc Turn End
for (var i = 0; i < bullet_count; i++) {
    if (instance_exists(bullet_array[i])) {
        instance_destroy(bullet_array[i]);
    }
}
obj_battle_enemy_whimsun.image_alpha = 1;
if obj_battle_enemy_whimsun._terrorized {
	encounter_set_menu_text(loc_gettext("enemy.whimsun.flavor.terrorize"));
} else if !obj_battle_enemy_whimsun.spared {
	encounter_set_menu_text(choose(loc_gettext("enemy.whimsun.flavor.0"),loc_gettext("enemy.whimsun.flavor.1"),loc_gettext("enemy.whimsun.flavor.2"),loc_gettext("enemy.whimsun.flavor.3")));
} else {
	
}
battle_set_menu_state("menuBegin")
BOARD.reset();
instance_destroy();