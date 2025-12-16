function contact_data_init(){
	global.CONTACTS={
		__CONTACTS__:{
			MAXCONTACTS: 8,
			CONTACTS: ["PLACEHOLDER"]
		},
		PLACEHOLDER:{
			NAME: "Test",
			CHOICES: [
				"Say Hello",
				"Flirt"
			],
			CHOICE_KEYS: ["T_HELLO", "T_FLIRT"], // Explicit order
			CHOICE_SCENES: {
				T_HELLO:[
					// 0
					[
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "gen", spr_blank, "* Hi back!"],
						[cutscene_wait_for_dialogue],
					],
				],
				T_FLIRT:[
					// 0
					[
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "gen", spr_blank, "* oh my..."],
						[cutscene_wait_for_dialogue],
					],
				]
			},
		}
	}
}