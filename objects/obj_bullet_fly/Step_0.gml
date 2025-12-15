// Inherit the parent event
event_inherited();

if (variable_instance_exists(id, "_is_gentle") && _is_gentle) {
    // Gentle flies should NOT target - they already have hspeed/vspeed set by the attack
    // Do nothing - keep their current movement
} else if (variable_instance_exists(id, "_is_fly_dive") && _is_fly_dive) {
} else if (_should_target) {

}