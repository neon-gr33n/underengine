image_yscale = init_yscale + (-sin(siner * 0.5) * amp);
image_xscale = init_yscale + (sin(siner * 0.5) * amp);

if (amp > 0)
    amp -= 0.03;
else
    amp = 0;
	
siner++;

if (interacted == 0 && input.down_pressed || input.up_pressed || input.right_pressed || input.left_pressed){
	image_alpha = 0;
    PLAYER1.currentState = "playerMoveGen";
    PLAYER1.y += 2;
    PLAYER1.dir = "down";
    PLAYER1.state = PLAYER1.statePlayerMoveGeneric();
    PLAYER1.image_alpha = 1;
    player_unfreeze();
    benched = 0;
	PLAYER1.dir = "undefined";
	instance_destroy();
}