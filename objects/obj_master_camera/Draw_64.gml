//draw_surface(application_surface,0,0)
/// @description Debug info
if(live_call()) return live_result;
//Exits if build is not a developer build
//if(!DEVELOPERBUILD) {exit;}

//Draws various debug info if global.debug macro is set to true
//debug string
var text_string = "Press [F12] for Debug info";

//alters debug string
if global.debug && debugInfoShow {
	
	//Draws game meta data and debug info
	text_string =	"FPS  " + string(fps) + "\n" +
					"Instances Active  " + string(instance_count) + "\n" +
					"Camera Coordinates  " + string(x) + " , " + string(y) + "\n" +
					"Screen Scaling  x" + string_format(window_get_fullscreen() ? view_full_scale : view_scale,2,2) + "\n" +
					"View Dimensions  " + string(window_get_fullscreen() ? view_full_w : view_w) + " x " + string(window_get_fullscreen() ? view_full_h : view_h) + "\n" +
					GAME_NAME + " v " + GAME_VERSION + " by " + GAME_AUTHOR;	
}

//debug draw vars
if global.debug {
var debug_font = fnt_canela;
var debug_text_padding = 10;
var debug_font_scaling = 1;
var debug_x = debug_text_padding;
var debug_y = GAME_RES.h - (string_get_pix_h(text_string,debug_font)*debug_font_scaling) - debug_text_padding;

//draws debug text
draw_text_outlined_ext(debug_x,debug_y,-1,-1,c_black,c_white,debug_font_scaling,debug_font_scaling,1,text_string,debug_font,fa_left,fa_top);
}

if global._border_id == "SIMPLE" || global._border_id == "FANCY" && border_get_enabled() == true  draw_sprite_stretched_ext(global.rounded_box == true ? spr_textborder_outer_rounded : spr_textborder_outer,0,-6,-5,652,490,c_white,border_alpha)
//draw_rectangle_color(0,0,640,480,c_red,c_red,c_red,c_red,false)
//draw_surface_ext(application_surface,
//                                      0,
//                                      0,
//                                      0.5,//window_get_fullscreen() ? view_full_scale : view_scale,
//                                      0.5,//window_get_fullscreen() ? view_full_scale : view_scale,
//                                      0, c_red, 1)
//show_message(surface_get_height(application_surface))
