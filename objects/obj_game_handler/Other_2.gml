var WIDTH = global._game_res_width;
var HEIGHT = global._game_res_height;
var RES_SCALE = _game_res_scale;
var PRECISION = _game_res_precision;

RenderConfiguration.set_resolution( WIDTH, HEIGHT );
RenderConfiguration.set_max_scale( RES_SCALE );
RenderConfiguration.set_precision( PRECISION );

show_debug_overlay(UTE_DEBUG_MODE);	

room_speed = global.__ute_frame_rate;