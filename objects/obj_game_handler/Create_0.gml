global._game_res_width = 1280;
global._game_res_height = 960;
_game_res_scale = 0.72;
_game_res_precision = 1.0;

sprite_index=noone;

garbageTimer=0;

// Execute any necessary functions - initialize data
game_init();

global.player_inventory = ds_list_create();
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());
ds_list_add(global.player_inventory, new Test());