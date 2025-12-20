/// @category Cutscenes
/// @title Dialogue Functions

/// @func cutscene_dialogue([_speaker], [_portrait], [_text], [_speed], [_showBox], [_boxPos], [_showCursor])
/// @desc Displays dialogue during a cutscene with automatic scene management
/// @desc Handles character-specific fonts, voices, and dialogue box positioning
/// @param {String} [_speaker="generic"] Character ID (gen, gen2, gen3, sans, paps, asg, or generic)
/// @param {Sprite} [_portrait] Character portrait sprite (optional, uses undefined if not provided)
/// @param {String} [_text=""] Dialogue text to display
/// @param {Number} [_speed=0.6] Text display speed (0-1, default 0.6)
/// @param {Bool} [_showBox=true] Show dialogue box (true) or floating text (false)
/// @param {String} [_boxPos="dynamic"] Position: "bottom", "top", or "dynamic"
/// @param {Bool} [_showCursor=true] Show continue cursor at end of text
/// @example
/// scene_info = [
///     [cutscene_dialogue, "sans", spr_port_sans_gen, "hey kid, long time, no see."],
///	 [cutscene_wait_for_dialogue],
///     [cutscene_wait, 60], // Wait 1 second (60 frames)
///	 [cutscene_dialogue,"paps", spr_port_paps_normal, "NYEH HEH HEH!", 1.0, true, "top", false],
///	 [cutscene_wait_for_dialogue],
///     [cutscene_flag_set, global.flags, "met_brothers", true],
///	 [cutscene_end]
/// ];
/// create_cutscene(scene_info);
///
/// @example
/// // Cutscene flow notes:
/// // - Scene continues automatically unless cutscene_wait() is used
/// // - Each dialogue can have different wait behavior
function cutscene_dialogue(_speaker = "generic" , _portrait = undefined, _text = "", _speed = 0.6, _showBox = true, _boxPos = "dynamic", _showCursor = true){
    if !instance_exists(WRITER) { 
        instance_create_depth(0,0,-99999999,WRITER)
    } else {
        var _wait=false;
        for (var i=scene+1;i<array_length(scene_info);i++) {
            if scene_info[i][0]==cutscene_dialogue {_wait=true;break;}
            if scene_info[i][0]==cutscene_wait {break;}
        }
        
        dialogue_setup(_speaker,_portrait,_text,_speed, _showBox,_boxPos,_wait, _showCursor)
        if(instance_exists(WRITER)){
            with(WRITER){
                dialogue.dialogueText = "[speed,"+string(_speed)+"]"+ _text;	
				 dialoguePosition = _boxPos;
                switch _speaker {
                    case "gen":
                        dialogue.dialogueFont = loc_get_font("fnt_main");
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).generic.voice;
                    break;	
                    case "gen2":
                    case "gen3":
                        dialogue.dialogueFont =  loc_get_font("fnt_main");
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).generic2.voice;
                        break;
                    case "sans":
                        dialogue.dialogueFont =  loc_get_font("fnt_sans")
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).sans.voice;
                    break;
                    case "paps":
                        dialogue.dialogueFont =  loc_get_font("fnt_papyrus")
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).paps.voice;
                        break;
                    case "asg":
                        dialogue.dialogueFont = loc_get_font("fnt_main");
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).asg.voice;
                    break;
                    default:
                        dialogue.dialogueFont = loc_get_font("fnt_main");
                        dialogue.dialogueVoice = undefined;
                    break;
                }
                typist.in(_speed,0);
            }
        }
        cutscene_end_action();
    }
}

/// @func cutscene_dialogue_array(_array)
/// @desc [PLANNED/NOT IMPLEMENTED] Displays a sequence of dialogue lines in a cutscene
/// @desc This function is not fully implemented - consider it a feature placeholder
/// @param {Array} _array Array of dialogue objects with speaker and text properties
/// @example
/// // Planned usage - not fully implemented
/// var dialogueArray = [
///     {speaker: "sans", text: "hey."},
///     {speaker: "paps", text: "HELLO HUMAN!"},
///     {speaker: "sans", text: "don't mind him."}
/// ];
/// cutscene_dialogue_array(dialogueArray);
function cutscene_dialogue_array(_array) {
    // Implementation placeholder
    // Planned feature for displaying dialogue sequences
}

