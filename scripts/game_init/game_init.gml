function game_init()
{
    //TweenFire()
    #region INITIALIZE AUDIO SYSTEM
    audio_channel_num(128);
    global.sfxEmitter = audio_emitter_create();     // Register audio emitters and busses
    global.sfxBus= audio_bus_create();
    global.ambEmitter = audio_emitter_create();
    global.ambBus= audio_bus_create();
    global.musEmitter = audio_emitter_create();
    global.musBus= audio_bus_create();
    audio_emitter_bus(global.sfxEmitter,global.sfxBus);     // Assign audio emitters to their respective busses
    audio_emitter_bus(global.ambEmitter,global.ambBus);
    audio_emitter_bus(global.musEmitter,global.musBus);
    global.musfpath                        = is_android() == true ? "assets/data/mus/" : "./data/mus/";
    global.muspriority                    =20;
    global.currentmus                    = array_create(3,-1);   // [0] - Area/overworld music  
    global.currentmus[1] = "battle";
                                                                                                                                // [1]  - Battle music 
                                                                                                                                //[2] - Cutscene music or ambience
    global.wav_song                        =-1;
    global.mus_volume=0.75
    global.voice_volume=1
    global.sfx_volume=0.5
    global.master_volume=1
    #endregion
    
  #region INITIALIZE LOCALIZATION SYSTEM
    global.font = -7
    global.lang_initialized = false;
    global.lang_loaded = noone;
    global.mainFontWidth = 8; // The main font width (8-Bit Operator JVE)
    global.mainFontHeight = 36; // The main font height (8-Bit Operator JVE)
    
    // Simply call loc_setup which will handle everything
    loc_setup();
    
    global.lang_ls = "90%";
    global.dialogue_map = noone;
    #endregion
    
    game_set_speed(60, gamespeed_fps);
    
    global.rounded_box = true;
    
    // initialize networking and gamejolt apis
    network_init();
    gj_init();
    if (file_exists(working_directory + "gamejolt_cred.bin")) {
        if (!gj_util_loadcredentials()) {
            show_debug_message("Credentials corrupted, deleting file...");
            file_delete("gamejolt_cred.bin");
            global.gj_username = "";
            global.gj_token = "";
        }
    }
    
    gc_enable(true);
    
    delta_init();
    
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
    
    global.osflavor                        = (os_type != os_android ? 0 : 1) 
    global.window_mode                    = 0;
    randomize()
    math_set_epsilon(0.00001)
    draw_set_color(c_black)
    window_set_color(0)
    
    global.vsync                        = true;
	global.simplify_vfx			= false
    global.one_handed        = false; 
	
	global.touch_opacity = 0.5;
	global.touch_scale = 2;
        
    #region SAVE DATA GLOBAL VARIABLES (DO NOT REMOVE)
        // * heya, warning number 2
        // * do not remove this..
        // * unless you want to have bad time.
        global.currentroom                = -1
        global.loadroom                    = -1
        global.currentarea                = -1
        global.timeseconds                = -1
        global.tempsave_buffer                = -1
        global.filechoice                = 0 // Set to 0 for debug purposes for now
    #endregion
    
    global.gamebroke                    = -1
    
    global.time                        = 0
    global.timeSeconds                    = 0
    global.timeMinutes                    = 0
    global.timeHours                    = 0
    global.timeSecondsPrevious                = 0
    global.timeMinutesPrevious                = 0
    global.timeHoursPrevious                = 0
    global.savepoint_time1                    = 0
    global.savepoint_time2                    = 0
    
    global.enc_slot = [noone, noone, noone];
    global.enc_name = ["", "", ""];
    
    global.fun                        = 0
    
    global.dialogueInteractedTo                = undefined
    
    global.master_view                    = 0;
    global.master_camera                = noone;
    global.camera_lerp                    = false;
    global.epilepsy_mode                = false;
    global.shake_screen                    = true;
    
    global.presence                        = true; // Enables/Disables discord rich presence
    
    global.running_enabled                    = true;
    global.pausing_enabled                    = true;
    
    global.one_handed                = false; 
    
    global.auto_sprint                    = false;
    
    global.pause_surf                    = -1
    global.pause_buff                    = -1
    
    global.effect_taget = "CHARA"
    
    enemy_data_init();
    party_data_init();
    equipment_data_init();
    flags_init(true);
    contact_data_init();
    room_data_init();
    difficulty_data_init();
    pal_swap_init_system(shd_pal_swapper, shd_pal_html_sprite, shd_pal_html_surface);
    border_init();
    
    global.__difficulty_id = "NORMAL"
    global.active_difficulty = global.GAME_DIFFICULTY[$ global.GAME_DIFFICULTY[$ "__DIFFICULTY__"][$ global.__difficulty_id][$ "LABEL"]]
    
    global.debug = false;
    if(!is_android()){
        global.debug = true;    
    } else {
        global.debug = false    
    }
    global.danger = false // Toggles the "Soul Vision" mode, or overworld bullet hell, like in Deltarune ^^
    
    GAME.garbageTimer = 28
        
    #region Define accessible window resolutions
    #region Widescreen Resolutions
    #endregion
    #region Non-widescreen resoltuons
    global.resolutions = [ 
    // 4:3
    { w:640,   h:480 },
    { w:800,   h:600 },
    { w:960,   h:720 },
    { w:1024, h:768 },
    { w:1152, h:864 },
    { w:1280, h:960 },
    { w:1400, h:1050 },
    { w:1440, h:1080 },
    { w:1600, h:1200 },
    { w:1856, h:1392 },
    { w:1920, h:1440 },
    { w:2048, h:1536 },
    { w:2560, h:1920 },
    { w:2880, h:2160 },
    { w:3072, h:2304 },
    { w:3840, h:2880 },
    ]
    //16:9
    //[{ w:800,   h:450 },
    //{ w:960,   h:540 },
    //{ w:1024, h:576 },
    //{ w:1152, h:648 },
    //{ w:1280 , h:720 },
    //{ w:1440, h:810 },
    //{ w:1600, h:900 },
    //{ w:1856, h:1044 },
    //{ w:1920 , h:1080 },
    //{ w:2048,  h:1152},
    //{ w:2560 , h:1440 },
    //{ w:2880,  h:1620 },
    //{ w:3072,  h:1728 },
    //{ w:3840,  h:2160 },
    //{ w:640 ,  h:360 },]
    #endregion

    global.resolution_index = 5;
    #endregion
    
    if file_exists("crash.txt")
    {
        f = file_text_open_read("crash.txt")
        var i = 0
        global.crash_data[0] = "Empty crash.txt"
        while (!file_text_eof(f))
        {
            global.crash_data[i++] = file_text_read_string(f)
            file_text_readln(f)
        }
        file_text_close(f)
        file_copy("crash.txt", "crash-last.txt")
        file_delete("crash.txt")
        global.gamebroke = 11
        room_goto(rm_gamebroke);
    }
    if (!data_check_integrity())
    {
        global.gamebroke = 8
        room_goto(rm_gamebroke)
        return;
    }
        
    load_config()
    if(!global._border_enabled && os_type != os_android){
        global.asp_ratio = 0;    
    }
    if global.rounded_box {
        global.boxout = spr_textborder_outer_rounded;
        global.boxin = spr_textborder_inner_rounded;
    } else {
        global.boxout = spr_textborder_outer;
        global.boxin = spr_textborder_inner;
    } global.rounded_box = true;
    
    set_display_sizes()
    
    display_set_gui_size(640,480)
    surface_resize(application_surface,640,480)
    application_surface_enable(true)
    application_surface_draw_enable(false)    
    instance_create(0,0,obj_master_camera)
    
    camera_window_resize(false, global._windowed_width,global._windowed_height)
    
    dialogue_character_init()
    room_goto(START_ROOM);
}