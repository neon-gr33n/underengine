function encounter_exists(){
	///@desc No arguments needed! simply checks if any encounter objects exist
	if array_length(global.enc_slot) != noone  {
		return true;	
	} 
	return false;
}