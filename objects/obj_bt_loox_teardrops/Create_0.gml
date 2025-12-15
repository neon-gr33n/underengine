// Inherit the parent event
event_inherited();

_stop_attacking = false;
_timer = 0;
_teardrop_count = 8; // More tears for better effect
_teardrops_created = 0;
_teardrop_speed = 1.5;
_spread_amount = 120; // How much tears spread horizontally as they fall
_cluster_radius = 20; // How clustered tears start at the eye
_teardrops_array = array_create(_teardrop_count);
_origin_x = 0;
_origin_y = 0;

event_user(0);
alarm[0] = 5; // Faster creation for cluster effect

