function gj_init() { 
	#region INITIALIZE GAMEJOLT API VARS
	global.__gj_callback = undefined;
	global.__gj_avatar_url = undefined;
	global.__gj_avatar_file = "avatar_temp.png";
	global.__gj_avatar_request = "";
	 global.__gj_avatar_timeout = -1;
	global.gj_login_surf				= -1
	global.gj_login_buff				= -1
	global.gj_menu_surf				= -1
	global.gj_menu_buff				= -1
	global.gj_t_surf						= -1
	global.gj_t_buff			= -1
	global.gj_menu_open				= false 
	global.gj_login_open				= true 
	global.gj_achi_open				= false
	global.gj_username				= ""
	global.gj_token						= ""
	 global.gj_userid					 = ""
	global.gj_initialized			 = false;
	#endregion
	
	 if (global.gj_initialized || (!os_is_network_connected(3)))
        return;
    global.gj_initialized = true
	global.gj = new FrostJolt();
	// Call this once at game start
	initialize_avatar_system();
}