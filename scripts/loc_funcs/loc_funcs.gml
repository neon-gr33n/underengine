/// @category Localization
/// @title Localization Functions
/// @desc Functions for managing multi-language support, translations, fonts, and CSV-based localization.
 
/// @func init_language_config()
/// @desc Initializes the global LANGUAGE_CONFIG object with default languages and utility methods
/// @return {Object} The initialized LANGUAGE_CONFIG object
/// @example
/// init_language_config();
/// // LANGUAGE_CONFIG is now available globally
function init_language_config() {
    global.LANGUAGE_CONFIG = {
        languages: [
            { 
                id: 1, 
                name: "ENGLISH", 
                code: "ENG_US", 
                display_name: "English", 
                file_suffix: "EN",
                font_suffix: "",
                needs_special_font: false
            },
            { 
                id: 2, 
                name: "FRENCH", 
                code: "FRA_FR", 
                display_name: "Français", 
                file_suffix: "FR",
                font_suffix: "",
                needs_special_font: false
            },
            { 
                id: 3, 
                name: "JAPANESE", 
                code: "JPN_JP", 
                display_name: "日本語", 
                file_suffix: "JP",
                font_suffix: "_jp",
                needs_special_font: true
            }
        ],
        
        /// @desc Adds a new language to the configuration
        /// @param {Number} id Unique identifier for the new language
        /// @param {String} name Uppercase name (e.g., "SPANISH")
        /// @param {String} code Language code (e.g., "ESP_ES")
        /// @param {String} display_name Human-readable display name
        /// @param {String} file_suffix File suffix for language-specific resources
        /// @param {Bool} [needs_special_font=false] Whether language requires special fonts
        /// @example
        /// global.LANGUAGE_CONFIG.add_language(4, "SPANISH", "ESP_ES", "Español", "ES", false);
        add_language: function(id, name, code, display_name, file_suffix, needs_special_font = false) {
            array_push(global.LANGUAGE_CONFIG.languages, {
                id: id,
                name: name,
                code: code,
                display_name: display_name,
                file_suffix: file_suffix || string_upper(string_copy(name, 1, 2)),
                font_suffix: needs_special_font ? ("_" + (file_suffix || string_upper(string_copy(name, 1, 2))).toLowerCase()) : "",
                needs_special_font: needs_special_font
            });
        },
        
        /// @desc Retrieves language configuration by ID
        /// @param {Number} id Language ID to search for
        /// @return {Object} Language configuration object, or English fallback if not found
        get_by_id: function(id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            for(var i = 0; i < array_length(languages); i++) {
                if (languages[i].id == id) return languages[i];
            }
            return languages[0];
        },
        
        /// @desc Retrieves language configuration by name
        /// @param {String} name Language name to search for (e.g., "ENGLISH")
        /// @return {Object} Language configuration object, or English fallback if not found
        get_by_name: function(name) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            for(var i = 0; i < array_length(languages); i++) {
                if (languages[i].name == name) return languages[i];
            }
            return languages[0];
        },
        
        /// @desc Gets the next language in sequence (circular navigation)
        /// @param {Number} current_id Current language ID
        /// @return {Object} Next language configuration object
        get_next: function(current_id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            var current_index = global.LANGUAGE_CONFIG.get_index_by_id(current_id);
            var next_index = (current_index + 1) % array_length(languages);
            return languages[next_index];
        },
        
        /// @desc Gets the previous language in sequence (circular navigation)
        /// @param {Number} current_id Current language ID
        /// @return {Object} Previous language configuration object
        get_prev: function(current_id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            var current_index = global.LANGUAGE_CONFIG.get_index_by_id(current_id);
            var prev_index = current_index - 1;
            if (prev_index < 0) prev_index = array_length(languages) - 1;
            return languages[prev_index];
        },
        
        /// @desc Gets the array index of a language by ID
        /// @param {Number} id Language ID to find
        /// @return {Number} Array index, or 0 if not found
        get_index_by_id: function(id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return 0;
            }
            
            for(var i = 0; i < array_length(languages); i++) {
                if (languages[i].id == id) return i;
            }
            return 0;
        },
        
        /// @desc Gets current language information based on global.lang
        /// @return {Object} Current language configuration object
        get_current_info: function() {
            if (!variable_global_exists("lang") || global.lang == undefined) {
                global.lang = 1;
            }
            return global.LANGUAGE_CONFIG.get_by_id(global.lang);
        },
        
        /// @desc Gets array of all language names (for compatibility with old system)
        /// @return {Array} Array of language names
        get_all_names: function() {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return ["ENGLISH"];
            }
            
            var names = [];
            for(var i = 0; i < array_length(languages); i++) {
                array_push(names, languages[i].name);
            }
            return names;
        },
        
        /// @desc Gets the languages array directly (for compatibility)
        /// @return {Array} The languages array
        get_languages: function() {
            return global.LANGUAGE_CONFIG.languages;
        }
    };
    
    return global.LANGUAGE_CONFIG;
}

