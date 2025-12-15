// Inherit the parent event
event_inherited();

if (_consoled && !_is_being_spared) {
    _is_being_spared = true;
    console_spare_enemy();
}