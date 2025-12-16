draw_set_color(c_white)
draw_set_font(fnt_main_small)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_alpha(1)
//if gamepad_is_connected(0)
//	draw_text(10,10,"Controller is connected!"+string(gamepad_axis_count(gp_axislh)))

//var gp_num = gamepad_get_device_count();
//for (var i = 0; i < gp_num; i++;)
//{
//if gamepad_is_connected(i)
//    {
//    draw_text(32, 32 + (i * 32), gamepad_get_description(i)+"  "+string(input_gamepad_delta(0,gp_axislh)));
//	//gamepad_set_vibration(0,1,1)
//    }
//else
//    {
//    draw_text(32, 32 + (i * 32), "No Gamepad Connected");
//    }
//}
//if global.debug draw_text(10,10,$"Game Handler is active!\nDisplay Size:{global._display_width}x{global._display_height} ({GAME_RES.w}x{GAME_RES.h})\nGUI size: {display_get_gui_width()}x{display_get_gui_height()}")
//if instance_exists(obj_naming_screen) with(obj_naming_screen){
//if global.debug draw_text(10,25, "Letter selected: " + string(letterSelection))
//}
if instance_exists(obj_menu_handler) with(obj_menu_handler){
if global.debug draw_text(10,25, "Menu selection: " + string(_menuSelection))
}
//draw_set_alpha(0.5)
//draw_rectangle_color(0,0,640,480,c_red,c_red,c_red,c_red,false)