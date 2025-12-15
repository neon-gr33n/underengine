switch(_menu){
	case 0:
		switch(_menued){
					case 0:
						_menudesc[0] = "Exit the pause menu, and return to gameplay."
						break;
					case 1:
						_menudesc[0] = "Return to the main menu\nDon't forget to SAVE before leaving."
						break;
					case 2:
						_menudesc[0] = "Modify or otherwise customize your settings."
						break;
					case 3:
						_menudesc[0] = "Rebind controls to your preference."
						break;
					case 4:
						_menudesc[0] = "Additional options that may impact gameplay"
						break;
					case 5:
						_menudesc[0] = "Closes the current instance of the game."
						break;
		}
		break;
	case 2:
			switch(_menued){
					case 0:
						_menudesc[0] = "Adjust the volume of in-game sounds."
						break;
					case 1:
						_menudesc[0] = "Tweak in-game graphical settings."
						break;
					case 2:
						_menudesc[0] = "Customize the game to make it better for you."
						break;
					case 3:
						_menudesc[0] = "Rebind controls to your preference."
						break;
					case 4:
						_menudesc[0] = "Enable or disable some game features."
						break;
					case 5:
						_menudesc[0] = "Additional options that may impact gameplay"
						break;
					case 6:
						_menudesc[0] = "Return to the previous menu."
						break;
		}
		break;
	case 2.3:
				switch(_menued){
					case 0:
						_menudesc[0] = "Reduces in-game screen tearing.\nNOTE: May increase input lag slightly."
						break;
					case 1:
						_menudesc[0] = "Limits the maximum frame rate of the game."
						break;
					case 2:
						_menudesc[0] = "Changes the resolution of the game."
						break;
					case 3:
						_menudesc[0] = "Switches the display mode of the game window."
						break;
					case 4:
						_menudesc[0] = "Changes the aspect ratio for the game."
						break;
					case 5:
						_menudesc[0] = "Return to the previous menu."
						break;
		}
		break;
}

switch(_dmodec){
	case 0:
		// Windowed
		global.window_mode = 0;
		window_set_fullscreen(false)
		window_set_showborder(true)
		break;
	case 1:
		// Fullscreen
		global.window_mode = 1;
		window_set_fullscreen(true)
		break;	
	case 2:
		// Borderless
		global.window_mode = 2;
		window_set_showborder(false)
		break;
}

switch(_bmodec) {
	case 0:
		global._border_type = 0;
		global._border_type_index = 0;
		global.asp_ratio = 1;
		window_center()
		border_set_enabled(true)
	break;
	case 1:
		global._border_type = 1;
		global._border_type_index = 1;
		global.asp_ratio = 1;
		window_center()
		border_set_enabled(true)
	break;
	case 2:
		global._border_type = 2;
		global._border_type_index = 2;
		global.asp_ratio = 0;
		set_display_sizes()
		with (obj_master_camera) set_resolution(global._display_width)
		window_center()
		border_set_enabled(false)
	break;
}

switch(_bassetc){
	case 0:
		border_set_id("SIMPLE");
		global._border_sel = 0;
	break;
	case 1:
		border_set_id("SEPIA");
		global._border_sel = 1;
	break;
	case 2:
		border_set_id("FANCY");
		global._border_sel = 2;
	break;
}