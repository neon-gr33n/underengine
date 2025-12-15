switch(state){
	case "menuPre":
		if input.action_pressed { state="menuMain"}
	break;
	case "menuMain":
			//_menuSelection = clamp(_menuSelection,0,4);
		if input.down_pressed || input.up_pressed {
		_menuSelection=(_menuSelection+5+input.down-input.up)%5;
		if !(file_exists("file0") || file_exists("file1") || file_exists("file2")) && _menuSelection==1
			_menuSelection=(_menuSelection+5+input.down-input.up)%5;
		sfx_play(snd_menu_switch);
	} else if input.action_pressed {
		switch(_menuSelection){
			case 0:
				// todo: add a fader transition to rm_naming
				room_restart();
				room_goto(rm_loadgame);
				HEART.returning=2;
				HEART.image_alpha = 1;
			break;
			case 1:
				room_restart();
				room_goto(rm_loadgame);
				HEART.returning=2;
				HEART.image_alpha = 1;
			break;
			case 2:
				HEART.returning=2;
				HEART.image_alpha = 1;
                room_goto(rm_credits);
			break;
			case 3:
				instance_destroy(obj_music_handler)
				room_goto(rm_settings)
				HEART.image_alpha = 1;
			break;
			case 4:
				game_end()
			break;
		}
	break;
	}
}

HEART.x=30;
HEART.y=168+_menuSelection*40;