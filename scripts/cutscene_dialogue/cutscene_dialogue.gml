function cutscene_dialogue(_font = fnt_main_small, _portrait = undefined, _voice = undefined, _text = "", _showBox = true, _boxPos = "dynamic", runcode = function() {}){
///@arg font
///@arg portrait
///@arg voice
///@arg text
///@arg showBox
///@arg boxPos - "botton"   "top"   "dynamic"
///@arg runcode
dialogue_setup(_font,_portrait,_voice,_text,_showBox,_boxPos, runcode)
if(instance_exists(obj_text_writer)){
	with(obj_text_writer){
		dialogue.dialogueText = _text;	
		dialogue.dialogueFont = _font;
	}
}
cutscene_end_action();
}