/// @func loc_update(new_lang, [dir])
/// @desc Updates the current language with navigation support
/// @param {Number} [new_lang] New language ID to set (optional if using navigation)
/// @param {Number} [dir=0] Navigation direction: 1 for next, -1 for previous, 0 for direct set
/// @return {Object} Current language information after update
/// @example
/// // Navigate to next language
/// loc_update(undefined, 1);
/// 
/// // Set specific language
/// loc_update(2, 0);
function loc_update(new_lang, dir = 0) {
    if (dir != 0) {
        if (dir > 0) {
            var next_lang = global.LANGUAGE_CONFIG.get_next(global.lang);
            new_lang = next_lang.id;
        } else {
            var prev_lang = global.LANGUAGE_CONFIG.get_prev(global.lang);
            new_lang = prev_lang.id;
        }
    }
    
    if (new_lang != undefined && new_lang != global.lang) {
        var old_grid = variable_global_exists("dialogue_grid") ? global.dialogue_grid : -1;
        global.lang = new_lang;
        loc_init();
        
        if (old_grid != -1 && ds_exists(old_grid, ds_type_grid)) {
            ds_grid_destroy(old_grid);
        }
        
        loc_reload_fonts();
        save_config();
    }
    
    return global.LANGUAGE_CONFIG.get_current_info();
}

