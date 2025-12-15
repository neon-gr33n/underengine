if (encounter_exists() && instance_exists(PLAYER1)) {
    if (show_exclamation) {
        var inst = instance_create_depth(0, 0, 0, obj_exclamation);
        
        // Get the player's current sprite information
        var player_sprite = PLAYER1.sprite_index;
        var sprite_w = sprite_get_width(player_sprite);
        var sprite_h = sprite_get_height(player_sprite);
        
        // Calculate centered position above player's head
        inst.x = PLAYER1.x - 5; // Already centered horizontally
        inst.y = PLAYER1.y - sprite_h / 2 - 27; // Above head with some padding
        
        var time = 30 + irandom(10);
        inst.time = time;
        audio_play_sound(snd_exclaim, 0, false);
        alarm[1] = time;
    } else {
        alarm[1] = 1;
    }
} else {
    instance_destroy();
}