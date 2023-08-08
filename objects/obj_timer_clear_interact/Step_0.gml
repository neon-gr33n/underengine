///@desc Process Timer Events
if (timer_check(timer)){
	if global._interacting != noone with (global._interacting)
	{
			canInteract = true;
			global._interacting = noone; // clear interaction
	}
}