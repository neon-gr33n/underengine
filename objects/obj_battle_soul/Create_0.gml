depth = -9999
_inv = 0;
_hurting=0;

#region DEFINE SOUL "MOVEMENT" STATE
stateSoulMovement = function()
{
	// Actual movement is handled in step
//	currentState = "soulMoving"
	event_user(1)
}	
#endregion

#region DEFINE SOUL "MENU" STATE
stateMenuSoul = function()
{
	// Soul will reset to "red" during this state
	currentState = "inMenu"	
}
#endregion
state = stateSoulMovement()
currentState = "soulMoving"

