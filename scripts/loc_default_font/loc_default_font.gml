function loc_default_font(){
   // DEBUG: Check what language we're using
    show_debug_message("=== loc_default_font DEBUG ===");
    show_debug_message("global.lang: " + string(global.lang));
    show_debug_message("global.LOC: " + string(global.LOC));
    
    // Determine which language to use for fonts
    var current_lang = (global.lang == LANGUAGES.JPN_JP) ? "JAPANESE" : "ENGLISH";
    show_debug_message("Using font language: " + current_lang);
	
	global.LOC_FONT = {
		__MAIN_SMALL__: {
			ENGLISH: {
				__FONT_DATA__: {
					PATH: "./data/font/english/8bitoperator_jve.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 12,
					START_CHAR: 32,
					END_CHAR: 255
				}
			},
			JAPANESE: {
				__FONT_DATA__: {
					PATH: "./data/font/japanese/JF-Dot-Shinonome14.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 10,
					START_CHAR: 32,
					END_CHAR: 127
				}
			}
		},
		__MAIN_MEDIUM__: {
			ENGLISH: {
				__FONT_DATA__: {
					PATH: "./data/font/english/8bitoperator_jve.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 14,
					START_CHAR: 32,
					END_CHAR: 127
				}
			},
			JAPANESE: {
				__FONT_DATA__: {
					PATH: "./data/font/japanese/JF-Dot-Shinonome14.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 14,
					START_CHAR: 32,
					END_CHAR: 127
				}
			}
		},
		__MAIN_LARGE__: {
			ENGLISH: {
				__FONT_DATA__: {
					PATH: "./data/font/english/8bitoperator_jve.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 22,
					START_CHAR: 32,
					END_CHAR: 127
				}
			},
			JAPANESE: {
				__FONT_DATA__: {
					PATH: "./data/font/japanese/JF-Dot-Shinonome14.ttf",
					BOLD: false,
					ITALIC: false,
					SIZE: 19,
					START_CHAR: 32,
					END_CHAR: 127
				}
			}
		},
		__SANS__: {
			ENGLISH: {
				__FONT_DATA__: {
					PATH: "./data/font/english/PIXEL-COMIC-SANS-UNDERTALE-SANS-FONT1.TTF",
					BOLD: false,
					ITALIC: false,
					SIZE: 11,
					START_CHAR: 32,
					END_CHAR: 127
				}
			},
			JAPANESE: {
				__FONT_DATA__: {
					PATH: "./data/font/japanese/HappyRuikaSeikyo-08.TTF",
					BOLD: false,
					ITALIC: false,
					SIZE: 11,
					START_CHAR: 32,
					END_CHAR: 127
				}
			}
		}
	}
	
	font_add_enable_aa(false);
	
	// Use the current language to load fonts
	global.fnt_main_sm = font_add(
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "PATH"],
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "SIZE"],
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "BOLD"],
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "ITALIC"],
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "START_CHAR"],
		global.LOC_FONT[$ "__MAIN_SMALL__"][$ current_lang][$ "__FONT_DATA__"][$ "END_CHAR"]			
	);
	
	global.fnt_main_md = font_add(
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "PATH"],
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "SIZE"],
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "BOLD"],
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "ITALIC"],
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "START_CHAR"],
		global.LOC_FONT[$ "__MAIN_MEDIUM__"][$ current_lang][$ "__FONT_DATA__"][$ "END_CHAR"]			
	);		
	
	global.fnt_main_lg = font_add(
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "PATH"],
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "SIZE"],
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "BOLD"],
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "ITALIC"],
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "START_CHAR"],
		global.LOC_FONT[$ "__MAIN_LARGE__"][$ current_lang][$ "__FONT_DATA__"][$ "END_CHAR"]			
	);		
	
	global.fnt_sans = font_add(
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "PATH"],
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "SIZE"],
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "BOLD"],
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "ITALIC"],
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "START_CHAR"],
		global.LOC_FONT[$ "__SANS__"][$ current_lang][$ "__FONT_DATA__"][$ "END_CHAR"]			
	);		
}