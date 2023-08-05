///@desc Initialize
image_speed = 0;
canMove = true;
moveSpeed = 1;

spriteIdle = spr_frisk_idle;
spriteMove = spr_frisk_move;
local_frame = 0;

hsp = 0;
vsp = 0;

dir = "undefined";

for(i = 50; i >=0; i--)
{
	pos_x[i] = x;
	pos_y[i] = y;
}


#region DEFINE PLAYER "GENERIC" MOVEMENT STATE
statePlayerMoveGeneric = function()
{
		// Actual movement code is handled in step, for now let's just activate the state
}
#endregion

state = statePlayerMoveGeneric();
currentState = "playerMoveGen";