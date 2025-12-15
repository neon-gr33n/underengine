// Create all butterflies
if (!speech_bubble_exists()){
	// Get the battle box instance
    var _battle_box = instance_find(BOARD, 0); // Assuming there's one battle box
    
    if (instance_exists(_battle_box)) {
        // Calculate bottom right position
        var _bullet_x = _battle_box.x + (_battle_box.sprite_width / 2) - 20; // Adjust for bullet size
        var _bullet_y = _battle_box.y + (_battle_box.sprite_height / 2) - 20; // Adjust for bullet size
        
        // Create the bullet toad
        var _bullet = instance_create_depth(_bullet_x, _bullet_y, -501, obj_bullet_toad);        
	}
}