display_set_gui_size(640,480)
if(_state==-1){
	if(!instance_exists(obj_text_box)){
		_state=0;
		event_user(0);
	}
}else if(_state==0){
	if(input.menu_pressed){
		global.filechoice=global.filechoice++%3
		sfx_play(snd_menu_switch);
	}
	if(input.left_pressed || input.right_pressed) {
		if (_choice != 0.5){
		_choice=(_choice+1)%2;
		} else {
			_choice=(_choice+1)%1;
		}
		sfx_play(snd_menu_switch);
	} else if(input.up_pressed || input.down_pressed) {
		_choice = (_choice == 0 || _choice == 1) ? 0.5 : _choice + ((_choice + 0.5) % 1) * 2 - 0.5;
		sfx_play(snd_menu_switch);
	}else if(input.action_pressed){
		switch _choice {
			case 0:
				//save
				_state=1;
				if(savecount==""){
					savecount="y";
				}
				global.timeMinutesPrevious=minutes;
				global.timeHoursPrevious=hours;
				global.timeSecondsPrevious=seconds;
				event_user(0);
				break;
			case 0.5:
				//storage menu
				if array_length(global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"])+array_length(global.PARTY_INFO[$ "__PARTY__"][$ "STORAGE"])>0 {
					sfx_play(snd_menu_select)
					_state = 3
					_choice=0;
					if array_length(global.PARTY_INFO[$ "__PARTY__"][$ "INVENTORY"])==0 _choice=300
				} else
					sfx_play(snd_error)
				break;
			case 1:
				//cancel
				instance_destroy();
				break;				
		}
	} else if(input.cancel_pressed){
		instance_destroy();
	}

} else if(_state==1){
	if(input.cancel_pressed||input.action_pressed){
		instance_destroy();
	}

}else if(_state==2){
	if(input.left_pressed || input.right_pressed) {
		_indexed=(_indexed+(input.right-input.left)+array_length(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"]))%array_length(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"]);
		sfx_play(snd_menu_switch);
	} else if(input.cancel_pressed){
		_state=0;
		_choice=0.5;
	}
}