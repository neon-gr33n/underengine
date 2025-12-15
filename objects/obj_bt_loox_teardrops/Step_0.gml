if (!speech_bubble_exists()) {
    _timer -= 1;
}

if (_timer <= 0) {
	event_user(3);
}
// Update all existing teardrops
for (var i = 0; i < array_length(_teardrops_array); i++) {
    var teardrop = _teardrops_array[i];
    
    if (instance_exists(teardrop)) {
        // Apply acceleration
        teardrop._current_speed += teardrop._fall_acceleration;
        
        // Calculate horizontal spread (ease-out effect)
        if (teardrop._spread_delay <= 0) {
            teardrop._spread_progress = min(teardrop._spread_progress + 1, teardrop._max_spread_progress);
            
            // Ease-out curve: fast at first, slows down
            var spread_ratio = teardrop._spread_progress / teardrop._max_spread_progress;
            var ease_spread = 1 - (1 - spread_ratio) * (1 - spread_ratio); // Quadratic ease-out
            
            // Calculate horizontal movement
            var horizontal_move = teardrop._horizontal_spread * ease_spread;
            
            // Add slight wobble to the fall (like tears rolling down cheek)
            var wobble = sin(current_time * teardrop._wobble_speed + teardrop._sine_offset) * teardrop._wobble_amount;
            
            // Update position
            teardrop.x += horizontal_move * 0.1; // Spread horizontally
            teardrop.y += teardrop._current_speed; // Fall downward
            teardrop.x += wobble * 0.5; // Small horizontal wobble
            
            // Update sprite angle to follow movement
            teardrop.image_angle = 0 + (horizontal_move * 0.5); // Tilt based on horizontal movement
            
            // Check for shatter at bottom of screen
            var cam_y = camera_get_view_y(view_camera[0]);
            var cam_height = camera_get_view_height(view_camera[0]);
            
            if (teardrop.y > cam_y + cam_height + 32) {
	            _teardrops_array[i] = noone;
            }
        } else {
            teardrop._spread_delay--;
            // Initial drop before spreading
            teardrop.y += teardrop._current_speed * 0.5;
        }
    } else {
        _teardrops_array[i] = noone;
    }
}
