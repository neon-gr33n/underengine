// Create all butterflies
if (!speech_bubble_exists()){
	for (var i = 0; i < bullet_count; i++) {
	    // Calculate starting position around the FIXED center
	    var _angle = (360 / bullet_count * i);
	    var _xpos = center_x + lengthdir_x(radius, _angle);  // Use center_x
	    var _ypos = center_y + lengthdir_y(radius, _angle);  // Use center_y
    
	    // Create bullet
	    var _bullet = instance_create_depth(_xpos, _ypos, -500, obj_bullet_ring);
    
	    // Store bullet reference and data
	    bullet_array[i] = _bullet;
	    bullet_angles[i] = _angle;
	    bullet_radius_offsets[i] = random_range(-5, 5);
    
	    // Set bullet properties
	    _bullet.image_angle = _angle + 90;
	}
}