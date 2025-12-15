if npc_interactable == true {
event_inherited();    
}


if npc_moving && sprite_index != undefined {
	image_speed = 1;
    if variable_instance_exists(id, "spriteMove") { 
	   sprite_index = spriteMove	
    }
} else if npc_talking { 
    if variable_instance_exists(id, "spriteTalk") { 
        sprite_index = spriteTalk; 
    }
} else {
    sprite_index = spriteIdle 
}
    
    
if (instance_exists(WRITER)) && id.inInteraction == true {
    // Check if all required variables exist
    var typewriter_exists = variable_instance_exists(WRITER, "typewriter_state");
    var portrait_exists = variable_instance_exists(WRITER, "hasDialoguePortrait");
    
    if (needs_portrait == true) {
        if (typewriter_exists && portrait_exists) {
            if (WRITER.typewriter_state != 1) {
                npc_talking = true;
                talk_frame += talk_speed;
                if (talk_frame >= sprite_get_number(sprite_index)) {
                    talk_frame = 0;
                }
            } else {
                talk_frame = 0;
                npc_talking = false;
            }
        } else {
            // If any variable is missing, use safe default
            talk_frame = 0;
            npc_talking = false;
        }
    } else {
        if (typewriter_exists) {
            if (WRITER.typewriter_state != 1) {
                npc_talking = true;
                talk_frame += talk_speed;
                if (talk_frame >= sprite_get_number(sprite_index)) {
                    talk_frame = 0;
                }
            } else {
                talk_frame = 0;
                npc_talking = false;
            }
        } else {
            // If any variable is missing, use safe default
            talk_frame = 0;
            npc_talking = false;
        }
    }
    
} else {
    talk_frame = 0;
    npc_talking = false;
}

if (npc_turnable && id.inInteraction == true) {
    // More robust turning logic that handles all cases
    switch (PLAYER1.direction) {
        case 270: // Player facing down
            id.direction = 90; // NPC faces up
            break;
        case 90: // Player facing up
            id.direction = 270; // NPC faces down
            break;
        case 360: // Player facing right
            id.direction = 180; // NPC faces left
            break;
        case 180: // Player facing left
            id.direction = 360; // NPC faces right
            break;
        default:
            // Fallback: face opposite direction using modulo arithmetic
            id.direction = (PLAYER1.direction + 180) % 360;
            break;
    }
} else {
    // Handle non-interaction cases
    switch (dir) {
        case "down":
            direction = 270;
            break;
        case "up":
            direction = 90;
            break;
        case "right":
            direction = 360;
            break;
        case "left": 
            direction = 180;
            break;
        default:
            // Keep current direction if unknown
            break;
    }
}


player_animate_sprite();