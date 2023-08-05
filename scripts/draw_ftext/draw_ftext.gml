function draw_ftext(_font = fnt_main_small, _color = c_white, _xPos, _yPos,_xScale,_yScale,_textAngle,_stringValue){
	///@arg font
	///@arg color
	///@arg xPos
	///@arg yPos
	///@arg xScale
	///@arg yScale
	///@arg angle
	///@arg text
	draw_set_font(_font);
	draw_set_color(_color);
	draw_text_transformed(_xPos,_yPos,_stringValue,_xScale,_yScale,_textAngle);
}