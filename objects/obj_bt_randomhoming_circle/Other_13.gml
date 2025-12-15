///@desc Turn End
for (var i = 0; i < bullet_count; i++) {
    if (instance_exists(bullet_array[i])) {
        instance_destroy(bullet_array[i]);
    }
}

if obj_battle_enemy_loox.bullying {
	switch(obj_battle_enemy_loox._bullied){
		case 1:
			encounter_set_menu_text("* Loox avoids eye contact with me.");
		break;
		case 2:
			encounter_set_menu_text("* Loox apologizes silently.");
		break;
		case 3:
			encounter_set_menu_text("* Loox takes EMOTIONAL DAMAGE.#* Loox's DEFENSE dropped to 3!");
			var _ec = obj_battle_handler.enemyChoice
			var _mon = obj_battle_enemy_loox
			enemy_set_stat(_ec,"HP",_mon._hp - 5)
			enemy_set_stat(_ec,"DEF",-3)
		break;
	}
} else if obj_battle_enemy_loox.SPAREABLE {
		encounter_set_menu_text("* Loox has given up fighting.")
}


battle_set_menu_state("menuBegin")
BOARD.reset();
instance_destroy();