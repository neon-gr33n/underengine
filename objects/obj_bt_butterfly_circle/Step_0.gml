if (instance_exists(obj_bullet_butterfly)){
   if (!speech_bubble_exists()){
	_timer --;
	 sinTimer++;
	}

    // Update circle properties
    //var _pulse = sin(sinTimer * pulse_speed) * pulse_amount;
    var _current_radius = radius;

    // Update all bullets in the circle
    for (var i = 0; i < bullet_count; i++) {
        // Check if bullet still exists
        if (!instance_exists(bullet_array[i])) {
            // Bullet was destroyed - skip it
            continue;
        }
    
        // Update angle with rotation
        bullet_angles[i] += rotation_speed;
        if (bullet_angles[i] >= 360) bullet_angles[i] -= 360;
    
        // Add individual flutter effect
        var _flutter = sin(sinTimer * 0.08 + i * 0.7) * 8;
    
        // Calculate final position - USE FIXED CENTER instead of HEART position
        var _final_radius = _current_radius + _flutter + bullet_radius_offsets[i];
        var _xpos = center_x + lengthdir_x(_final_radius, bullet_angles[i]);  // Changed
        var _ypos = center_y + lengthdir_y(_final_radius, bullet_angles[i]);  // Changed
    
        // Move bullet
        with (bullet_array[i]) {
            x = _xpos;
            y = _ypos;
        
            // Rotate sprite to face outward
            image_angle = other.bullet_angles[i] + 90;
        }
    }

    // End attack after duration
    if (_timer <= 0) {
        event_user(3);
    }
}