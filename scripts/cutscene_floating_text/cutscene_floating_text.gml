/**
 * Creates floating text during a cutscene.
 * 
 * @example
 * // Floating text at position (100, 200) with blue color
 * cutscene_floating_text(100, 200, "fnt_main", c_blue, "Hello World!");
 * 
 * @example
 * // Floating text with voice sound and custom duration
 * cutscene_floating_text(300, 150, "fnt_sans", c_white, "nyeh heh heh!", snd_paps_v, 500);
 * 
 * @param {number} xPos - X position for the floating text
 * @param {number} yPos - Y position for the floating text
 * @param {string} font - Font name to use (e.g., "fnt_main", "fnt_sans")
 * @param {color} color - Text color (e.g., c_white, c_blue)
 * @param {string} text - The text to display
 * @param {sound} voice - Voice sound to play with text (optional)
 * @param {number} duration - How long text stays visible in frames (default 300)
 */
function cutscene_floating_text(_xx,_yy,_font,_color,_text,_voice,_dur = 300){
	//@desc Creates floating text
	///@arg xPos
	///@arg yPos
	///@arg font
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
	cutscene_end_action()
}