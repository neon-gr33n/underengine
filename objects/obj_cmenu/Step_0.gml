var MENU = _menu_active;

if currentState == "hub" {
		   _menu_selection = clamp(_menu_selection,0,2);
			if pressed("up") && _menu_selection != 0 {
				_menu_selection--;
				sfx_playc(snd_menu_switch,1,0.7)
			} else if pressed("down") && _menu_selection != 2 {
				_menu_selection++;
				sfx_playc(snd_menu_switch,1,0.7)
			} else 	if(pressed("cancel")){
				instance_destroy();
			}
		
			if _menu_selection == 0 {
				selCursorYPos = 205;
				if(pressed("action")){
					state = stateMenuItemOpened();
					_activeSel = true;
					sfx_playc(snd_menu_select,1,0.7)
				}
			} else if _menu_selection == 1 {
					selCursorYPos = 237;
			} else if _menu_selection == 2 {
					selCursorYPos = 269;
			}	

} 
if currentState == "itemOpened" {
	  _menu_item_selection = clamp(_menu_item_selection,0,ds_list_size(global.player_inventory)-1);
		if pressed("up") && _menu_item_selection != 0 {
			_menu_item_selection--;
			selCursorYPos -= 30;
			sfx_playc(snd_menu_switch,1,0.7)
		} else if pressed("down") && _menu_item_selection != ds_list_size(global.player_inventory)-1 {
			_menu_item_selection++;
			selCursorYPos += 30;
			sfx_playc(snd_menu_switch,1,0.7)
		} else 	if(pressed("cancel")){
				_menu_item_option_selection = 0;
				state = stateMenuHub();
		}
		
}