/// @func loc_init()
/// @desc Initializes the localization system, loading CSV data and setting up language
function loc_init() {
    if (!variable_global_exists("lang") || global.lang == undefined || global.lang <= 0) {
        global.lang = 1;
    }
    
    if (variable_global_exists("dialogue_grid") && global.dialogue_grid != -1 && ds_exists(global.dialogue_grid, ds_type_grid)) {
        ds_grid_destroy(global.dialogue_grid);
    }
    
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    show_debug_message("=== LOC INIT ===");
    show_debug_message("Current language: " + current_lang.display_name + " (ID: " + string(global.lang) + ")");
    show_debug_message("File suffix: '" + current_lang.file_suffix + "'");
    
    var csv_filename = "dialogue.csv";
    var file_path = csv_filename;
    if (is_android()) {
        file_path = "assets/" + csv_filename;
    }
    
    show_debug_message("Loading CSV: " + file_path);
    
    if (!file_exists(file_path)) {
        show_debug_message("ERROR: CSV file not found: " + file_path);
        global.dialogue_grid = -1;
        global.dialogue_grid = ds_grid_create(1, 1);
        ds_grid_set(global.dialogue_grid, 0, 0, "ERROR: CSV not found");
    } else {
        global.dialogue_grid = load_csv(file_path);
        
        if (global.dialogue_grid == -1 || !ds_exists(global.dialogue_grid, ds_type_grid)) {
            show_debug_message("ERROR: Failed to load CSV into grid!");
            global.dialogue_grid = ds_grid_create(1, 1);
            ds_grid_set(global.dialogue_grid, 0, 0, "ERROR: Load failed");
        } else {
            var grid_width = ds_grid_width(global.dialogue_grid);
            var grid_height = ds_grid_height(global.dialogue_grid);
            show_debug_message("Successfully loaded CSV: " + string(grid_width) + "x" + string(grid_height));
            
            show_debug_message("Column headers:");
            for (var col = 0; col < min(5, grid_width); col++) {
                var header = string(global.dialogue_grid[# col, 0]);
                show_debug_message("  Col " + string(col) + ": '" + header + "'");
            }
        }
    }
    
    var _settings_path = is_android() ? "assets/settings.cfg" : "settings.cfg";
    
    if (file_exists(_settings_path)) {
        ini_open(_settings_path);
        global.LOC = current_lang.name;
        ini_write_string("LANGUAGE", "LOC", global.LOC);
        ini_write_real("LANGUAGE", "LANG_ID", global.lang);
        ini_close();
        show_debug_message("Language saved to settings: " + current_lang.display_name + " (" + current_lang.name + ")");
    } else {
        show_debug_message("Settings file not found: " + _settings_path);
        global.LOC = current_lang.name;
    }
    
    global.lang_array = global.LANGUAGE_CONFIG.get_all_names();
    show_debug_message("Available languages: " + string_join(", ", global.lang_array));
    
    loc_default_sprites();
    global.lang_loaded = global.lang;
    global.lang_initialized = true;
    
    show_debug_message("=== LOC INIT COMPLETE ===");
}
	
/// @func loc_setup()
/// @desc Sets up the language system on game start
/// @return {Bool} Always returns true
function loc_setup() {
    init_language_config();
    load_config();
    
    var _settings_path = is_android() ? "assets/settings.cfg" : "settings.cfg";
    var saved_lang_id = 1;
    var lang_exists = false;
    
    var languages = global.LANGUAGE_CONFIG.languages;
    for(var i = 0; i < array_length(languages); i++) {
        if (languages[i].id == saved_lang_id) {
            lang_exists = true;
            break;
        }
    }
    
    if (!lang_exists) {
        var lang_info = global.LANGUAGE_CONFIG.get_by_name(global.LOC);
        if (lang_info) {
            global.lang = lang_info.id;
        } else {
            global.lang = 1;
            global.LOC = "ENGLISH";
        }
    }
    
    if (file_exists(_settings_path)) {
        ini_open(_settings_path);
        saved_lang_id = ini_read_real("LANGUAGE", "LANG_ID", 1);
        var saved_lang_name = ini_read_string("LANGUAGE", "LOC", "ENGLISH");
        ini_close();
        
        lang_exists = false;
        languages = global.LANGUAGE_CONFIG.languages;
        
        for(var i = 0; i < array_length(languages); i++) {
            if (languages[i].id == saved_lang_id) {
                lang_exists = true;
                break;
            }
        }
        
        if (!lang_exists) {
            var lang_info = global.LANGUAGE_CONFIG.get_by_name(saved_lang_name);
            if (lang_info) {
                saved_lang_id = lang_info.id;
            }
        }
    }
    
    global.lang = saved_lang_id;
    loc_init();
    
    var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var sourceFont = loc_get_font("fnt_main_small");
    scribble_font_bake_outline_4dir(sourceFont, lang_info.needs_special_font ? "fnt_outline" + lang_info.font_suffix : "fnt_outline", c_black, false);
    return true;
}

/// @func loc_auto_detect_languages()
/// @desc Auto-detects available languages from the CSV file structure
/// @return {Bool} True if detection succeeded, false otherwise
function loc_auto_detect_languages() {
    if (!variable_global_exists("LANGUAGE_CONFIG") || global.LANGUAGE_CONFIG == undefined) {
        init_language_config();
    }
    
    var base_csv_path = is_android() ? "assets/dialogue.csv" : "dialogue.csv";
    
    if (!file_exists(base_csv_path)) {
        show_debug_message("Base CSV file not found for language detection: " + base_csv_path);
        return false;
    }
    
    var temp_grid = load_csv(base_csv_path);
    var grid_width = ds_grid_width(temp_grid);
    
    show_debug_message("=== AUTO-DETECTING LANGUAGES FROM CSV ===");
    show_debug_message("CSV has " + string(grid_width) + " columns");
    
    var languages = global.LANGUAGE_CONFIG.languages;
    
    for (var col = 2; col < grid_width; col++) {
        var header = string_trim(string(temp_grid[# col, 0]));
        
        if (string_pos("dialogue", string_lower(header)) > 0) {
            var language_code = "";
            var space_pos = string_pos(" ", header);
            
            if (space_pos > 0) {
                language_code = string_lower(string_copy(header, 1, space_pos - 1));
            } else {
                language_code = string_lower(string_copy(header, 1, 2));
            }
            
            show_debug_message("Found language column: '" + header + "' -> code: '" + language_code + "'");
            
            var lang_info = loc_identify_language_from_code(language_code);
            
            if (lang_info != undefined) {
                var exists = false;
                for (var i = 0; i < array_length(languages); i++) {
                    if (languages[i].name == lang_info.name || 
                        languages[i].code == lang_info.code ||
                        languages[i].file_suffix == string_upper(language_code)) {
                        exists = true;
                        break;
                    }
                }
                
                if (!exists) {
                    show_debug_message("Auto-adding new language: " + lang_info.display_name);
                    global.LANGUAGE_CONFIG.add_language(
                        array_length(languages) + 1,
                        lang_info.name,
                        lang_info.code,
                        lang_info.display_name,
                        lang_info.file_suffix,
                        lang_info.needs_special_font
                    );
                }
            }
        }
    }
    
    ds_grid_destroy(temp_grid);
    show_debug_message("=== LANGUAGE DETECTION COMPLETE ===");
    show_debug_message("Total languages: " + string(array_length(global.LANGUAGE_CONFIG.languages)));
    
    return true;
}

/// @func loc_identify_language_from_code(code)
/// @desc Identifies language configuration from a 2-letter language code
/// @param {String} code 2-letter language code (e.g., "en", "jp", "fr")
/// @return {Object|undefined} Language configuration object, or undefined if not found
function loc_identify_language_from_code(code) {
    code = string_lower(string_trim(code));
    
    switch (code) {
        case "en": return { 
            name: "ENGLISH", 
            code: "ENG_US", 
            display_name: "English", 
            file_suffix: "EN",
            font_suffix: "",
            needs_special_font: false
        };
        case "fr": return { 
            name: "FRENCH", 
            code: "FRA_FR", 
            display_name: "Français", 
            file_suffix: "FR",
            font_suffix: "",
            needs_special_font: false
        };
        case "jp": return { 
            name: "JAPANESE", 
            code: "JPN_JP", 
            display_name: "日本語", 
            file_suffix: "JP",
            font_suffix: "_jp",
            needs_special_font: true
        };
        case "de": return { 
            name: "GERMAN", 
            code: "GER_DE", 
            display_name: "Deutsch", 
            file_suffix: "DE",
            font_suffix: "",
            needs_special_font: false
        };
        case "es": return { 
            name: "SPANISH", 
            code: "ESP_ES", 
            display_name: "Español", 
            file_suffix: "ES",
            font_suffix: "",
            needs_special_font: false
        };
        case "it": return { 
            name: "ITALIAN", 
            code: "ITA_IT", 
            display_name: "Italiano", 
            file_suffix: "IT",
            font_suffix: "",
            needs_special_font: false
        };
        case "pt": return { 
            name: "PORTUGUESE", 
            code: "POR_PT", 
            display_name: "Português", 
            file_suffix: "PT",
            font_suffix: "",
            needs_special_font: false
        };
        case "ru": return { 
            name: "RUSSIAN", 
            code: "RUS_RU", 
            display_name: "Русский", 
            file_suffix: "RU",
            font_suffix: "",
            needs_special_font: false
        };
        case "zh": return { 
            name: "CHINESE", 
            code: "CHN_CN", 
            display_name: "中文", 
            file_suffix: "CN",
            font_suffix: "_cn",
            needs_special_font: true
        };
        case "ko": return { 
            name: "KOREAN", 
            code: "KOR_KR", 
            display_name: "한국어", 
            file_suffix: "KR",
            font_suffix: "_kr",
            needs_special_font: true
        };
        case "ar": return { 
            name: "ARABIC", 
            code: "ARA_AR", 
            display_name: "العربية", 
            file_suffix: "AR",
            font_suffix: "_ar",
            needs_special_font: true
        };
        case "hi": return { 
            name: "HINDI", 
            code: "HIN_IN", 
            display_name: "हिन्दी", 
            file_suffix: "HI",
            font_suffix: "",
            needs_special_font: false
        };
        case "nl": return { 
            name: "DUTCH", 
            code: "NLD_NL", 
            display_name: "Nederlands", 
            file_suffix: "NL",
            font_suffix: "",
            needs_special_font: false
        };
        case "pl": return { 
            name: "POLISH", 
            code: "POL_PL", 
            display_name: "Polski", 
            file_suffix: "PL",
            font_suffix: "",
            needs_special_font: false
        };
        case "tr": return { 
            name: "TURKISH", 
            code: "TUR_TR", 
            display_name: "Türkçe", 
            file_suffix: "TR",
            font_suffix: "",
            needs_special_font: false
        };
        case "sv": return { 
            name: "SWEDISH", 
            code: "SWE_SE", 
            display_name: "Svenska", 
            file_suffix: "SV",
            font_suffix: "",
            needs_special_font: false
        };
        case "da": return { 
            name: "DANISH", 
            code: "DAN_DK", 
            display_name: "Dansk", 
            file_suffix: "DA",
            font_suffix: "",
            needs_special_font: false
        };
        case "fi": return { 
            name: "FINNISH", 
            code: "FIN_FI", 
            display_name: "Suomi", 
            file_suffix: "FI",
            font_suffix: "",
            needs_special_font: false
        };
        case "no": return { 
            name: "NORWEGIAN", 
            code: "NOR_NO", 
            display_name: "Norsk", 
            file_suffix: "NO",
            font_suffix: "",
            needs_special_font: false
        };
        case "cs": return { 
            name: "CZECH", 
            code: "CES_CZ", 
            display_name: "Čeština", 
            file_suffix: "CS",
            font_suffix: "",
            needs_special_font: false
        };
        case "hu": return { 
            name: "HUNGARIAN", 
            code: "HUN_HU", 
            display_name: "Magyar", 
            file_suffix: "HU",
            font_suffix: "",
            needs_special_font: false
        };
        case "ro": return { 
            name: "ROMANIAN", 
            code: "RON_RO", 
            display_name: "Română", 
            file_suffix: "RO",
            font_suffix: "",
            needs_special_font: false
        };
        default:
            show_debug_message("Unknown language code: '" + code + "', creating generic entry");
            var needs_special_font = (code == "zh" || code == "ko" || code == "ar" || code == "jp");
            return {
                name: string_upper(code),
                code: string_upper(code) + "_" + string_upper(code),
                display_name: string_upper(code),
                file_suffix: string_upper(code),
                font_suffix: needs_special_font ? ("_" + code.toLowerCase()) : "",
                needs_special_font: needs_special_font
            };
    }
}

/// @func loc_next_language()
/// @desc Navigates to the next language in sequence
/// @return {Object} Current language information after navigation
function loc_next_language() {
    return loc_update(undefined, 1);
}

/// @func loc_prev_language()
/// @desc Navigates to the previous language in sequence
/// @return {Object} Current language information after navigation
function loc_prev_language() {
    return loc_update(undefined, -1);
}

/// @func loc_get_current_lang_name()
/// @desc Gets the current language name (compatibility function)
/// @return {String} Current language name (e.g., "ENGLISH")
function loc_get_current_lang_name() {
    return global.LANGUAGE_CONFIG.get_by_id(global.lang).name;
}

/// @func loc_get_current_display_name()
/// @desc Gets the current language display name (compatibility function)
/// @return {String} Current language display name (e.g., "English")
function loc_get_current_display_name() {
    return global.LANGUAGE_CONFIG.get_by_id(global.lang).display_name;
}

/// @func loc_gettext(key)
/// @desc Main translation function - retrieves localized text by key
/// @param {String} key Translation key to look up
/// @return {String} Localized text, or the key itself if not found
/// @example
/// var title = loc_gettext("ui.config.title");
/// // Returns "Configuration" if English, "Configuration" if French, etc.
function loc_gettext(key) {
    var search_key = string(key);
    
    if (!variable_global_exists("dialogue_grid") || global.dialogue_grid == -1) {
        return search_key;
    }
    
    if (!ds_exists(global.dialogue_grid, ds_type_grid)) {
        return search_key;
    }
    
    var grid_width = ds_grid_width(global.dialogue_grid);
    var grid_height = ds_grid_height(global.dialogue_grid);
    
    if (grid_width <= 0 || grid_height <= 0) {
        return search_key;
    }
    
    for (var row = 1; row < grid_height; row++) {
        var comment_val = string(global.dialogue_grid[# 0, row]);
        comment_val = string_trim(comment_val);
        
        if (comment_val == search_key) {
            var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
            var lang_column = -1;
            
            switch (current_lang.id) {
                case 1: lang_column = 1; break;
                case 2: lang_column = 2; break;
                case 3: lang_column = 3; break;
                default: lang_column = 1;
            }
            
            if (lang_column >= grid_width) {
                return search_key;
            }
            
            var translation = string(global.dialogue_grid[# lang_column, row]);
            translation = string_trim(translation);
            
            if (translation == "" || translation == "0") {
                if (grid_width > 1 && lang_column != 1) {
                    translation = string(global.dialogue_grid[# 1, row]);
                    translation = string_trim(translation);
                    
                    if (translation != "" && translation != "0") {
                        return translation;
                    }
                }
                return search_key;
            }
            
            return translation;
        }
    }
    
    return search_key;
}
	
/// @func loc_get_font(_font_index)
/// @desc Gets language-specific font based on current language
/// @param {Number|String} _font_index Font index or name
/// @return {Number|String} Language-specific font index or name
function loc_get_font(_font_index) {
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    if (current_lang.needs_special_font) {
        if (is_string(_font_index)) {
            return _font_index + current_lang.font_suffix;
        } else {
            var font_name = font_get_name(_font_index);
            var lang_font_name = font_name + current_lang.font_suffix;
            var lang_font_id = asset_get_index(lang_font_name);
            
            if (lang_font_id != -1) {
                return lang_font_id;
            } else {
                return _font_index;
            }
        }
    } else {
        return _font_index;
    }
}

/// @func loc_get_font_key(_font_string)
/// @desc Gets font key with language suffix for Scribble library
/// @param {String} _font_string Font string/name
/// @return {String} Font string with language suffix if needed
function loc_get_font_key(_font_string) {
    if (is_undefined(_font_string) || !is_string(_font_string)) {
        return _font_string;
    }
    
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    if (current_lang.needs_special_font) {
        return _font_string + current_lang.font_suffix;
    } else {
        return _font_string;
    }
}
	
/// @func loc_reload_fonts()
/// @desc Reloads all fonts for the current language
function loc_reload_fonts() {
    if variable_struct_exists(global, "fnt_main_sm") font_delete(global.fnt_main_sm);
    if variable_struct_exists(global, "fnt_main_md") font_delete(global.fnt_main_md);
    if variable_struct_exists(global, "fnt_main_lg") font_delete(global.fnt_main_lg);
    if variable_struct_exists(global, "fnt_sans") font_delete(global.fnt_sans);
    
    loc_default_font();
}

/// @func loc_update_language_only(new_lang)
/// @desc Updates language settings without breaking existing text lookups
/// @param {Number} new_lang New language ID to set
/// @return {Bool} Always returns true
function loc_update_language_only(new_lang) {
    show_debug_message("=== loc_update_language_only() called ===");
    
    if (new_lang == undefined) {
        show_debug_message("No language provided, skipping");
        return false;
    }
    
    var old_lang = global.lang;
    global.lang = new_lang;
    
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    global.LOC = current_lang.name;
    
    show_debug_message("Language set to: " + current_lang.display_name + " (ID: " + string(global.lang) + ")");
    show_debug_message("Calling loc_default_sprites()...");
    loc_default_sprites();
    
    if (old_lang != new_lang) {
        save_config();
        show_debug_message("Config saved (language changed from " + string(old_lang) + ")");
    } else {
        show_debug_message("Language unchanged, but sprites reloaded anyway");
    }
    
    show_debug_message("=== loc_update_language_only() complete ===");
    
    var sourceFont = loc_get_font("fnt_main_small");
    scribble_font_bake_outline_4dir(sourceFont, current_lang.needs_special_font == true ? "fnt_outline" + current_lang.font_suffix : "fnt_outline", c_black, false);
    
    return true;
}
	
/// @func loc_debug_csv_structure()
/// @desc Debug function to display CSV structure and translation mappings
function loc_debug_csv_structure() {
    show_debug_message("=== CSV STRUCTURE DEBUG ===");
    
    if (!variable_global_exists("dialogue_grid") || global.dialogue_grid == -1) {
        show_debug_message("dialogue_grid not loaded");
        return;
    }
    
    if (!ds_exists(global.dialogue_grid, ds_type_grid)) {
        show_debug_message("dialogue_grid doesn't exist as grid");
        return;
    }
    
    var grid_width = ds_grid_width(global.dialogue_grid);
    var grid_height = ds_grid_height(global.dialogue_grid);
    
    show_debug_message("Grid dimensions: " + string(grid_width) + " columns x " + string(grid_height) + " rows");
    
    show_debug_message("Column headers (row 0):");
    for (var col = 0; col < grid_width; col++) {
        var header = string(global.dialogue_grid[# col, 0]);
        show_debug_message("  Column " + string(col) + ": '" + header + "'");
    }
    
    show_debug_message("First 10 keys (COMMENT column):");
    for (var row = 1; row < min(11, grid_height); row++) {
        var key = string(global.dialogue_grid[# 0, row]);
        key = string_trim(key);
        if (key != "") {
            show_debug_message("  Row " + string(row) + ": '" + key + "'");
            
            for (var col = 2; col < min(5, grid_width); col++) {
                var translation = string(global.dialogue_grid[# col, row]);
                translation = string_trim(translation);
                var header = string(global.dialogue_grid[# col, 0]);
                show_debug_message("    " + header + ": '" + translation + "'");
            }
        }
    }
    
    var test_keys = ["ui.config.title", "ui.config.audio", "choice.back"];
    show_debug_message("Testing specific keys:");
    for (var i = 0; i < array_length(test_keys); i++) {
        var result = loc_gettext(test_keys[i]);
        show_debug_message("  '" + test_keys[i] + "' -> '" + result + "'");
    }
    
    show_debug_message("=== END CSV DEBUG ===");
}