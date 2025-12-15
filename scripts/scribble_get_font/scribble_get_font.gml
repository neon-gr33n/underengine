function scribble_get_font(font_key) {
    // Simply append "_jp" to the font name if we're in Japanese mode
    if (global.lang == LANGUAGES.JPN_JP) {
        return font_key + "_jp";
    } else {
        return font_key;
    }
}

function test_scribble_font_loading(){
		// Test the font system
	show_debug_message("=== FONT SYSTEM TEST ===");
	show_debug_message("global.lang: " + string(global.lang));
	show_debug_message("global.LOC: " + string(global.LOC));
	show_debug_message("global.fnt_main_sm: " + string(global.fnt_main_sm));
	show_debug_message("Font name: " + font_get_fontname(global.fnt_main_sm));

	var test_font = scribble_get_font("fnt_main");
	show_debug_message("Final font for Scribble: " + test_font);	
}