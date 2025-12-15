draw_set_alpha(_alpha);

var currentFont = loc_get_font(original_font)
var scribble_object = scribble("[speed,0.2]" + "[alpha," + string(_alpha) + "]" + __text)
    .starting_format(currentFont, __color)
    .wrap(640);
	
scribble_object.draw(x, y, typist);

if _voiceSound != undefined {
    typist.sound_per_char([_voiceSound], true, 1, 1);
}