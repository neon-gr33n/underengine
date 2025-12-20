depth = -300;

battlegroup = "test";
show_exclamation = true;
fast = false;
boss = false;

__soul_x = 48;
__soul_y = 454;

__draw_soul = false;
__draw_soul_x = 0;
__draw_soul_y = 0;
__draw_player = false;
__draw_black = false;
__flash = 0;

if (player_exists()) {
	with(PLAYER1){ state = stateCutsceneStasis(); };
}

alarm[0] = 1;