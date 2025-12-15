encounter_steps_current = 0;
steps_until_encounter = 0;
monsters_killed = party_get_stat("KILLS")
area_kills_needed = [20,36];
player_lv = member_get_stat(party_get_leader(), "LV")
encounter_chance_base = random_range(250,450); // Base steps for encounter
calculate_next_encounter();
battlegroups = [
	[] 
]
// Function to calculate steps until next encounter
function calculate_next_encounter() {
	var base_chance = encounter_chance_base;
	
	area_kills_needed[flag_get(global.flags,"section")] -= monsters_killed;
    
    // DECREASE encounter rate based on monsters killed
    var kill_modifier = max(0.1, 1 - 0.15); // 15% decrease per kill, min 10%
    
    // Increase encounter rate based on LV (higher LV = more frequent encounters)
    var lv_modifier = 1 + ((player_lv - 1) * 0.15); // 15% increase per LV
    
    var total_modifier = kill_modifier * lv_modifier;
    
    // Calculate steps with some randomness
    steps_until_encounter = max(5, irandom_range(
        base_chance / total_modifier * 0.7, 
        base_chance / total_modifier * 1.3
    ));
    
    encounter_steps_current = 0;
}

function check_encounter_step() {
    obj_random_encounter_handler.encounter_steps_current++;
    
    if (obj_random_encounter_handler.encounter_steps_current >= obj_random_encounter_handler.steps_until_encounter) {
		if ( flag_get(global.flags,"section_kills") >= area_kills_needed[flag_get(global.flags,"section")]){
            if(!instance_exists(obj_text_box)){
                // do geno specific behavior here
            }
		
		} else {
		 if(!instance_exists(obj_text_box)){
			 var area = flag_get(global.flags,"section")
			 var _group = battlegroups[area]
			 var _encounter = _group[irandom(array_length(_group) - 1)];
            encounter_start(_encounter); 
            }	
		}
		PLAYER1.encounterStarted = true;
        calculate_next_encounter();
    }
}