/// @func cutscene_choice([_text], [_choice0], [_choice1], [_func0], [_func1], [_text_level], [_preselected])
/// @desc Creates a binary choice dialog during cutscenes (Yes/No style)
/// @desc Note: This function needs revision to make adding new options easier
/// @param {String} [_text=""] Prompt text displayed above choices
/// @param {String} [_choice0="Yes"] Text for first choice option (typically "Yes")
/// @param {String} [_choice1="No"] Text for second choice option (typically "No")
/// @param {Function} [_func0] Callback function executed when first choice is selected
/// @param {Function} [_func1] Callback function executed when second choice is selected
/// @param {Number} [_text_level=0] Text display level/priority (affects rendering order)
/// @param {Number} [_preselected=0] Initially selected choice (0 = first choice, 1 = second choice)
/// @example
/// // Simple Yes/No choice
/// cutscene_choice("Do you want to continue?", "Yes", "No", 
///     function() { show_debug_message("Player chose Yes"); },
///     function() { show_debug_message("Player chose No"); });
/// 
/// @example
/// // Custom choice with preselected option
/// cutscene_choice("Which path will you take?", "Left", "Right",
///     function() { go_left(); },
///     function() { go_right(); },
///     0, 1); // Preselects "Right" (index 1)
/// 
/// @example
/// // TODO: Revise this function to support:
/// // - Variable number of choices (not just binary)
/// // - Easier addition of new options
/// // - Better callback handling
function cutscene_choice(_text = "", _choice0 = "Yes", _choice1 = "No", _func0 = function(){}, _func1 = function(){}, _text_level=0, _preselected = 0){
    if !instance_exists(obj_choice_text) {
        instance_create(x, y, obj_choice_text);
    }
    
    with(obj_choice_text) {
        displayChoiceLabel = _text;
        displayChoices = [_choice0, _choice1];
        outputChoices = [_func0, _func1];
        level = _text_level;
        selection = _preselected;
    }
    
    cutscene_end_action();
}
	
/// @func cutscene_floating_text(_xx, _yy, _font, _color, _text, [_voice], [_dur])
/// @desc Creates floating text during a cutscene with automatic progression
/// @desc Similar to create_floating_text() but automatically advances cutscene
/// @param {Number} _xx X position for the floating text
/// @param {Number} _yy Y position for the floating text
/// @param {String} _font Font name to use (e.g., "fnt_main", "fnt_sans")
/// @param {Color} _color Text color constant (e.g., c_white, c_blue, c_red)
/// @param {String} _text The text content to display
/// @param {Sound|Asset} [_voice] Voice sound to play with text (optional)
/// @param {Number} [_dur=300] Duration in frames before text disappears (default 300 frames ≈ 5 seconds)
/// @example
/// // Floating text at position (100, 200) with blue color
/// cutscene_floating_text(100, 200, "fnt_main", c_blue, "Hello World!");
/// 
/// @example  
/// // Floating text with voice sound and custom duration
/// cutscene_floating_text(300, 150, "fnt_sans", c_white, "nyeh heh heh!", snd_paps_v, 500);
/// 
/// @example
/// // Damage indicator text (short duration, red color)
/// cutscene_floating_text(enemy.x, enemy.y-20, "fnt_main_bt", c_red, "-50", undefined, 90);
function cutscene_floating_text(_xx, _yy, _font, _color, _text, _voice, _dur = 300){
    var inst = instance_create_depth(
        _xx,
        _yy,
        -99999, obj_floating_text)
        
    with inst {
        __font = loc_get_font(__font)
        __color = _color
        __text = _text
        _voiceSound = _voice
        x = _xx
        y = _yy
        _duration = _dur
    }
    
    cutscene_end_action();
}

/// @func dialogue_character_init()
/// @desc Initializes the global character database for dialogue system
/// @desc Sets up character data with fonts, voices, names, and portrait variants
/// @desc Must be called once at game start before any dialogue functions
/// @example
/// // Call this once at game start 
/// dialogue_character_init();
/// 
/// @example  
/// // To add a new character:
/// // 1. Add an entry in this function with unique character ID
/// // 2. Include font, voice, name, and type properties
/// // 3. Add portraits object for multiple expressions if needed
function dialogue_character_init() {
    global.characters = {
        generic : {
            font: loc_get_font("fnt_main_small"),
            voice: snd_soft_v,
            type: SPEAKER_TYPE.REGULAR
        },
        generic2 : {
            font: loc_get_font("fnt_main_small"),
            voice: snd_writer_v,
            type: SPEAKER_TYPE.REGULAR
        },
        sans : {
            font: loc_get_font("fnt_sans"),
            voice: snd_sans_v,
            char_name: "sans.",
            type: SPEAKER_TYPE.REGULAR
        },
        paps: {
            font: loc_get_font("fnt_papyrus"),
            voice: snd_paps_v,
            char_name: "Papyrus",
            type: SPEAKER_TYPE.REGULAR
        },
        shopkeep_1: {
            font: loc_get_font("fnt_main_bt"),
            font_scale: 1,
            voice: snd_soft_v,
            char_name: "Shopkeeper",
            type: SPEAKER_TYPE.SHOP,
            portraits: {
                neutral: spr_shop_host_test,
                evil: spr_shop_host_evil
            }
        }
    }
}
	
