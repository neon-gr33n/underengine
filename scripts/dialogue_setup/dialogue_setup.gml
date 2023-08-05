function dialogue_setup(_font = fnt_main_small, _portrait = undefined, _voice, _text, _showBox = true, _boxPos = "dynamic", runcode = function() {} ){
	///@arg font
	///@arg portrait
	///@arg voice
	///@arg text
	///@arg showBox
	///@arg position			- "bottom"	"top"	"dynamic
	if(!_showBox){
	instance_create_depth(0,0,-999,obj_text_writer)
	if instance_exists(obj_text_writer) with(obj_text_writer){
			dialogue.dialogueFont = _font;
			if _portrait != undefined {
				dialogue.dialoguePortrait = _portrait;
				hasDialoguePortrait = true;
			} else {
				hasDialoguePortrait = false;	
			}
			if _voice != undefined { 
				dialogue.dialogueVoice = _voice;
			} else {
				// do nothing	
			}
			dialogue.dialogueText = _text;
		}
		runcode();
	} else if _showBox == true {
		instance_create_depth(0,0,-999,obj_text_box)
		if(instance_exists(obj_text_box)) with (obj_text_box) {
			displayFace = _portrait;
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