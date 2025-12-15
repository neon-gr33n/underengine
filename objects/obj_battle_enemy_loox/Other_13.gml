///@desc Turn Start

if bullying {
	switch(_bullied){
		case 1:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "I.. I know that...",id.x+40,id.y-120)	
		break
		case 2:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "Please stop...",id.x+40,id.y-120)	
		break
		case 3:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "*cries uncontrollably*",id.x+40,id.y-120)	
		break
	}
} else if encouraging {
	switch(_encouraged){
		case 1:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "Really?",id.x+40,id.y-120)	
		break
		case 2:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "Noone's said that before...",id.x+40,id.y-120)	
		break
		case 3:
			create_speech_bubble("wide horizontal", "fnt_dotumche", "Maybe you're right...",id.x+40,id.y-120)	
		break
	}
} else {
	create_speech_bubble("wide horizontal", "fnt_dotumche", "Don't pick on me!",id.x+40,id.y-120)	
}

if _bullied == 3 {
	instance_create(0,0,obj_bt_loox_teardrops);
} else {
	instance_create(0,0,obj_bt_randomhoming_circle);
}