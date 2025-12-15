// Attack settings
bullet_count = 16;
radius = 80;
rotation_speed = 2;
pulse_speed = 0.05;
pulse_amount = 10;
_timer = 180;  // Duration in frames
sinTimer = 0;

// Store bullet IDs in an array
bullet_array = array_create(bullet_count);
bullet_angles = array_create(bullet_count);
bullet_radius_offsets = array_create(bullet_count);

// Store FIXED center position (where to create the circle)
center_x = HEART.x;  // Store HEART's position at creation time
center_y = HEART.y;

event_user(0);

alarm[0] = 30;
