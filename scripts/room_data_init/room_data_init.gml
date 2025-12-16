function room_data_init() {
	global.room_data={
		__ROOM__ : {
			"rm_init" : "INIT",
			"rm_introstory" : "INTRO",
			"rm_disclaimer" : "DISCLAIMER",
			"rm_gamebroke" : "DOGCHECK",
			"rm_menu" : "MENU",
			"rm_loadgame" : "LOAD_SAVE",
			"rm_settings" : "SETTINGS",
            "rm_credits" : "TITLE_CREDITS",
            "rm_endroll" : "END_ROLL",
			"rm_shop" : "SHOP",
			"rm_naming" : "NAMING",
			"rm_gameover" : "GAMEOVER",

			"rm_fallen" : "FALLEN",
			"rm_dialog_tester" : "DIALOG_TEST",		
			"rm_sandbox" : "SANDBOX",
			
			"rm_gj_login" : "GJ_LOGIN",
			"rm_gj_menu"  : "GJ_MENU"
		
		},
		AREAS : {
			__ENGINE__ : {
				NAME : "Menu",
			},
			__VOID__ : {
				NAME : "Void"
			},
			__DEBUG__ : {
				NAME : "Debug"
			},
			__GAMEJOLT_API__: {
				NAME : "Gamejolt API"
			},
			RUINS: {
				NAME: "Ruins"	
			}
		},
		ROOMS : {
			INIT : {
				NAME : "Starting Up...",
				AREA : "__ENGINE__",
				THEME : noone,
			},
			DISCLAIMER : {
				NAME : "Starting Up...",
				AREA : "__ENGINE__",
				THEME : noone,
			},
			INTRO : {
				NAME : "Listening to their tale",
				AREA : "__ENGINE__",
				THEME : noone,
			},
			DOGCHECK : {
				NAME : "Dogcheck",
				AREA : "__HELL__",
				THEME : "smile",
			},
			SHOP: {
				NAME: "Shop",
				AREA: "__ENGINE__",
				THEME: "shop"			
			},
			MENU : {
				NAME : "Main Menu",
				AREA : "__ENGINE__",
				THEME : "menu0",
			},
			LOAD_SAVE : {
				NAME : "Load",
				AREA : "__ENGINE__",
				THEME : noone,
			},
			INSTRUCTIONS : {
				NAME : "Instructions",
				AREA : "__ENGINE__",
				THEME : "menu0",
			},
			SETTINGS : {
				NAME : "Configuring settings...",
				AREA : "__ENGINE__",
				THEME : "menu0",
			},
            TITLE_CREDITS : {
                NAME : "Viewing credits...",
                AREA : "__ENGINE__",
                THEME: noone,
            },
            END_ROLL : {
                NAME : "Thanks for playing!",
                AREA : "__ENGINE__",
                THEME : noone
            },
			NAMING : {
				NAME : "Naming",
				AREA : "__ENGINE__",
				THEME : noone,
			},
			GAMEOVER : {
				NAME : "Dead",
				AREA : "__VOID__",
				THEME : noone,
			},
			FALLEN : {
				NAME : "Starter Room",
				AREA : "RUINS",
				THEME : noone,
			},
			
			DIALOG_TEST : {
				NAME : "Dialogue Tester",
				AREA : "__DEBUG__",
				THEME : noone,
			},
			SOUL_TEST : {
				NAME : "Soul Tester",
				AREA : "__DEBUG__",
				THEME : noone,
			},
			
			GJ_LOGIN : {
				NAME : "Gamejolt Login",
				AREA : "__GAMEJOLT_API__",
				THEME : noone,
			},
			GJ_MENU : {
				NAME: "Gamejolt Menu",
				AREA : "__GAMEJOLT_API__",
				THEME : noone,	
			}
		}
	}
	show_debug_message("Room data init was called successfully!")
}