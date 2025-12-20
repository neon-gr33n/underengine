///@desc Initialize

for (i = 0; i <= 75; i += 1)
{
    remx[i] = x
    remy[i] = y
    remdir[i] = image_index
}

instance_lighting = noone;
light = noone;

image_speed = 0;
canMove = true;
moveSpeed = 1.3 * global.__delta_stepFactor;
walk_speed = 1.3 * global.__delta_stepFactor;
run_speed = 2.5 * global.__delta_stepFactor;
party_moving = false;
encounterStarted = false;

spriteIdle = global.PARTY_INFO[$(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0])][$"SPRITES"][$"IDLE"];
spriteMove = global.PARTY_INFO[$(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0])][$"SPRITES"][$"MOVE"];
spriteRun = global.PARTY_INFO[$(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0])][$"SPRITES"][$"RUN"];
local_frame = 0;

outline_col = c_red;

hsp = 0;
vsp = 0;

_hud_alpha=0;

dir = "undefined";

//for(i = 50; i >=0; i--)
//{
//	pos_x[i] = x;
//	pos_y[i] = y;
//}

#region DEFINE PLAYER "GENERIC" MOVEMENT STATE
statePlayerMoveGeneric = function()
{
		currentState = "playerMoveGen"
		// Actual movement code is handled in step, for now let's just activate the state
}
#endregion

#region DEFINE "CUTSCENE STASIS" STATE
stateCutsceneStasis = function()
{
	// this literally just stops movement from happening in step, very simple
	currentState = "inCutscene"
}
#endregion

#region DEFINE "SITTING" STATE
statePlayerSitGeneric = function()
{
	currentState = "sittingDown"	
}
#endregion

state = statePlayerMoveGeneric();
currentState = "playerMoveGen";