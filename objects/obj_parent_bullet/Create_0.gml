depth =-800;
if (!variable_instance_exists(id, "_base_damage")) {
    _base_damage = 2; // Default value
}

if (!variable_instance_exists(id, "_damage")) {
    _damage = 2; // Default value
}
has_hit = false;

// Call this to update damage based on difficulty
function update_difficulty_damage() {
    _damage = game_get_difficulty_damage(_base_damage);
}

// Initialize
update_difficulty_damage();
