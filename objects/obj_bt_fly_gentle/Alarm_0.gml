if (!_stop_attacking && !speech_bubble_exists()) {
    if (_fly_count < 20) {
        // Create gentle fly at top
        var fly_x = 0;
        var fly_y = 0;
        
        if (instance_exists(_board)) {
            fly_x = random_range(_board.x - _board.width/2 + 20, _board.x + _board.width/2 - 20);
            fly_y = _board.y - _board.height/2 + 10;
        } else {
            fly_x = random_range(100, 540);
            fly_y = 50;
        }
        
        var fly = instance_create_depth(fly_x, fly_y, -500, obj_bullet_fly);
        with (fly) {
            _is_gentle = true;
            hspeed = random_range(-0.5, 0.5);
            vspeed = random_range(1, 2);
            image_angle = random_range(-5, 5);
        }
    }
    alarm[0] = 15;
    alarm[1] = 8;
}