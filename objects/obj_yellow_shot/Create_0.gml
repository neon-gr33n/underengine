vspeed = -8;
_dmg = 1;
_trail = false;
_trail_timer = 0;
_x_off = 0;
_y_off = 0;

if _big_shot {
	sprite_index = spr_yellow_bshot;
	vspeed = _big_shot == 2 ? -2 : -9;
	image_index = 0;
	_trail = _big_shot - 1;
	_dmg = 4;
	_a = TweenFire(id, EaseLinear, 0, 0, 0, 10, "image_alpha", 0.5, 1);
	_x = TweenFire(id, EaseLinear, 0, 0, 0, 10, "image_xscale", 1.2, _big_shot == 2 ? 1.2 : 1);
	_y = TweenFire(id, EaseLinear, 0, 0, 0, 10, "image_yscale", 0.2, 1);
}