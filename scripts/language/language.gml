////@desc Initializes a list of default sprites for the localization system
function loc_default_sprites() 
{
	global.lang_spr_fight_bt=spr_battle_bt_fight;
	global.lang_spr_act_bt=spr_battle_bt_act;
	global.lang_spr_item_bt=spr_battle_bt_item;
	global.lang_spr_mercy_bt=spr_battle_bt_mercy;
	global.lang_spr_miss_bt=spr_battle_text_miss;
//	global.lang_spr_intro_panels=spr_intro;
}

///@desc Initializes the localization system, loading any external localization files made by the user in addition to "core" ones
function loc_init() {
		global.lang_array=["eng"]
		#region DEFINE LANG FONTS
		global.lang_font_main=fnt_main;
		global.lang_font_main_sm=fnt_main_small;
		global.lang_font_battle=fnt_dotumche;
	//	global.lang_font_name=fnt_special;
		global.lang_font_mars=fnt_mars;
		global.lang_font_crypt=fnt_crypt;
		global.lang_fonts=[global.lang_font_main,global.lang_font_main_sm,global.lang_font_battle,global.lang_font_mars,global.lang_font_crypt];
//		global.lang_font_sans=fnt_sans;
		#endregion
		var f = file_find_first("*.json", 0);
		var i = 4;
		while f!=""
		{
			global.lang_array[i++] = filename_name(f);
			f = file_find_next()
		}
		file_find_close()

	global.lang_external = 0;
	switch(global.lang){
		default:
			global.lang_external = global.lang != "en"
			if(global.lang_external) {
				font_add_enable_aa(false);
				for (i=0; i <11; i++){
					fname = file_find_first((("data/font" + string(i)) + "_*.ttf"),0)
					if fname != ""
					{
						fname = ("data/" + fname)
						var aa = string_pos("antialias", fname) != 0
						if aa 
							font_add_enable_aa(1)
						var sizePos = (string_last_pos("_", fname) + 1)
						var endSizePos = string_last_pos(".ttf", fname)
						var size = real(string_copy(fname, sizePos, (endSizePos - sizePos)))
						if aa	
							font_add_enable_aa(0)
					}
				}
			}
			global.lang_id = 0;							// Current language ID
			global.lang_charwidth_sms = 8;  // Smallest
			global.lang_charwidth_sm = 9;   // Smallest
			global.lang_charwidth_mds = 14;   // Medium small
			global.lang_charwidth_md = 16; // Medium
			global.lang_charwidth_mdl = 18; // Medium large
			global.lang_charwidth_lg = 21; // Large
			global.lang_charwidth_lg2 = 22; // Large 2 
			global.lang_charwidth_lgll = 27;  // Larger + Larger
			global.lang_charheight_md = 18; // Medium height
			global.lang_charheight_lgs = 32; // 2nd Largest height
			global.lang_charheight_lg = 36;  //  Largest height
			global.lang_asterisk = "*" // The character to use as a prefix for the current language
			global.lang_punctuation = [".", ",", "!", "?", ":", ";"]  // Punctions to use for the current language
			global.lang_period = "."
			loc_default_sprites()
		break;
		global.lang_loaded=global.lang;
		global.lang_initialized=true;
		return;
	}
}

///@desc Fetches a string from a defined key per your current language
function loc_gettext(key){
		var loc, get_file, locf, loc_key, locd, tempm, lmap, string_res;
		loc = global.lang;  // Get the current language
		loc_key=key;	// Fetch the value of argument0 and assign it to this variable for later use
		get_file= loc+".json"; // Fetch the localization file from the root of the working directory
		if(file_exists(get_file)){
			locf=file_text_open_read(get_file);
			locd = "";
			while(!file_text_eof(locf)){
				locd += file_text_read_string(locf);
				file_text_readln(locf);
			}
			file_text_close(locf);
			tempm = json_decode(locd);
			lmap = ds_map_find_value(tempm, loc);
			if(!is_string(loc_key)){
				loc_key=string(loc_key)	
			}
			string_res = ds_map_find_value(lmap, loc_key);   // Search for a valid key in our localization file and temporary DS_Map
			ds_map_destroy(tempm);
			ds_map_destroy(lmap);
			return string_res;   // If succesful, display the key using the resulting string
		} else {
			return "FAILED TO LOAD KEY.";	
		}
}

///@desc Fetches a localized variant of the current font 
///@arg font_index
function set_font(font){
	 if (global.lang_id == 0 && global.lang_external)
    {
        switch font
        {
            case fnt_main:
                if (global.lang_fonts[0] != -4)
                    font = global.lang_fonts[0]
                break
            case fnt_main_small:
                if (global.lang_fonts[1] != -4)
                    font = global.lang_fonts[1]
                break
            case fnt_crypt:
                if (global.lang_fonts[4] != -4)
                    font = global.lang_fonts[4]
                break
            case fnt_mars:
                if (global.lang_fonts[5] != -4)
                    font = global.lang_fonts[5]
                break
            case fnt_dotumche:
                if (global.lang_fonts[6] != -4)
                    font = global.lang_fonts[6]
                break
        }
    }
	global.font = font;
}