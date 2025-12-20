{
	global.ENEMY_INFO = {
		__ENEMY__:  {
			ENEMIES: [noone,noone,noone],
		},
		
		NULL : {
			NAME: "[c_gray]-----------[/c]"	
		},
		
		GENO: {
			OBJECT: obj_battle_enemy_geno,
			STATS: {
				HP: 1,
				MAX_HP: 1,
				ATK: 0,
				DEF: 0,
			},
		},
		
		
		#region RANDOM ENCOUNTER ENEMIES (Empty - bring your own!)
		TEST: {
		    NAME: "Example",
		    OBJECT: obj_battle_enemy_example,
		    XP_GAIN: 50000,
		    GOLD_GAIN: 40,
		    STATS: {
		        HP: 40,
		        MAX_HP: 40,
		        ATK: 4,
		        DEF: 1,
		    },
    
		    // DYNAMIC ACT SYSTEM
		    ACTS: {
		        // Each ACT has: name, responses, and mercy requirements
		        "Check": {
					display_name: function() { return loc_gettext("bt.act.check"); },
		            responses: [
		               "* This is an example encounter!"
		            ],
		            mercy_effect: 0,
		            repeatable: false
		        },
		        "Threaten": {
					display_name: function() { return loc_gettext("bt.act.threaten"); },
		            responses: [
		                "* You threaten example, it seems scared."
		            ],
		            mercy_effect: 1,
		            repeatable: true
		        },
			   "Compliment": {
				   	display_name: function() { return loc_gettext("bt.act.compliment"); },
		            responses: [
						"* You compliment example, it seems happy."
		            ],
		            mercy_effect: 1,
		            repeatable: true
		        },
		    },
    
		    // MERCY SYSTEM
		    MERCY_REQUIREMENTS: {
		        required_acts: ["Compliment"],
		        required_count: 1,
		        custom_check: function(enemy_state) {
					return array_contains(enemy_state.completed_acts, "Compliment");
		        }
		    },
    
			SPARE_WITH_ALLY: false,
		    DESCRIPTION: "Toaddit reluctantly approaches!"
		},
		#endregion
	}
}