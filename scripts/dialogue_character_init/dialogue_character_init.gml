/**
 * Initializes the global character database for dialogue system.
 * 
 * @example
 * // Call this once at game start
 * dialogue_character_init();
 * 
 * @example
 * // To add a new character:
 * // 1. Add an entry below with character ID
 * // 2. Include font, voice, name, and type
 * // 3. Add portraits if character has multiple expressions
 * 
 * @description
 * This function sets up the global.characters object which stores
 * all character data. To modify:
 * - Add new character objects with unique IDs
 * - Set font, voice, name, and type properties
 * - Add portrait variants for expressions
 */
function dialogue_character_init() {
	global.characters = {
		generic : {
			font: loc_get_font("fnt_main_small"),
			voice: snd_soft_v,
			type: SPEAKER_TYPE.REGULAR
		},
		generic2 : {
			font: loc_get_font("fnt_main_small"),
			voice: snd_writer_v,
			type: SPEAKER_TYPE.REGULAR
		},
		asg : {
			font: loc_get_font("fnt_main"),
			voice: snd_asg_v,
			char_name: loc_gettext("game.char.asgore"),
			type: SPEAKER_TYPE.REGULAR
		},
		sans : {
			font: loc_get_font("fnt_sans"),
			voice: snd_sans_v,
			char_name: "sans.",
			type: SPEAKER_TYPE.REGULAR
		},
        paps: {
            font: loc_get_font("fnt_papyrus"),
            voice: snd_paps_v,
            char_name: "Papyrus",
            type: SPEAKER_TYPE.REGULAR
        },
		shopkeep_1: {
			font: loc_get_font("fnt_main_bt"),
			font_scale: 1,
			voice: snd_soft_v,
			char_name: "Shopkeeper",
			type: SPEAKER_TYPE.SHOP,
			portraits: {
				neutral: spr_shop_host_test,
				evil: spr_shop_host_evil
			}
		}
	}
}