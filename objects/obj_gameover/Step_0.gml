if _shaking
{
	x=xstart+random_range(-_shake,_shake);
	y=ystart+random_range(-_shake,_shake);
}

if _showChoices
{
	_choice=(_choice+input.right_pressed+input.left_pressed)%2	
	if input.action_pressed {
		switch(_choice){
			case 0:
				fade_basic(0,1,45,0,c_black)
				mus_set_volume(global.currentmus[2],0,0.5,false)
				player_heal(0,player_get_max_hp())
				room_goto(flag_get(global.flags,"rm_r"))
			break;
			case 1:
				fade_basic(0,1,45,0,c_black)
				room_goto(rm_menu)
			break;
		}
	}
}
