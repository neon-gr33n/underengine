function encounter_adjust_name(){
	///@arg enemyName
	///@arg target
	var name = argument0;
	var target = argument1;
	global.enc_name[target] = name;
}