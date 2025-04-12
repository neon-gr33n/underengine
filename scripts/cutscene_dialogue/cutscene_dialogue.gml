function cutscene_dialogue(_speaker = "generic" , _portrait = undefined, _text = "", _speed = 0.55, _showBox = true, _boxPos = "dynamic", runcode = function() {}){
///@arg speaker
///@arg portriat
///@arg text
///@arg speed
///@arg showBox
///@arg boxPos - "botton"   "top"   "dynamic"
///@arg runcode
dialogue_setup(_speaker,_portrait,_text,_speed, _showBox,_boxPos, runcode)
if(instance_exists(obj_text_writer)){
	with(obj_text_writer){
		dialogue.dialogueText = _text;	
			switch _speaker {
				case "gen":
					dialogue.dialogueFont = global.generic.font;
					dialogue.dialogueVoice = global.generic.voice;
				break;	
				case "gen2":
					dialogue.dialogueFont = global.generic2.font;
					dialogue.dialogueVoice = global.generic2.voice;
					break;
				case "sans":
					dialogue.dialogueFont = global.sans.font;
					dialogue.dialogueVoice = global.sans.voice;
				break;
			}
		typist.in(_speed,0);
	}
}
cutscene_end_action();
}