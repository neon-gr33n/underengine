function dialogue_mini_say(_xx=160,_yy=460,_text,_face){
	///@desc Creates a mini face, like in Deltarune
	///@arg xPos
	///@arg yPos
	///@arg text
	///@arg face
	instance_create_depth(_xx,_yy,-99999999,obj_mini_face,
	{
		x: _xx,
		y: _yy, 
		_text_comment: _text,
		face: _face
	})
}