depth = -300;

battlegroup = "test";
show_exclamation = true;
fast = false;
boss = false;

cutoutSprite = spr_battle_soul
cutoutDur = 30;
show_black  = false;
show_player = false;
show_soul	= false;
flash = 0;


if (player_exists()) {
	with(PLAYER1){ state = stateCutsceneStasis(); };
}

alarm[0] = 1;