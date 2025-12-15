slide_spd = 0;
sliding = 0;
slidetimer = 0;
audio_stop_sound(snd_surf)
image_alpha = 0;
PLAYER1.currentState = "playerMoveGen";
PLAYER1.dir = "down";
PLAYER1.state = PLAYER1.statePlayerMoveGeneric();
CAM.following = PLAYER1;
PLAYER1.image_alpha = 1;
player_unfreeze();
PLAYER1.dir = "undefined";
PLAYER1.canMove = true;
instance_destroy();