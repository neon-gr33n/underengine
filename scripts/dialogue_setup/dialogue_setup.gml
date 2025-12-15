/**
 * Sets up a dialogue box with character-specific settings.
 * 
 * @example
 * // Basic dialogue without portrait
 * dialogue_setup("gen", undefined, "Hello there!");
 * 
 * @example  
 * // Sans dialogue with portrait and custom speed
 * dialogue_setup("sans", spr_sans_portrait, "hey kid.", 0.75, true, "bottom");
 * 
 * @example
 * // Adding a new character type:
 * // 1. Add character to dialogue_character_init() function
 * // 2. Add case in dialogue_setup() for new character
 * // 3. Optionally add portrait handling
 * 
 * @param {string} speaker - Character ID ("gen", "sans", "paps", "asg", "gen2", "gen3")
 * @param {sprite} portrait - Character portrait sprite (optional)
 * @param {string} text - Dialogue text to display
 * @param {number} speed - Text display speed (0-1, default 0.55)
 * @param {boolean} showBox - Show dialogue box (true) or floating text (false)
 * @param {string} boxPos - Position: "bottom", "top", or "dynamic"
 * @param {boolean} wait - Wait for player input before continuing
 * @param {boolean} showCursor - Show continue cursor at end of text
 */
function dialogue_setup(_speaker = "generic", _portrait = undefined, _text, _speed = 0.55, _showBox = true, _boxPos = "dynamic", _wait=false, _showCursor = true) {
    ///@arg speaker
    ///@arg portrait
    ///@arg text
    ///@arg speed
    ///@arg showBox
    ///@arg position            - "bottom"    "top"    "dynamic"
	///@arg showCursor 
    
    if(!_showBox) {
        if !instance_exists(WRITER) { instance_create_depth(0,0,-999,WRITER) }
        if instance_exists(WRITER) with(WRITER) {
            switch _speaker {
                case "gen":
                case "gen2":
                case "asg":
                    // Use the medium font for generic characters
                    dialogue.dialogueFont = loc_get_font("fnt_main");
                    break;
                case "sans":
                    // Use the sans font for Sans character
                    dialogue.dialogueFont =loc_get_font("fnt_sans");
                    break;
                case "paps":
                    dialogue.dialogueFont = loc_get_font("fnt_papyrus")
                    break;
                default:
                    // Default to medium font
                    dialogue.dialogueFont = loc_get_font("fnt_main_small");
                    break;
            }
            
            dialoguePosition = _boxPos;
            
            if _portrait != undefined {
                switch _speaker {
                    case "sans":
                    case "asg":
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
                    case "asg":
						dialogue.dialogueVoice = undefined;
                        dialogue.dialogueVoice = (global.characters).asg.voice;
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
                    // Set font for Sans
                     dialogueFont = loc_get_font("fnt_sans");
                    break;
                case "paps":
                    displayFace = _portrait;
                    // Set font for Papyrus
                     dialogueFont = loc_get_font("fnt_papyrus");
                    break;
                case "asg":
                    displayFace = _portrait;
                    // Set font for Asg
                    dialogueFont = loc_get_font("fnt_main");
                    break;
                case "gen":
                case "gen2":
                    displayFace = spr_blank;
                    // Set font for generic characters
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
                case "asg":
					voiceSound = undefined;
                    voiceSound = (global.characters).asg.voice;
                    displayName = (global.characters).asg.char_name;
                    speaker = (global.characters).asg;
                    dialogueSpeaker = "asg";
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