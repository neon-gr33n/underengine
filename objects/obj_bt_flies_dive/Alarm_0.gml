if (!_stop_attacking && !speech_bubble_exists()) {
    if (_fly_count < 5) {
        // Create fly at top of board with pause
        var fly_x = 0;
        var fly_y = 0;
        
        if (instance_exists(_board)) {
            fly_x = random_range(_board.x - _board.width/2 + 30, _board.x + _board.width/2 - 30);
            fly_y = _board.y - _board.height/2 + 10;
        } else {
            fly_x = random_range(100, 540);
            fly_y = 50;
        }
        
        var fly = instance_create_depth(fly_x, fly_y, -500, obj_bullet_fly);
        with (fly) {
            vspeed = 0;
            hspeed = 0;
            _is_fly_dive = true;
			_is_homing = true;
            _spawn_x = x;
            _spawn_y = y;
        }
    }
	
	with (obj_bullet_fly) {
	_is_fly_dive = true;
    if (variable_instance_exists(id, "_is_fly_dive")) {
        var heart = HEART;
        if (instance_exists(heart)) {
            var target_x = heart.x;
            var target_y = heart.y;
            var dir_x = target_x - x;
            var dir_y = target_y - y;
            var dist = point_distance(x, y, target_x, target_y);
            
            if (dist > 0) {
                hspeed = (dir_x / dist) * 1.5;
                vspeed = (dir_y / dist) * 1.5;
            }
        }
    }
}
    alarm[0] = 30;
    alarm[1] = _fly_delay;
}