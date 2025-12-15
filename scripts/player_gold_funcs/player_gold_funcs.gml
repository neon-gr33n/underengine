function player_set_gold(val){
	global.PARTY_INFO[$ "__PARTY__"][$ "STATS"][$ "GOLD"] = val;
}

function player_get_gold(){
	return global.PARTY_INFO[$ "__PARTY__"][$ "STATS"][$ "GOLD"];	
}

function player_deduct_gold(cost){
	global.PARTY_INFO[$ "__PARTY__"][$ "STATS"][$ "GOLD"] -= cost;	
}