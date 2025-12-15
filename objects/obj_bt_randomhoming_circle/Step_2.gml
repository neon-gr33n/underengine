if (instance_exists(obj_bullet_ring)){
    if (!speech_bubble_exists()){
        _timer--;
        sinTimer++;
    }

    // BALANCED HOMING VARIABLES
    var _homing_chance = 0.002; // Reduced from 0.0025 (0.2% chance)
    var _homing_speed = 1.8; // Reduced from 2.5
    var _homing_turn_speed = 0.08; // Reduced from 0.15 (slower turning)
    var _max_homing_distance = 150; // Bullets won't home beyond this distance
    
    // NEW: Add homing delay
    var _homing_start_delay = 30; // Frames before homing starts
    var _homing_acceleration = 0.05; // Gradually speed up
    var _player_prediction_offset = 0; // Don't predict too far ahead
    
    // Update circle properties
    var _current_radius = radius;
    
    // Get player position (CURRENT frame)
    var player_x = HEART.x;
    var player_y = HEART.y;

    // Update all bullets in the circle
    for (var i = 0; i < bullet_count; i++) {
        // Check if bullet still exists
        if (!instance_exists(bullet_array[i])) {
            continue;
        }
        
        var bullet = bullet_array[i];
        
        // NEW: Check if bullet is close enough to home
        var dist_to_player = point_distance(bullet.x, bullet.y, player_x, player_y);
        
        // Check if this bullet is already homing
        if (bullet._is_homing == true) {
            // UPDATE HOMING BEHAVIOR - DODGEABLE VERSION
            if (bullet._homing_active && dist_to_player < _max_homing_distance) {
                
                // HOMING DELAY: Don't start homing immediately
                if (bullet._homing_delay > 0) {
                    bullet._homing_delay--;
                    // Keep bullet moving in original direction during delay
                    bullet.x += lengthdir_x(bullet._initial_speed, bullet._initial_direction);
                    bullet.y += lengthdir_y(bullet._initial_speed, bullet._initial_direction);
                    continue;
                }
                
                // DODGEABLE TARGETING: Don't aim directly at player
                // Option 1: Aim slightly behind player (dodgeable by moving)
                var target_offset_x = 0;
                var target_offset_y = 0;
                
                // Add slight randomness to targeting
                if (bullet._target_offset_timer <= 0) {
                    bullet._target_offset_x = random_range(-15, 15);
                    bullet._target_offset_y = random_range(-15, 15);
                    bullet._target_offset_timer = 20 + irandom(20);
                } else {
                    bullet._target_offset_timer--;
                }
                
                // Calculate target with offset and slight prediction
                var target_x = player_x + bullet._target_offset_x;
                var target_y = player_y + bullet._target_offset_y;
                
                // Option 2: Predict player movement (but not perfectly)
                var player_xvel = HEART.x - HEART.xprevious;
                var player_yvel = HEART.y - HEART.yprevious;
                
                // Limit prediction to make it dodgeable
                var prediction_multiplier = clamp(abs(player_xvel) + abs(player_yvel), 0, 2);
                target_x += player_xvel * 5 * prediction_multiplier; // Reduced from 10
                target_y += player_yvel * 5 * prediction_multiplier;
                
                // Calculate desired direction
                var desired_dir = point_direction(bullet.x, bullet.y, target_x, target_y);
                
                // LIMIT TURNING RATE - THIS IS KEY FOR DODGEABILITY
                var angle_diff = angle_difference(desired_dir, bullet.direction);
                var max_turn = _homing_turn_speed * 30; // Degrees per frame max
                
                if (abs(angle_diff) > max_turn) {
                    desired_dir = bullet.direction + sign(angle_diff) * max_turn;
                }
                
                // Update direction
                bullet.direction = lerp_angle(bullet.direction, desired_dir, _homing_turn_speed);
                
                // GRADUAL ACCELERATION - not instant speed
                var current_speed = bullet._current_homing_speed;
                current_speed = min(current_speed + _homing_acceleration, _homing_speed);
                bullet._current_homing_speed = current_speed;
                
                // Move bullet
                bullet.x += lengthdir_x(current_speed, bullet.direction);
                bullet.y += lengthdir_y(current_speed, bullet.direction);
                
                // Rotate sprite
                bullet.image_angle = bullet.direction;
                
                // Decrease homing time
                bullet._homing_time--;
                if (bullet._homing_time <= 0) {
                    bullet._homing_active = false;
                    // Slow down when done homing
                    bullet._current_homing_speed *= 0.5;
                }
            } else if (dist_to_player >= _max_homing_distance) {
                // Too far - stop homing
                bullet._homing_active = false;
            }
            continue;
        }
        
        // RANDOM HOMING TRIGGER - WITH CONDITIONS
        // Don't home if too far from player
        if (dist_to_player < _max_homing_distance && 
            random(1) < _homing_chance && 
            !bullet._triggered_homing) {
            
            // Setup homing bullet with DODGEABLE parameters
            bullet._is_homing = true;
            bullet._homing_active = true;
            bullet._triggered_homing = true;
            bullet._homing_time = 120 + irandom(60); // 2-3 seconds
            bullet._homing_delay = 10 + irandom(20); // Random delay before starting
            bullet._current_homing_speed = _homing_speed * 0.5; // Start slower
            bullet._target_offset_timer = 0;
            bullet._target_offset_x = 0;
            bullet._target_offset_y = 0;
            
            // Store initial movement for delay period
            bullet._initial_speed = 1.5;
            bullet._initial_direction = bullet.direction;
            
            // Set initial direction TOWARD PLAYER BUT WITH OFFSET
            var offset_angle = random_range(-30, 30); // Aim slightly off
            bullet.direction = point_direction(bullet.x, bullet.y, player_x, player_y) + offset_angle;
            
            // Visual feedback (optional)
            bullet.image_blend = merge_color(c_white, c_yellow, 0.5);
            
            continue;
        }

        // NORMAL CIRCLE POSITIONING (for non-homing bullets)
        bullet_angles[i] += rotation_speed;
        if (bullet_angles[i] >= 360) bullet_angles[i] -= 360;

        // Add individual flutter effect
        var _flutter = sin(sinTimer * 0.08 + i * 0.7) * 8;

        // Calculate final position
        var _final_radius = _current_radius + _flutter + bullet_radius_offsets[i];
        var _xpos = center_x + lengthdir_x(_final_radius, bullet_angles[i]);
        var _ypos = center_y + lengthdir_y(_final_radius, bullet_angles[i]);

        // Move bullet
        bullet.x = _xpos;
        bullet.y = _ypos;
        bullet.image_angle = bullet_angles[i] + 90;
    }

    // End attack after duration
    if (_timer <= 0) {
        event_user(3);
    }
}