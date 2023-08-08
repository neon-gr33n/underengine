function game_init()
{
	#region INITIALIZE AUDIO SYSTEM
	audio_channel_num(128);
	global.sfxEmitter = audio_emitter_create(); 	// Register audio emitters and busses
	global.sfxBus= audio_bus_create();
	global.ambEmitter = audio_emitter_create();
	global.ambBus= audio_bus_create();
	global.musEmitter = audio_emitter_create();
	global.musBus= audio_bus_create();
	audio_emitter_bus(global.sfxEmitter,global.sfxBus); 	// Assign audio emitters to their respective busses
	audio_emitter_bus(global.ambEmitter,global.ambBus);
	audio_emitter_bus(global.musEmitter,global.musBus);
	global.musfpath						="./data/mus/";
	global.muspriority					=20;
	global.currentmus					=-1;
	#endregion
	#region INITIALIZE LOCALIZAITON SYSTEM
	global.font=-7
	global.lang_initialized = false;
	global.lang_loaded = "";
	global.mainFontWidth = 8; // The main font width (8-Bit Operator JVE)
	global.mainFontHeight = 36; // The main font height (8-Bit Operator JVE)
	global.lang="eng";
	loc_default_sprites()
	loc_init();
	#endregion
	
	global.__ute_frame_rate		= 60;
	
	gc_enable(0)
	
	#region CREATE CUSTOM CRASH LOG IF USER ISN'T ON MAC OSX
	if (os_type != os_macosx)
        exception_unhandled_handler(function(argument0)
        {
            var exs = string(argument0)
            show_debug_message(("Unhandled exception " + exs))
            var f = file_text_open_write("crash.txt")
            file_text_write_string(f, exs)
            file_text_close(f)
            if (os_type != os_android && os_type != os_linux)
                show_message(("Game crashed! Please contact developers.\n\nExtra info: " + exs))
            return;
        }
	)
	#endregion
	
	global.osflavor						= (os_type != os_android ? 0 : 1) 
	math_set_epsilon(0.00001)
	window_set_color(0)
	
	global.vsync								=true;
		
	texture_flush("FONTS")
	
	#region SAVE DATA GLOBAL VARIABLES (DO NOT REMOVE)
		// * heya, warning number 2
		// * do not remove this..
		// * unless you want to have bad time.
		global.currentroom				=-1
		global.loadroom					=-1
		global.currentarea				=-1
		global.timeseconds				=-1
		global.lpartyname					=-1
		global.lcurrentarea				=-1
		global.lloadedroom				=-1
		global.ltime								=-1
		global.tempsave_buffer		=-1
		global.filechoice						=-1
	#endregion
	
	global.gamebroke					=-1
	
	global.exp								=0
	global.money							=0
	
	global.dialogueInteractedTo = undefined
	
	flags_init(true);
	GAME.garbageTimer=28
	
	
	instance_create_depth(0,0,0,InputForPlayer1)
	
	party_data_init();
	party_add_member(0,obj_ow_player);
	
	room_goto_next()
}