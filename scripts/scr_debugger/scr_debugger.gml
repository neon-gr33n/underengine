function scr_debugger()
{
	if keyboard_check_pressed(vk_f2){game_restart()}
	if keyboard_check_pressed(vk_f3){room_restart()}
	if keyboard_check_pressed(vk_f5){screen_capture()}
	if keyboard_check_pressed(vk_f11){with(GAME){performanceInfo= !performanceInfo; }}
	if keyboard_check_pressed(vk_alt){
			  // Setup test shop
			if (!ShopExists("DEFAULT")){
			    ShopekeeperInit("DEFAULT");
				ShopCanSell(false)
			    ShopitemAdd("FADED_RIBBON", true, 1);
			    ShopitemAdd("TEST_DOG1");
			}
			room_goto(rm_shop)	
	}
	if (keyboard_check_pressed(vk_f7)) game_set_speed((game_get_speed(gamespeed_fps) == 60) ? 30 : 60, gamespeed_fps);
	if keyboard_check(vk_backtick){
		if keyboard_check_pressed(ord("F")){
			instance_create(0,0,obj_savemenu)
		}	
		if keyboard_check_pressed(ord("L")){
			loadgame(0)	
		}
		if keyboard_check_pressed(vk_alt){
			 member_set_stat("FRISK","HP",0)
		}
	}
	
	if keyboard_check_pressed(ord("M")){
		audio_stop_all()	
	}
	
	if keyboard_check_pressed(ord("A")){
		show_debug_message("Aspect Ratio: " + string(global.asp_ratio))
	}
	
    if keyboard_check_pressed(ord("0")) { global.asp_ratio = 0; global._border_enabled = false; set_display_sizes() with (obj_master_camera) set_resolution(global._display_width) }
    if keyboard_check_pressed(ord("1")) { global.asp_ratio = 1; global._border_enabled = true; set_display_sizes() with (obj_master_camera) set_resolution(global._display_width) }
    
	if keyboard_check(vk_shift)
	{
		if instance_exists(obj_ow_party)
		{
			if mouse_check_button(mb_left)
			{
				with(obj_ow_party){
						TweenFire(obj_ow_party,EaseInOutCubic,0,0,0,3,"x",x,mouse_x);
						TweenFire(obj_ow_party,EaseInOutCubic,0,0,0,3,"y",y,mouse_y);
				}
				with(obj_ow_party){
					canMove=false;
				}
			} else {
				with(obj_ow_party){
					canMove=true;
				}
			}
		}
	} else if keyboard_check(vk_capslock) {
		show_message(string(window_view_mouse_get_x(0)*2)+"  "+string(window_view_mouse_get_y(0)*2-640))
	}
}