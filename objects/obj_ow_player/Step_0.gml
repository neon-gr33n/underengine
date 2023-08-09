/// @desc Update State
if currentState == "playerMoveGen" {
	keyLeft = inputdog_down("left")
	keyRight = inputdog_down("right")
	keyUp = inputdog_down("up")
	keyDown = inputdog_down("down")
	keyInteract =  inputdog_down("select")
		
	xAxis = keyRight - keyLeft;
	yAxis = keyDown - keyUp;
		
	inputDirection = point_direction(0,0,xAxis,yAxis);
	inputMagnitude = (xAxis != 0 || yAxis != 0)
		
	var mvspeed = moveSpeed;
	image_speed = 1;
		
	hsp = lengthdir_x(inputMagnitude * mvspeed, inputDirection);
	vsp  = lengthdir_y(inputMagnitude * mvspeed, inputDirection);
	
	move_and_collide(hsp,vsp,obj_solid,mvspeed);
		
	//PLAYER FOLLOWERS
	if (x!= xprevious or y!= yprevious)
	{
		for(i = 50; i > 0; i--)
		{
			pos_x[i] = pos_x[i-1];
			pos_y[i] = pos_y[i-1];
		}
			pos_x[0] = x;
			pos_y[0] = y;
		}

		
	if(inputdog_pressed("menu")){
		instance_create_depth(0,0,-9999,obj_cmenu);
	}
		
	//ANIMATION
	var _old_sprite = sprite_index;
	if (inputMagnitude != 0 && currentState == "playerMoveGen")
	{
		dir = "undefined"; // Set "dir" override variable to undefined so that we can manually set direction as we walk around the room
		direction = inputDirection;
		sprite_index = spriteMove;
	}
	else {sprite_index = spriteIdle;}
	if (_old_sprite != sprite_index) local_frame = 0;
		
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
} 

if currentState == "inCutscene" 
{
	image_speed = 0;
	// * I.. I CAN'T DO ANYTHING
	// * MY LEGS ARE FUCKIN' BROKEN
	// * I'M IN A GODDAMNED WHEELCHAIR
}