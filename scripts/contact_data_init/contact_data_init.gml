function contact_data_init(){
	global.CONTACTS={
		__CONTACTS__:{
			MAXCONTACTS: 8,
			CONTACTS: ["ASGORE"]
		},
		ASGORE:{
			NAME: "Asgore",
			CHOICES: [
				"Say Hello",
				"Call Him 'Dad'",
				"About Yourself",
				"Flirt"
			],
			CHOICE_KEYS: ["T_HELLO", "T_DADDY", "T_ABOUT", "T_FLIRT"], // Explicit order
			CHOICE_SCENES: {
				T_HELLO:[
					// 0
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_hello"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_panic_l, "* Oh? [delay,300] You only called# to say hello...?[delay,500]#* Well then."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* \"Hello\"!"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_wink, "* I hope that suffices!"],
						[cutscene_wait_for_dialogue],
						[cutscene_flag_set,global.flags,"casg_hello",1],
						[cutscene_end]
					],
					// 1
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_hello"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_panic_l, "* You feel like saying# hello again?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* \Greetings\"!"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_wink, "* Will that suffice?"],
						[cutscene_wait_for_dialogue],
						[cutscene_flag_set,global.flags,"casg_hello",2],
						[cutscene_end]
					],
					// 2
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_hello"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_panic_l, "* Hello, small one."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* Forgive me, I find myself# at a loss for words."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_sigh, "* Though it was wonderful# to hear your voice."],
						[cutscene_wait_for_dialogue],
						[cutscene_flag_set,global.flags,"casg_hello",2],
						[cutscene_end]
					]
				],
				T_DADDY:[
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_dad"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_concern, "* ..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* Did you... [delay,300]#just call me \"Daddy\"?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* Would that make you happy?#* To call me \"Father\"?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_panic_l, "* Well then, call me#whatever you would like!"],
						[cutscene_wait_for_dialogue],
						[cutscene_run_code,function(){global.flags[? "casg_dad"]++; show_debug_message("Flag was set to:" + string(global.flags[? "casg_dad"]))}],
						[cutscene_end]
					]
				],
				T_ABOUT:[
				// 0
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_about"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* You want to know more# about me?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* Well, [delay, 500] I am afraid there is# not much to say."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_wink, "* I am just a simple gardener# who dreams of better days."],
						[cutscene_wait_for_dialogue],
						[cutscene_end]
					]
				],
				T_FLIRT:[
					// 0
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_flirt"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_excited, "* This is ASGORE."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_concern, "* ..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* Oh... heh heh...#* Ha ha ha!"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_wink, "* How endearing... [delay,400]#* I could ruffle your hair!"],
						[cutscene_wait_for_dialogue],
						[cutscene_end]
					],
					// 1
					[
						[cutscene_change_variable,obj_cmenu,"flag","casg_flirt"],
						[cutscene_instance_destroy, obj_cmenu],
						[cutscene_run_code,function(){sfx_play(snd_phone,1,global.sfx_volume)}],
						[cutscene_dialogue, "gen", spr_blank, "* Ring..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_concern, "* ..."],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* Oh dear, do you truly# mean that...?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* And after you spoke of# calling me \"father\"?"],
						[cutscene_wait_for_dialogue],
						[cutscene_dialogue, "asg", spr_port_asg_nervous, "* You are indeed a... [delay,300]# \"puzzling\" child."],
						[cutscene_wait_for_dialogue],
						[cutscene_end]
					],
				]
			}
		},
		PLACEHOLDER:{
			NAME: "Test",
			CHOICES: [
				"Say Hello",
				"KYS"
			]
		}
	}
}