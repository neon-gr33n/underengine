/// @category Game
/// @title Initialization

/// @function game_init()
/// @description Initializes all core game systems and starts the game
function game_init()
{
    // Initialize core systems
    initialize_audio_system();
    initialize_localization_system();
    initialize_networking();
    
    // Set up game constants and defaults
    setup_game_constants();
    setup_global_variables();
    
    // Initialize data systems
    initialize_data_systems();
    
    // Set up display and rendering
	setup_resolutions();
    setup_display();
    
    // Handle errors and check integrity
    handle_error_recovery();
    
    // Load configuration and final setup
    finalize_setup();
    
    // Start the game
    room_goto(START_ROOM);
}

/// @function initialize_audio_system()
/// @description Sets up audio channels, buses, emitters, and default volumes
function initialize_audio_system()
{
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
}

/// @function initialize_localization_system()
/// @description Sets up language localization and font system
function initialize_localization_system()
{
    global.font = -7;
    global.lang_initialized = false;
    global.lang_loaded = noone;
    global.mainFontWidth = 8;
    global.mainFontHeight = 36;
    
    loc_setup();
    global.lang_ls = "90%";
    global.dialogue_map = noone;
}

/// @function initialize_networking()
/// @description Initializes network connections and GameJolt API
function initialize_networking()
{
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
}

/// @function setup_game_constants()
/// @description Sets core game constants and system configurations
function setup_game_constants()
{
    game_set_speed(60, gamespeed_fps);
    
    global.party_times = array_create(3, "--:--");
    global.party_rooms = array_create(3, "------------");
    
    global.rounded_box = false;
    global.menu_qol_enabled = false;
    global.osflavor = os_type == os_android ? 1 : 0;
    global.window_mode = 0;
    
    gc_enable(true);
    delta_init();
}

/// @function setup_global_variables()
/// @description Initializes global game state variables and settings
function setup_global_variables()
{
    // System flags
    global.vsync = true;
    global.simplify_vfx = false;
    global.one_handed = false;
    global.touch_opacity = 0.5;
    global.touch_scale = 2;
    global.window_mode = 0;
    
    // Save data
    global.currentroom = -1;
    global.loadroom = -1;
    global.currentarea = -1;
    global.timeseconds = -1;
    global.tempsave_buffer = -1;
    global.filechoice = 0;
    
    // Time tracking
    global.time = 0;
    global.timeSeconds = 0;
    global.timeMinutes = 0;
    global.timeHours = 0;
    global.timeSecondsPrevious = 0;
    global.timeMinutesPrevious = 0;
    global.timeHoursPrevious = 0;
    global.savepoint_time1 = 0;
    global.savepoint_time2 = 0;
    
    // Encounter data
    global.enc_slot = [noone, noone, noone];
    global.enc_name = ["", "", ""];
    
    // Game state
    global.fun = 0;
    global.dialogueInteractedTo = undefined;
    global.master_view = 0;
    global.master_camera = noone;
    global.camera_lerp = false;
    global.epilepsy_mode = false;
    global.shake_screen = true;
    global.presence = true;
    global.running_enabled = false;
    global.pausing_enabled = true;
    global.auto_sprint = false;
    global.pause_surf = -1;
    global.pause_buff = -1;
    global.effect_target = "FRISK";
    
    // Debug and difficulty
    global.debug = !is_android();
    global.danger = false;
    global.__difficulty_id = "NORMAL";
	global.gamebroke = 0;
}

/// @function initialize_data_systems()
/// @description Initializes game data systems (enemies, party, equipment, etc.)
function initialize_data_systems()
{
    enemy_data_init();
    party_data_init();
    equipment_data_init();
    flags_init(true);
    contact_data_init();
    room_data_init();
    difficulty_data_init();
    border_init();
    
    global.active_difficulty = global.GAME_DIFFICULTY[$ 
        global.GAME_DIFFICULTY[$ "__DIFFICULTY__"][$ 
        global.__difficulty_id][$ "LABEL"]];
}

/// @function setup_resolutions()
/// @description Defines available screen resolutions for the game
function setup_resolutions()
{
    global.resolutions = [
        // 4:3 aspect ratio resolutions
        { w:640,   h:480 }, { w:800,   h:600 }, { w:960,   h:720 },
        { w:1024, h:768 }, { w:1152, h:864 }, { w:1280, h:960 },
        { w:1400, h:1050 }, { w:1440, h:1080 }, { w:1600, h:1200 },
        { w:1856, h:1392 }, { w:1920, h:1440 }, { w:2048, h:1536 },
        { w:2560, h:1920 }, { w:2880, h:2160 }, { w:3072, h:2304 },
        { w:3840, h:2880 }
    ];
    
    global.resolution_index = 5;
}

/// @function setup_display()
/// @description Configures display settings, GUI, and camera system
function setup_display()
{
    randomize();
    math_set_epsilon(0.00001);
    
    draw_set_color(c_black);
    window_set_color(0);
    
    set_display_sizes();
    
    display_set_gui_size(640, 480);
    surface_resize(application_surface, 640, 480);
    application_surface_enable(true);
    application_surface_draw_enable(false);
    
    instance_create(0, 0, obj_master_camera);
}

/// @function handle_error_recovery()
/// @description Sets up crash handlers and handles recovery from previous crashes
function handle_error_recovery()
{
    if (os_type != os_macosx) {
        setup_crash_handler();
    }
    
    if (file_exists("crash.txt")) {
        handle_crash_file();
    }
    
    if (!data_check_integrity()) {
        global.gamebroke = 8;
        room_goto(rm_gamebroke);
        return;
    }
}

/// @function setup_crash_handler()
/// @description Creates exception handler for unhandled game crashes
function setup_crash_handler()
{
    exception_unhandled_handler(function(exception) {
        var exString = string(exception);
        show_debug_message("Unhandled exception " + exString);
        
        var f = file_text_open_write("crash.txt");
        file_text_write_string(f, exString);
        file_text_close(f);
        
        if (os_type != os_android && os_type != os_linux) {
            show_message("Game crashed! Please contact developers.\n\nExtra info: " + exString);
        }
    });
}

/// @function handle_crash_file()
/// @description Processes crash data from previous game crash
function handle_crash_file()
{
    var f = file_text_open_read("crash.txt");
    var i = 0;
    global.crash_data = ["Empty crash.txt"];
    
    while (!file_text_eof(f)) {
        global.crash_data[i++] = file_text_read_string(f);
        file_text_readln(f);
    }
    
    file_text_close(f);
    file_copy("crash.txt", "crash-last.txt");
    file_delete("crash.txt");
    
    global.gamebroke = 11;
    room_goto(rm_gamebroke);
}

/// @function finalize_setup()
/// @description Final configuration loading and setup before game start
function finalize_setup()
{
    load_config();
    
    if (!global._border_enabled && os_type != os_android) {
        global.asp_ratio = 0;
    }
    
    // Set border sprites
    global.boxout = global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer;
    global.boxin = global.rounded_box ? spr_textborder_inner_rounded : spr_textborder_inner;
    
    setup_resolutions();
    GAME.garbageTimer = 28;
    
    camera_window_resize(false, global._windowed_width, global._windowed_height);
    dialogue_character_init();
}