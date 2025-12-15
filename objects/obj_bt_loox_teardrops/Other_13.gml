///@desc Turn End
// Inherit the parent event
event_inherited();

for (var i = 0; i < array_length(_teardrops_array); i++) {
    var bullet = _teardrops_array[i];
    if (instance_exists(bullet)) {
        with (bullet) instance_destroy();
    }
}
_teardrops_array = []; // clear the array

if obj_battle_enemy_loox.SPAREABLE {
		encounter_set_menu_text("* Loox has given up fighting.")
} else if obj_battle_enemy_loox.bullying {
	switch(obj_battle_enemy_loox._bullied){
		case 3:
			encounter_set_menu_text("* Loox takes EMOTIONAL DAMAGE.#* Loox's DEFENSE dropped to 3!");
			var _ec = obj_battle_handler.enemyChoice
			var _mon = obj_battle_enemy_loox
			enemy_set_stat(_ec,"HP",_mon._hp - 5)
			enemy_set_stat(_ec,"DEF",-3)
		break;
	}
}

battle_set_menu_state("menuBegin");
BOARD.reset();
instance_destroy();