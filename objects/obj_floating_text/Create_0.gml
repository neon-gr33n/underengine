original_font = "fnt_outline"
__font = loc_get_font(original_font)
__color = "c_white"
__outline_color = c_black;
__text=""
_speed = 0.55;
_alpha = 0;
_voiceSound = undefined
_duration = 300;


typist = scribble_typist();
typist.in(_speed,1.2);
typewriter_state = 0;

depth=-999999999;

TweenFire(id, EaseLinear, 0, 0, 0, 30, "_alpha", 0, 1)

alarm[0] = _duration;