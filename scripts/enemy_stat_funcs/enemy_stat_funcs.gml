function enemy_get_stat(slot, stat){
	return global.ENEMY_INFO[$ global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][slot]][$ "STATS"][$ stat]
}

function enemy_set_stat(slot, stat, value){
	global.ENEMY_INFO[$ global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][slot]][$ "STATS"][$ stat] = value
}