function discord_update(){
	if(!is_android()){
		if(instance_exists(obj_presence_handler)){
			switch(room){
				case rm_init:
					discord_set_location("init");
				break;
				// leave commented out for now
			//	case rm_intro:
			//		discord_location("intro");
				case rm_menu:
				case rm_naming:
					discord_set_location("beginning");
				// leave commented out for now
				//case rm_settings:
				//	discord_location("settings");
				case rm_battle:
					discord_set_location("battle");
				case rm_gameover:
					discord_set_location("gameover");
				// leave commented out for now
				//case rm_shop:
				//	discord_location("shop");
				default: 
					discord_set_location("init");
			}
			var rm=room;
			if(asset_has_tags(rm, ["lucent_caverns"], asset_room)) {
				discord_set_location("ruins");	
			}
		}
	} else {
		// User is on android, do not execute this script
	}
}