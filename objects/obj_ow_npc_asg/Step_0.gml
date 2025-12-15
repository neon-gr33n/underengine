if (instance_exists(WRITER)) {
    // Check if all required variables exist
    var typewriter_exists = variable_instance_exists(WRITER, "typewriter_state");
    var portrait_exists = variable_instance_exists(WRITER, "hasDialoguePortrait");
    
    if (typewriter_exists && portrait_exists) {
        if (WRITER.typewriter_state != 1) {
            talk_frame += talk_speed;
            if (talk_frame >= sprite_get_number(sprite_index)) {
                talk_frame = 0;
            }
        } else {
            talk_frame = 0;
        }
    } else {
        // If any variable is missing, use safe default
        talk_frame = 0;
    }
} else {
    talk_frame = 0;
}