face = spr_port_flowey_test; 
_font = fnt_main_small
_text_comment = "Fuck you, smiley trashbag!";

__fade_out_dur = 120;
alarm[0] = __fade_out_dur;

depth=-9999999;
image_alpha = 0
TweenEasyMove(x, y, (x - 200), y, 0, 60, EaseLinear)
TweenFire(id, EaseLinear, 0, 0, 0, 30, "image_alpha", 0, 1)