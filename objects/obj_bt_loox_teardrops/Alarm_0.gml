if (!_stop_attacking && !speech_bubble_exists()) {
    if (_teardrops_created < _teardrop_count) {
        // INITIAL CLUSTER CREATION
        // Get Loox's eye position
        var loox = global.enc_slot[obj_battle_handler.enemyChoice];
        if (instance_exists(loox)) {
            _origin_x = loox.x;
            _origin_y = loox.y - 25;
        } else {
            // Fallback position
            _origin_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * 0.75;
            _origin_y = camera_get_view_y(view_camera[0]) + 80;
        }
        
        // Create up to 3 tears at once
        var create_count = min(3, _teardrop_count - _teardrops_created);
        for (var i = 0; i < create_count; i++) {
            var cluster_x = _origin_x + random_range(-_cluster_radius, _cluster_radius);
            var cluster_y = _origin_y + random_range(-_cluster_radius/2, _cluster_radius/2);
            
            var teardrop = instance_create_depth(cluster_x, cluster_y, -500, obj_bullet_teardrop);
            
            // Set teardrop properties using direct assignment
            teardrop._fall_speed = _teardrop_speed;
            teardrop._fall_acceleration = 0.05;
            teardrop._current_speed = _teardrop_speed;
            teardrop._horizontal_spread = random_range(-1, 1) * _spread_amount;
            teardrop._spread_progress = 0;
            teardrop._max_spread_progress = 180;
            teardrop._sine_offset = random(360);
            teardrop._wobble_amount = random_range(3, 8);
            teardrop._wobble_speed = random_range(0.05, 0.1);
            teardrop.direction = 90 + random_range(-10, 10);
            teardrop.image_angle = teardrop.direction;
            teardrop.speed = 0;
            teardrop._spread_delay = irandom(10);
            
            _teardrops_array[_teardrops_created] = teardrop;
            _teardrops_created += 1;
        }
        
        // Set next alarm
        if (_teardrops_created < _teardrop_count) {
            alarm[0] = 8;
        } else {
            alarm[0] = 30;
        }
        
    } else {
        // CONTINUOUS CRYING MODE
        if (random(1) < 0.3) {
            var loox = global.enc_slot[obj_battle_handler.enemyChoice];
            if (instance_exists(loox)) {
                _origin_x = loox.x;
                _origin_y = loox.y - 21;
                
                var teardrop = instance_create_depth(_origin_x, _origin_y, -500, obj_bullet_teardrop);
                
                // Set teardrop properties
                teardrop._fall_speed = _teardrop_speed;
                teardrop._fall_acceleration = 0.05;
                teardrop._current_speed = _teardrop_speed;
                teardrop._horizontal_spread = random_range(-1, 1) * _spread_amount;
                teardrop._spread_progress = 0;
                teardrop._max_spread_progress = 180;
                teardrop._sine_offset = random(360);
                teardrop._wobble_amount = random_range(2, 6);
                teardrop._wobble_speed = random_range(0.03, 0.08);
                teardrop.direction = 180 + random_range(-15, 15);
              //  teardrop.image_angle = teardrop.direction;
                teardrop.speed = 0;
                teardrop._spread_delay = irandom(15);
                
                // Find empty slot in array
                for (var i = 0; i < array_length(_teardrops_array); i++) {
                    if (!instance_exists(_teardrops_array[i])) {
                        _teardrops_array[i] = teardrop;
                        break;
                    }
                }
            }
        }
        alarm[0] = 1;
    }
}