/// @func dialogue_setup([_speaker], [_portrait], _text, [_speed], [_showBox], [_boxPos], [_wait], [_showCursor])
/// @desc Sets up a dialogue box with character-specific fonts, voices, and positioning
/// @desc Handles both dialogue boxes and floating text with proper character styling
/// @param {String} [_speaker="gen"] Character ID: "gen", "sans", "paps", "gen2", "gen3"
/// @param {Sprite} [_portrait] Character portrait sprite (optional)
/// @param {String} _text Dialogue text to display (required)
/// @param {Number} [_speed=0.55] Text display speed (0-1, default 0.55)
/// @param {Bool} [_showBox=true] Show dialogue box (true) or floating text (false)
/// @param {String} [_boxPos="dynamic"] Position: "bottom", "top", or "dynamic"
/// @param {Bool} [_wait=false] Wait for player input before continuing
/// @param {Bool} [_showCursor=true] Show continue cursor at end of text
/// @example
/// // Basic dialogue without portrait
/// dialogue_setup("gen", spr_blank, "Hello there!");
/// 
/// @example  
/// // Sans dialogue with portrait and custom speed
/// dialogue_setup("sans", spr_sans_portrait, "hey kid.", 0.75, true, "bottom");
function dialogue_setup(_speaker = "gen", _portrait = spr_blank, _text, _speed = 0.55, _showBox = true, _boxPos = "dynamic", _wait=false, _showCursor = true) {
    if(!_showBox) {
        if !instance_exists(WRITER) { instance_create_depth(0,0,-999,WRITER) }
        if instance_exists(WRITER) with(WRITER) {
            switch _speaker {
                case "gen":
                case "gen2":
                    dialogue.dialogueFont = loc_get_font("fnt_main");
                    break;
                case "sans":
                    dialogue.dialogueFont = loc_get_font("fnt_sans");
                    break;
                case "paps":
                    dialogue.dialogueFont = loc_get_font("fnt_papyrus")
                    break;
                default:
                    dialogue.dialogueFont = loc_get_font("fnt_main_small");
                    break;
            }
            
            dialoguePosition = _boxPos;
            
            if _portrait != undefined {
                switch _speaker {
                    case "sans":
                        dialogue.dialoguePortrait = _portrait;
                        break;
                }
                hasDialoguePortrait = true;
            } else {
                hasDialoguePortrait = false;    
            }
            
             switch _speaker {
                    case "gen":
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).generic.voice;
                        break;
                    case "gen2":
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).generic2.voice;
                        break;
                    case "sans":
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).sans.voice;
                        break;
                    case "papyrus":
                        dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).paps.voice;
                        break;
                    default:
                        dialogue.dialogueVoice = undefined;
                    break;
             }
            
            dialogue.dialogueText = _text;
        }
    } else {
        if(!instance_exists(obj_text_box))
            instance_create_depth(0,0,-999,obj_text_box);
            
        if(instance_exists(obj_text_box)) with (obj_text_box) {
            showCursor = _showCursor;
            switch _speaker {
                case "sans":
                    displayFace = _portrait;
                    dialogueFont = loc_get_font("fnt_sans");
                    break;
                case "paps":
                    displayFace = _portrait;
                    dialogueFont = loc_get_font("fnt_papyrus");
                    break;
                case "asg":
                    displayFace = _portrait;
                    dialogueFont = loc_get_font("fnt_main");
                    break;
                case "gen":
                case "gen2":
                    displayFace = spr_blank;
                    dialogueFont = loc_get_font("fnt_main_small");
                    break;
                case "gen3":
                    displayFace = _portrait;
                    dialogueFont = loc_get_font("fnt_main");
                    break;
            }
            
            switch _speaker {
                case "gen":
                    voiceSound = undefined;
                    voiceSound = (global.characters).generic.voice;
                    displayName = "";
                    dialogueSpeaker = "gen";
                    break;
                case "gen2":
                    voiceSound = undefined;
                    voiceSound = (global.characters).generic2.voice;
                    displayName = "";
                    dialogueSpeaker = "gen2";
                    break;
                case "gen3":
                    voiceSound = undefined;
                    voiceSound = (global.characters).generic2.voice;
                    displayName = "";
                    dialogueSpeaker = "gen3";
                    break;
                case "sans":
                    voiceSound = undefined;
                    voiceSound = (global.characters).sans.voice;
                    displayName = (global.characters).sans.char_name;
                    speaker = (global.characters).sans;
                    dialogueSpeaker = "sans";
                    break;
                case "paps":
                    voiceSound = undefined;
                    voiceSound = (global.characters).paps.voice;
                    displayName = (global.characters).paps.char_name;
                    speaker = (global.characters).paps;
                    dialogueSpeaker = "paps";
                    break;
                default:
                    voiceSound = undefined;
                    break;
            }
            
            displaySpeed = _speed;
            dialoguePosition = _boxPos;
            
            switch(_boxPos) {
                case "bottom":
                    displayOnTop = false;                    
                    break;
                case "top":
                    displayOnTop = true;
                    break;
                case "dynamic":
                    displayOnTop = undefined;
                    break;
            }
            
            _stay = _wait;
        }
    }
}

// same as cutscene_wait_for_dialogue, do not fucking document this
function cutscene_wait_for_dialogue_complete(){
	///@description cutscene_wait_for_dialogue

	timer++;
	if instance_exists(obj_text_writer)&&obj_text_writer.typist.get_state()==1 {timer = 0;  cutscene_end_action() ;}
}