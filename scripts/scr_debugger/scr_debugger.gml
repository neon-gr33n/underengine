function scr_debugger()
{
	if keyboard_check_pressed(vk_f2){game_restart()}
	if keyboard_check_pressed(vk_f3){room_restart()}
	if keyboard_check_pressed(vk_f5){screen_save("underengine-capture")}
	if keyboard_check_pressed(vk_f11){with(GAME){performanceInfo= !performanceInfo; }}
	if keyboard_check_pressed(ord("S")){with(HEART){y=BOARD.board_y}}
	if keyboard_check(vk_shift)
	{
	if instance_exists(obj_ow_player)
	{
		if mouse_check_button(mb_left)
		{
			with(obj_ow_player){
					TweenFire(obj_ow_player,EaseInOutCubic,0,0,0,3,"x",x,mouse_x);
					TweenFire(obj_ow_player,EaseInOutCubic,0,0,0,3,"y",y,mouse_y);
			}
			with(obj_ow_player){
				canMove=false;
			}
			} else {
				with(obj_ow_player){
					canMove=true;
				}
			}
		}
	}
}