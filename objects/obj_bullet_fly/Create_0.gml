///@desc Init
_base_damage = 2;

event_inherited();

image_speed=0.5

// Only target player if it's a dive fly AND not a gentle fly
_is_fly_dive = false;
_is_gentle = false;
_is_homing = false;
_should_target = false;

// Check what type of fly this is
if (_is_homing) {
    move_towards_point((HEART.x+2), (HEART.y+2), 2.5);
    _should_target = true;
}
alarm[0] = 30;
alarm[1] = 45;