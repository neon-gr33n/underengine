// In obj_battle_speech_bubble Step Event:
if (instance_exists(_writer)) {
    // Keep text writer position updated
    _writer.x = x + 40;
    _writer.y = y + 15;
    
    // Check if text writer is done and should be destroyed
    if (_writer.typist.get_state() == 1 && input.action_pressed) {
        // If text writer destroys itself, also destroy the bubble
        if (!instance_exists(_writer)) {
            instance_destroy();
        }
    }
}

// Also update the draw event to handle flipping properly:
if (flipped_horizontal) {
    image_xscale = -1;
} else { 
    image_xscale = 1; 
}

if (flipped_vertical) {
    image_yscale = -1;
} else { 
    image_yscale = 1; 
}

switch(template){
    case "wide horizontal":
        sprite_index = spr_speechbub_wide_h;
        break;
    case "wide vertical":
        sprite_index = spr_speechbub_wide_v;
        break;
    case "top horizontal":
        sprite_index = spr_speechbub_top_h;
        break;
    case "bottom horizontal":
        sprite_index = spr_speechbub_btm_h;
        break;
}