function dialogue_setup(_speaker = "generic", _portrait = undefined, _text, _speed = 0.55, _showBox = true, _boxPos = "dynamic", runcode = function() {} ){
	///@arg speaker
	///@arg portrait
	///@arg text
	///@arg speed
	///@arg showBox
	///@arg position			- "bottom"	"top"	"dynamic
	///@arg runcode
	if(!_showBox){
	if !instance_exists(obj_text_writer){instance_create_depth(0,0,-999,obj_text_writer)}
	if instance_exists(obj_text_writer) with(obj_text_writer){
			typist.in(_speed,0);
			switch _speaker {
				case "gen":
				case "gen2":
					dialogue.dialogueFont = global.generic.font;
					break;
				case "sans":
					dialogue.dialogueFont = global.sans.font
				break;
			}
			dialoguePosition = _boxPos
			if _portrait != undefined {
				switch _speaker {
					case "sans":
						dialogue.dialoguePortrait = ds_map_find_value(global._sans_ports,_portrait);
					break;
				}
				hasDialoguePortrait = true;
			} else {
				hasDialoguePortrait = false;	
			}
			if _voice != undefined { 
					switch _speaker {
						case "gen":
							dialogue.dialogueVoice = global.generic.voice;
						break;
						case "gen2":
							dialogue.dialogueVoice = global.generic2.voice;
						break;
						case "sans":
							dialogue.dialogueVoice = global.sans.voice;
						break;
					}
			} else {
				// do nothing	
			}
			dialogue.dialogueText = _text;
		}
		var _runcode = runcode
		_runcode()
	} else if _showBox == true {
		if(!instance_exists(obj_text_box))
		instance_create_depth(0,0,-999,obj_text_box)
		if(instance_exists(obj_text_box)) with (obj_text_box) {
			switch _speaker {
				case "sans":
					displayFace = ds_map_find_value(global._sans_ports,_portrait);
				break;
			}
			switch _speaker {
						case "gen":
							voiceSound = global.generic.voice;
						break;
						case "gen2":
							voiceSound = global.generic2.voice;
						break;
						case "sans":
							voiceSound = global.sans.voice;
						break;
					}
			displaySpeed = _speed;
			dialoguePosition = _boxPos
			switch(_boxPos){
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
		}
	}
}