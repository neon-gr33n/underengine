///@category Overworld
///@title Internal

/// @func create_floating_text(_xx, _yy, _font, _color, _text, _voice, [_dur])
/// @desc Creates floating text at specified position with customizable appearance
/// @desc Creates an instance of obj_floating_text with text, font, color, and voice properties
/// @param {Number} _xx X position for floating text
/// @param {Number} _yy Y position for floating text  
/// @param {Font|String} _font Font asset or font name to use for text display
/// @param {Color} _color Text color constant (e.g., c_white, c_red, etc.)
/// @param {String} _text Text content to display
/// @param {Sound|Asset} _voice Voice sound asset to play with text (optional)
/// @param {Number} [_dur=300] Duration in frames before text disappears (default 300 frames = ~5 seconds at 60fps)
/// @return {Instance} Instance ID of the created floating text object
/// @example
/// // Create red damage text
/// create_floating_text(x, y, fnt_main, c_red, "-50", undefined, 120);
/// 
/// @example
/// // Create floating dialogue with voice
/// create_floating_text(PLAYER1.x, PLAYER1.y-50, fnt_sans, c_white, "hey.", snd_sans_v);
/// 
/// @example  
/// // Quick floating message (2.5 seconds)
/// create_floating_text(mouse_x, mouse_y, fnt_main_small, c_yellow, "Click!", undefined, 150);
function create_floating_text(_xx, _yy, _font, _color, _text, _voice, _dur = 300){
    var inst = instance_create_depth(
        _xx,
        _yy,
        -99999, obj_floating_text)
        
    with inst {
        __font = loc_get_font(__font)
        __color = _color
        __text = _text
        _voiceSound = _voice
        x = _xx
        y = _yy
        _duration = _dur
    }
    
    return inst;
}