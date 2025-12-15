// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function config_apply_resolution(){
	set_resolution(global._display_width)
	set_camera(0,0,global.ideal_width,global.ideal_height)
	set_gui_size(global.ideal_width,global.ideal_height)
}
