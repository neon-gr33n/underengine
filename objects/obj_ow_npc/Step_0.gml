event_inherited();

if npc_moving == true && sprite_index != undefined {
	image_speed = 1;
	sprite_index = spriteMove	
} else { sprite_index = spriteIdle };

switch dir {
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
}

player_animate_sprite();