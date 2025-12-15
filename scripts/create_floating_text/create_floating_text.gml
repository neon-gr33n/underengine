function create_floating_text(_xx,_yy,_font,_color,_text,_voice,_dur = 300){
	//@desc Creates floating text
	///@arg xPos
	///@arg yPos
	///@arg color
	///@arg text
	///@arg voice
	///@arg duration
	var inst = instance_create_depth(
		_xx,
		_yy,
		-99999,obj_floating_text)
		
	with inst {
		__font = loc_get_font(__font)
		__color = _color
		__text = _text
		_voiceSound = _voice
		x =_xx
		y = _yy
		_duration = _dur
	}
}