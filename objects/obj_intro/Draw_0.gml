// Draw sprite with fade effect
draw_sprite_ext(spr_intro, _image_index, 0, 0,1,1,0,c_white,_sprite_alpha);

// Draw text
draw_set_alpha(_alpha);
var scribble_object = scribble("[speed,0.2]"+_currentText)
	.starting_format(__font,__color)
	.wrap(640 - x + y)
	
if visible
scribble_object.draw(x,y,typist);

if _voiceSound != undefined
typist.sound_per_char([_voiceSound],true,1,1,);

// Reset alpha
draw_set_alpha(1);