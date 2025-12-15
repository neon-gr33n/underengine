/**
 * Displays dialogue during a cutscene with automatic scene management.
 * 
 * @example
 * // Basic cutscene dialogue
 * cutscene_dialogue("sans", spr_port_sans_gen, "hey kid. long time no see.");
 * 
 * @example
 * // Fast dialogue without cursor
 * cutscene_dialogue("paps", spr_port_paps_normal, "NYEH HEH HEH!", 1.0, true, "top", false);
 * 
 * @example
 * // To modify cutscene flow:
 * // - Scene continues automatically to next dialogue unless cutscene_wait() is used
 * // - Each dialogue can have different wait behavior based on next scene action
 * 
 * @param {string} speaker - Character ID
 * @param {sprite} portrait - Character portrait sprite (optional)
 * @param {string} text - Dialogue text to display
 * @param {number} speed - Text display speed (0-1, default 0.6)
 * @param {boolean} showBox - Show dialogue box (true) or floating text (false)
 * @param {string} boxPos - Position: "bottom", "top", or "dynamic"
 * @param {boolean} showCursor - Show continue cursor at end of text
 */
function cutscene_dialogue(_speaker = "generic" , _portrait = undefined, _text = "", _speed = 0.6, _showBox = true, _boxPos = "dynamic", _showCursor = true){
///@arg speaker
///@arg portriat
///@arg text
///@arg speed
///@arg showBox
///@arg boxPos - "botton"   "top"   "dynamic"
///@arg showCursor
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
//	runcode();
	cutscene_end_action();
}
}

/**
 * Displays a sequence of dialogue lines in a cutscene (considering as a feature).
 * 
 * @example
 * // Planned usage - not fully implemented
 * var dialogueArray = [
 *     {speaker: "sans", text: "hey."},
 *     {speaker: "paps", text: "HELLO HUMAN!"},
 *     {speaker: "sans", text: "don't mind him."}
 * ];
 * cutscene_dialogue_array(dialogueArray);
 * 
 * @param {array} array - Array of dialogue objects with speaker and text properties
 */
function cutscene_dialogue_array(_array) {
	///@arg array - [{speaker: speaker,text: text},etc...]
	//setup={
	//	init: function() {
	//		if !instance_exists(WRITER) instance_create_depth(0,0,-99999999,WRITER)
	
	//		var __count=0;
	//	}
		
	//	process: function() {
	//	}
	//}
}