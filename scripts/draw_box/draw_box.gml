function draw_box(_x1, _y1, _x2, _y2, outlineLength = 6, sprite = undefined) {
	// Initialize the variables
	var prevColor = draw_get_color();
	
	// Draw the box
	if (is_undefined(sprite)) {
		draw_set_color(c_white);
		draw_rectangle(_x1, _y1, _x2, _y2, false);
		draw_set_color(c_black);
		draw_rectangle(_x1 + outlineLength, _y1 + outlineLength, _x2 - outlineLength, _y2 - outlineLength, false);
	}
	else draw_sprite_stretched_ext(sprite, 0, _x1, _y1, _x2 - _x1, _y2 - _y1, c_white, 1);
	
	// Reset values
	draw_set_color(prevColor);
}