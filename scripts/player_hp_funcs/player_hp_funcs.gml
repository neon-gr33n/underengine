// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_get_max_hp(){
 return global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "MAX_HP"];
}

function player_get_hp(){
 return global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"];
}

///@desc Heals the player
///@arg {int} index - Target party member to heal
///@arg {int} value - Default value is max hp
///function: player_heal()
///return: Integer
function player_heal(_ind = 0, _value = global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][_ind]][$ "STATS"][$ "MAX_HP"]){
	global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][_ind]][$ "STATS"][$ "HP"] = _value;
}