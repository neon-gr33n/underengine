// Shell scripts can be defined here
// Method names must start with sh_, but will not include that when being invoked
// For example, to invoke sh_test_method from an rt-shell, you would simply type test_method
// 
// If a method returns a string value, it will be print to the shell output

function sh_change_room(args) {
//	var rM = args[0]
	room_goto(asset_get_index(args[1]))
}

function sh_gj_login(){
	global.gj_login_open = true;
	room_goto(rm_gj_menu);
}
#region Save File related commands
function sh_save_game(args){
	savegame(args[1])
}

function sh_load_game(args){
	loadgame(args[1])	
	ini_open("underengine.ini");
	global.loadroom=ini_read_real("General-SL"+string(global.filechoice),"room",1)
	ini_close();
}

function sh_delete_save(args){
	file_delete("file"+args[1])	
}
#endregion

function sh_suicide(){
	global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"] = 0
}

function sh_enc_start(args){
	encounter_start(args[1])	
}

// meta_* functions must follow this return output
// "arguments" is for showing the arguments in your input string
// "suggestions" is for showing you autocomplete suggestions for each argument
// The index of "suggestions" corresponds to the argument number
function meta_change_room() {
	return {
		arguments: ["roomIndex"],
	}
}

function meta_save_game(){
	return {
		arguments: ["fileIndex"],
	}
}

function meta_load_game(){
	return {
		arguments: ["fileIndex"],
	}
}

function meta_delete_save(){
	return {
		arguments: ["fileIndex"],
	}
}