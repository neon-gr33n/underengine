// Inherit the parent event
event_inherited();

if (_consoled && remaining_enemies == 0) { // Use remaining_enemies, not enemies_remaining
    encounter_end();
}