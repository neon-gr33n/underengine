function equipment_data_init() {
	
	
	global.EQUIPMENT = {
		CATEGORY : [
			"CONSUMABLE",
			"WEAPON",
			"ARMOUR",
			"KEY"
		],
		
		__EQUIPMENT__ : {
			TEST_DOG1 : "CONSUMABLE",
			TEST_DOG2 : "CONSUMABLE",
			TEST_CAT1 : "CONSUMABLE",
			
			NO_WEAPON : "WEAPON",
			STICK : "WEAPON",
			
			NO_ARMOUR : "ARMOUR",
			FADED_RIBBON : "ARMOUR",
			
			CELL_PHONE : "KEY",
		},
		
		CONSUMABLE : {
			TEST_DOG1 : {
				NAME : "Test-Dog 1",
				SHORT_NAME : "Tested1",
				SERIOUS_NAME : "Test-D-1",
				SELL_VALUE: 0,
				SOUND : snd_heal,
				EFFECTS : {
					HP : 10,
					MAX_HP : 0,
					MP : 2,
					MAX_MP : 0,
					EMOTION : noone,
					TEMP_ATK : 0,
					TEMP_DEF : 0,
					ATK : 0,
					DEF : 0,
				},
				TEAM_EFFECTS : {
					HP : 0,
					MAX_HP : 0,
					MP : 0,
					MAX_MP : 0,
					EMOTION : noone,
					TEMP_ATK : 0,
					TEMP_DEF : 0,
					ATK : 0,
					DEF : 0,
				},
				SPECIAL_EFFECTS : function(){},
				DESCRIPTION : "* Testing 1 2 3.",
			},
		},
		
		WEAPON : {
			NO_WEAPON : {
				NAME : "None",
				SHORT_NAME : "None",
				SERIOUS_NAME : "None",
				ATK : 0,
				CHARAS_ALLOWED : ["ALL"],
				DESCRIPTION : " ",
				ABILITIES : [],
			},
			STICK : {
				NAME : "Stick",
				SHORT_NAME : "Stick",
				SERIOUS_NAME : "Stick",
				ATK : 0,
				SELL_VALUE: 22,
				CRIT_MULT : 2.2,
				CHARAS_ALLOWED : ["FRISK"],
				DESCRIPTION : "* It's bark is worse#than its bite.",
				BARS : {
					INFO : [
						{
							SIDE : "RAND",
							SOUND : snd_slice,
							CRIT_SOUND : snd_hurtcritical,
							SPEED : 6,
							DELAY : 0,
						},
					],
				},
				ABILITIES : [],
			},
		},
		
		ARMOUR : {
			NO_ARMOUR : {
				NAME : "None",
				SHORT_NAME : "None",
				SERIOUS_NAME : "None",
				DEF : 0,
				CHARAS_ALLOWED : ["ALL"],
				DESCRIPTION : " ",
				ABILITIES : [],
			},
			FADED_RIBBON : {
				NAME : "Faded Ribbon",
				SHORT_NAME : "Ribbon",
				SERIOUS_NAME : "F.Ribbon",
				DEF : 3,
				SELL_VALUE: 15,
				CHARAS_ALLOWED : ["FRISK"],
				DESCRIPTION : "* If you're cuter#\tmonsters won't hit you#\tas hard.",
				ABILITIES : [],
			}
		},
		
		KEY: {
			CELL_PHONE: {
				NAME: "Cell Phone",
				SHORT_NAME: "C. Phone",
				SERIOUS_NAME: "Phone",
				SOUND: snd_silent,
				SPECIAL_EFFECTS: function() {
					with(obj_cmenu) {
						if instance_exists(__info) { instance_destroy(__info) }
						if instance_exists(__invmain) { instance_destroy(__invmain) }
						if instance_exists(__invarm) { instance_destroy(__invarm) }
						if instance_exists(__invkey) { instance_destroy(__invkey) }
						if instance_exists(__invwep) { instance_destroy(__invwep) }
						_menu_selection = 2;
						state = stateMenuCell();
						_menu_active =  3;
					}
				},
				DESCRIPTION: "An ancient cell phone# there's little claw# marks on the screen.",
			}
			
		}
	}
}

function index_to_category(index) {
	return global.EQUIPMENT[$ "CATEGORY"][@ index];
}

function item_get_category(item_key) {
	return global.EQUIPMENT[$ "__EQUIPMENT__"][$ item_key];
}

function item_get_struct(item_key) {
	return global.EQUIPMENT[$ item_get_category(item_key)][$ item_key];
}

function item_get_attribute(item_key, attribute) {
	return item_get_struct(item_key)[$ attribute];
}

function item_get_use_text(item) {
	if struct_exists(item_get_struct(item), "USE_TEXT")
		return item_get_attribute(item, "USE_TEXT");
	else
		switch (item_get_category(item)) {
			case "WEAPON":
			case "ARMOUR":
				return loc_gettext("item.use.equip") + " " +  item_get_attribute(item, "NAME");
			case "CONSUMABLE":
				return loc_gettext("item.use.eat") + " " +  item_get_attribute(item, "NAME");
		}
}