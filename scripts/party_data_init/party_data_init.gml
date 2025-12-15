global.PARTY_INFO = {
	__PARTY__ : {
		NAME : "NULL",
		MEMBERS : ["FRISK"],
		MAXPARTYSIZE : 4,
		STATS : {
			KILLS : 0,
			GOLD : 0,
			DEATHS : 0,
			SPARES : 0
		},
		INVENTORY : ["BLUNT_AXE","CELL_PHONE"],
		MAXINVSIZE : 8,
		MAXSTORAGESIZE : 21,
		STORAGE : []
	},
		
		
	FRISK : {
		NAME : "Frisk",
		RACE:	"Human",
		SPRITES : {
			IDLE : spr_frisk_idle,
			MOVE : spr_frisk_move,
			RUN: spr_frisk_move,
		},
		STATS : {
			EXP : 0,
			LV : 1,
			HP : 20,
			MAX_HP : 20,
			ATK : 0,
			TEMP_ATK : 0,
			TEMP_DEF : 0,
			DEF : 0,
			WEAPON : "STICK",
			ARMOUR : "NO_ARMOUR",
		},
		DESCRIPTION : "It's you.",
	},
		
	PLACEHOLDER : {
		NAME : "PLACEHOLDER",
		RACE : "Monster",
		SPRITES : {
			IDLE : spr_PLACEHOLDER_idle,
			MOVE : spr_PLACEHOLDER_move,
			RUN: spr_PLACEHOLDER_move,
		},
		STATS : {
			EXP : 0,
			LV : 1,
			HP : 20,
			MAX_HP : 20,
			ATK : 0,
			TEMP_ATK : 0,
			TEMP_DEF : 0,
			DEF : 0,
			WEAPON : "NO_WEAPON",
			ARMOUR : "NO_ARMOUR",
		},
		DESCRIPTION : "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Maecenas non semper\nnulla.",
	}
};



/**
 * Gets a global party attribute.
 * @example
 * var members = party_get_attribute("MEMBERS");
 * var size = party_get_attribute("MAXPARTYSIZE");
 * @param {string} attribute - Attribute name
 * @returns {any} Attribute value
 */
function party_get_attribute(attribute) {
	return global.PARTY_INFO[$ "__PARTY__"][$ attribute];
}

/**
 * Sets a global party attribute.
 * @example
 * party_set_attribute("MAXPARTYSIZE", 4);
 * @param {string} attribute - Attribute name
 * @param {any} value - New value
 */
function party_set_attribute(attribute, value) {
	global.PARTY_INFO[$ "__PARTY__"][$ attribute] = value;
}

/**
 * Modifies a global party attribute by adding/subtracting.
 * @example
 * // Add 100 gold
 * party_change_attribute("GOLD", 100);
 * 
 * // Remove 50 gold
 * party_change_attribute("GOLD", -50);
 * @param {string} attribute - Attribute name
 * @param {number} value - Amount to change
 */
function party_change_attribute(attribute, value) {
	global.PARTY_INFO[$ "__PARTY__"][$ attribute] += value;
}

/**
 * Gets a global party stat.
 * @example
 * var partyHP = party_get_stat("COLLECTIVE_HP");
 * var experience = party_get_stat("EXP");
 * @param {string} stat - Stat name
 * @returns {number} Stat value
 */
function party_get_stat(stat) {
	return party_get_attribute("STATS")[$ stat];
}

/**
 * Sets a global party stat.
 * @example
 * party_set_stat("GOLD", 1000);
 * @param {string} stat - Stat name
 * @param {number} value - New stat value
 */
function party_set_stat(stat, value) {
	party_get_attribute("STATS")[$ stat] = value;
}

/**
 * Modifies a global party stat by adding/subtracting.
 * @example
 * // Gain 200 gold
 * party_change_stat("GOLD", 200);
 * @param {string} stat - Stat name
 * @param {number} value - Amount to change
 */
function party_change_stat(stat, value) {
	party_get_attribute("STATS")[$ stat] += value;
}