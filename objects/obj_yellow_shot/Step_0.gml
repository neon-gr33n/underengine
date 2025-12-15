if(live_call()) return live_result;

if _big_shot == 2 {
	_x_off = irandom_range(-1, 1);
	_y_off = irandom_range(-1, 1);
}

if _trail {
	_trail_timer++;
	if _trail_timer == 2 {
		_trail_timer = 0;
		var _after = instance_create_depth(x + _x_off, y + _y_off, HEART.depth, obj_yellow_btrail);
		_after.image_speed = 0;
		_after.image_xscale = image_xscale;
		_after.image_yscale = image_yscale;
		_after.speed = 0;
		_after.friction = 0;
		_after.image_index = 1;
	}
}