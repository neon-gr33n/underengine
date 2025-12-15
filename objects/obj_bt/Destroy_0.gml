if (variable_struct_exists(global, "temp_defense_boost")) {
    // Reduce turn counter
    global.temp_defense_boost.turns_remaining--;
    
    if (global.temp_defense_boost.turns_remaining <= 0) {
        // Restore original defense
        global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "DEF"] = global.temp_defense_boost.original_defense;
        
        // Clean up
        variable_struct_remove(global, "temp_defense_boost");
    }
}
with(obj_parent_battle_enemy){
	event_user(4);	
}