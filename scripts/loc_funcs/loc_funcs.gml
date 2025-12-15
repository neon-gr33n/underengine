/**
 * @namespace LANGUAGE_CONFIG
 * @description Global language configuration object that manages language settings,
 * translations, and font handling for the application.
 */

/**
 * Initializes the global LANGUAGE_CONFIG object with default languages and utility methods.
 * @function init_language_config
 * @returns {Object} The initialized LANGUAGE_CONFIG object
 * @example
 * init_language_config();
 * // LANGUAGE_CONFIG is now available globally
 */
function init_language_config() {
    global.LANGUAGE_CONFIG = {
        /**
         * @member {Array} languages - Array of language configuration objects
         * @property {number} id - Unique identifier for the language
         * @property {string} name - Uppercase name (e.g., "ENGLISH", "JAPANESE")
         * @property {string} code - Language code (e.g., "ENG_US", "JPN_JP")
         * @property {string} display_name - Human-readable display name
         * @property {string} file_suffix - File suffix for language-specific resources
         * @property {string} font_suffix - Font suffix for special font requirements
         * @property {boolean} needs_special_font - Whether language requires special fonts
         */
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
        
        /**
         * Adds a new language to the configuration
         * @method add_language
         * @memberof LANGUAGE_CONFIG
         * @param {number} id - Unique identifier for the new language
         * @param {string} name - Uppercase name (e.g., "SPANISH")
         * @param {string} code - Language code (e.g., "ESP_ES")
         * @param {string} display_name - Human-readable display name
         * @param {string} file_suffix - File suffix for language-specific resources
         * @param {boolean} [needs_special_font=false] - Whether language requires special fonts
         * @example
         * global.LANGUAGE_CONFIG.add_language(4, "SPANISH", "ESP_ES", "Español", "ES", false);
         */
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
        
        /**
         * Retrieves language configuration by ID
         * @method get_by_id
         * @memberof LANGUAGE_CONFIG
         * @param {number} id - Language ID to search for
         * @returns {Object} Language configuration object, or English fallback if not found
         */
        get_by_id: function(id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                // Emergency fallback
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            for(var i = 0; i < array_length(languages); i++) {
                if (languages[i].id == id) return languages[i];
            }
            return languages[0]; // Default to first
        },
        
        /**
         * Retrieves language configuration by name
         * @method get_by_name
         * @memberof LANGUAGE_CONFIG
         * @param {string} name - Language name to search for (e.g., "ENGLISH")
         * @returns {Object} Language configuration object, or English fallback if not found
         */
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
        
        /**
         * Gets the next language in sequence (circular navigation)
         * @method get_next
         * @memberof LANGUAGE_CONFIG
         * @param {number} current_id - Current language ID
         * @returns {Object} Next language configuration object
         */
        get_next: function(current_id) {
            var languages = global.LANGUAGE_CONFIG.languages;
            
            if (array_length(languages) == 0) {
                return { id: 1, name: "ENGLISH", code: "ENG_US", display_name: "English", file_suffix: "EN" };
            }
            
            var current_index = global.LANGUAGE_CONFIG.get_index_by_id(current_id);
            var next_index = (current_index + 1) % array_length(languages);
            return languages[next_index];
        },
        
        /**
         * Gets the previous language in sequence (circular navigation)
         * @method get_prev
         * @memberof LANGUAGE_CONFIG
         * @param {number} current_id - Current language ID
         * @returns {Object} Previous language configuration object
         */
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
        
        /**
         * Gets the array index of a language by ID
         * @method get_index_by_id
         * @memberof LANGUAGE_CONFIG
         * @param {number} id - Language ID to find
         * @returns {number} Array index, or 0 if not found
         */
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
        
        /**
         * Gets current language information based on global.lang
         * @method get_current_info
         * @memberof LANGUAGE_CONFIG
         * @returns {Object} Current language configuration object
         */
        get_current_info: function() {
            if (!variable_global_exists("lang") || global.lang == undefined) {
                global.lang = 1;
            }
            return global.LANGUAGE_CONFIG.get_by_id(global.lang);
        },
        
        /**
         * Gets array of all language names (for compatibility with old system)
         * @method get_all_names
         * @memberof LANGUAGE_CONFIG
         * @returns {string[]} Array of language names
         */
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
        
        /**
         * Gets the languages array directly (for compatibility)
         * @method get_languages
         * @memberof LANGUAGE_CONFIG
         * @returns {Array} The languages array
         */
        get_languages: function() {
            return global.LANGUAGE_CONFIG.languages;
        }
    };
    
    return global.LANGUAGE_CONFIG;
}

/**
 * Updates the current language with navigation support
 * @function loc_update
 * @param {number} [new_lang] - New language ID to set (optional if using navigation)
 * @param {number} [dir=0] - Navigation direction: 1 for next, -1 for previous, 0 for direct set
 * @returns {Object} Current language information after update
 * @example
 * // Navigate to next language
 * loc_update(undefined, 1);
 * 
 * // Set specific language
 * loc_update(2, 0);
 */
function loc_update(new_lang, dir = 0) {
    if (dir != 0) {
        if (dir > 0) {
            // Navigate right
            var next_lang = global.LANGUAGE_CONFIG.get_next(global.lang);
            new_lang = next_lang.id;
        } else {
            // Navigate left
            var prev_lang = global.LANGUAGE_CONFIG.get_prev(global.lang);
            new_lang = prev_lang.id;
        }
    }
    
    // If specific language ID is provided
    if (new_lang != undefined && new_lang != global.lang) {
        // Store old grid temporarily
        var old_grid = variable_global_exists("dialogue_grid") ? global.dialogue_grid : -1;
        
        // Set the new language
        global.lang = new_lang;
        
        // Reinitialize with new language
        loc_init();
        
        // Clean up old grid if it exists
        if (old_grid != -1 && ds_exists(old_grid, ds_type_grid)) {
            ds_grid_destroy(old_grid);
        }
        
        // Reload fonts for the new language
        loc_reload_fonts();
        
        save_config();
    }
    
    // Return current language info for UI updates
    return global.LANGUAGE_CONFIG.get_current_info();
}

/**
 * Initializes the localization system, loading CSV data and setting up language
 * @function loc_init
 */
function loc_init() {
    // First, ensure global.lang exists
    if (!variable_global_exists("lang") || global.lang == undefined || global.lang <= 0) {
        global.lang = 1; // Default to English
    }
    
    // Clean up old grid if it exists
    if (variable_global_exists("dialogue_grid") && global.dialogue_grid != -1 && ds_exists(global.dialogue_grid, ds_type_grid)) {
        ds_grid_destroy(global.dialogue_grid);
    }
    
    // Get current language info
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    // DEBUG: Show what language we're trying to load
    show_debug_message("=== LOC INIT ===");
    show_debug_message("Current language: " + current_lang.display_name + " (ID: " + string(global.lang) + ")");
    show_debug_message("File suffix: '" + current_lang.file_suffix + "'");
    
    // Load the base CSV file (ALL languages in one file)
    var csv_filename = "dialogue.csv";
    var file_path = csv_filename;
    if (is_android()) {
        file_path = "assets/" + csv_filename;
    }
    
    show_debug_message("Loading CSV: " + file_path);
    
    if (!file_exists(file_path)) {
        show_debug_message("ERROR: CSV file not found: " + file_path);
        global.dialogue_grid = -1;
        
        // Create an empty grid as fallback
        global.dialogue_grid = ds_grid_create(1, 1);
        ds_grid_set(global.dialogue_grid, 0, 0, "ERROR: CSV not found");
    } else {
        global.dialogue_grid = load_csv(file_path);
        
        // Check if load_csv succeeded
        if (global.dialogue_grid == -1 || !ds_exists(global.dialogue_grid, ds_type_grid)) {
            show_debug_message("ERROR: Failed to load CSV into grid!");
            global.dialogue_grid = ds_grid_create(1, 1);
            ds_grid_set(global.dialogue_grid, 0, 0, "ERROR: Load failed");
        } else {
            var grid_width = ds_grid_width(global.dialogue_grid);
            var grid_height = ds_grid_height(global.dialogue_grid);
            show_debug_message("Successfully loaded CSV: " + string(grid_width) + "x" + string(grid_height));
            
            // Debug: Show column headers
            show_debug_message("Column headers:");
            for (var col = 0; col < min(5, grid_width); col++) {
                var header = string(global.dialogue_grid[# col, 0]);
                show_debug_message("  Col " + string(col) + ": '" + header + "'");
            }
        }
    }
    
    // Load settings
    var _settings_path = is_android() ? "assets/settings.cfg" : "settings.cfg";
    
    if (file_exists(_settings_path)) {
        ini_open(_settings_path);
        // Store language name for compatibility
        global.LOC = current_lang.name;
        // Save current setting
        ini_write_string("LANGUAGE", "LOC", global.LOC);
        // Also save the language ID for easier loading
        ini_write_real("LANGUAGE", "LANG_ID", global.lang);
        ini_close();
        show_debug_message("Language saved to settings: " + current_lang.display_name + " (" + current_lang.name + ")");
    } else {
        show_debug_message("Settings file not found: " + _settings_path);
        global.LOC = current_lang.name;
    }
    
    // Update lang_array from LANGUAGE_CONFIG
    global.lang_array = global.LANGUAGE_CONFIG.get_all_names();
    show_debug_message("Available languages: " + string_join(", ", global.lang_array));
    
    loc_default_sprites();
    global.lang_loaded = global.lang;
    global.lang_initialized = true;
    
    show_debug_message("=== LOC INIT COMPLETE ===");
}
	
/**
 * Sets up the language system on game start
 * @function loc_setup
 * @returns {boolean} Always returns true
 */
function loc_setup() {
    // Initialize LANGUAGE_CONFIG first
    init_language_config();
	
	load_config();
    
    // Load saved language setting
    var _settings_path = is_android() ? "assets/settings.cfg" : "settings.cfg";
    var saved_lang_id = 1; // Default to English
	
	var lang_exists = false;
    
    // Check if the saved language ID exists in our config
    var languages = global.LANGUAGE_CONFIG.languages;
    for(var i = 0; i < array_length(languages); i++) {
        if (languages[i].id == saved_lang_id) {
            lang_exists = true;
            break;
        }
    }
    
    if (!lang_exists) {
        // Try to find by name
        var lang_info = global.LANGUAGE_CONFIG.get_by_name(global.LOC);
        if (lang_info) {
            global.lang = lang_info.id;
        } else {
            // Default to English if language not found
            global.lang = 1;
            global.LOC = "ENGLISH";
        }
    }
    
    if (file_exists(_settings_path)) {
        ini_open(_settings_path);
        saved_lang_id = ini_read_real("LANGUAGE", "LANG_ID", 1);
        var saved_lang_name = ini_read_string("LANGUAGE", "LOC", "ENGLISH");
        ini_close();
        
        // Validate that the saved language exists
        var lang_exists = false;
        var languages = global.LANGUAGE_CONFIG.languages;
        
        for(var i = 0; i < array_length(languages); i++) {
            if (languages[i].id == saved_lang_id) {
                lang_exists = true;
                break;
            }
        }
        
        if (!lang_exists) {
            // Try to find by name
            var lang_info = global.LANGUAGE_CONFIG.get_by_name(saved_lang_name);
            if (lang_info) {
                saved_lang_id = lang_info.id;
            }
        }
    }
    
    // Set language
    global.lang = saved_lang_id;
    
    // Initialize language system
    loc_init();
	
	 var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang)
	// Bake outlined fonts
	var sourceFont = loc_get_font("fnt_main_small")
	scribble_font_bake_outline_4dir(sourceFont,lang_info.needs_special_font ? "fnt_outline" + lang_info.font_suffix : "fnt_outline",c_black,false)
    return true;
}

/**
 * Auto-detects available languages from the CSV file structure
 * @function loc_auto_detect_languages
 * @returns {boolean} True if detection succeeded, false otherwise
 */
function loc_auto_detect_languages() {
    // Ensure LANGUAGE_CONFIG exists
    if (!variable_global_exists("LANGUAGE_CONFIG") || global.LANGUAGE_CONFIG == undefined) {
        init_language_config();
    }
    
    var base_csv_path = is_android() ? "assets/dialogue.csv" : "dialogue.csv";
    
    if (!file_exists(base_csv_path)) {
        show_debug_message("Base CSV file not found for language detection: " + base_csv_path);
        return false;
    }
    
    // Load the base CSV to check columns
    var temp_grid = load_csv(base_csv_path);
    var grid_width = ds_grid_width(temp_grid);
    
    show_debug_message("=== AUTO-DETECTING LANGUAGES FROM CSV ===");
    show_debug_message("CSV has " + string(grid_width) + " columns");
    
    // Get languages array
    var languages = global.LANGUAGE_CONFIG.languages;
    
    // Skip columns: 0=COMMENT, 1=speaker, then check language columns
    for (var col = 2; col < grid_width; col++) {
        var header = string_trim(string(temp_grid[# col, 0])); // First row has headers
        
        // Check if this is a language column (ends with " dialogue" or contains language code)
        if (string_pos("dialogue", string_lower(header)) > 0) {
            // Extract language code from header (e.g., "en" from "en dialogue")
            var language_code = "";
            var space_pos = string_pos(" ", header);
            
            if (space_pos > 0) {
                language_code = string_lower(string_copy(header, 1, space_pos - 1));
            } else {
                // Try to extract first 2-3 characters
                language_code = string_lower(string_copy(header, 1, 2));
            }
            
            show_debug_message("Found language column: '" + header + "' -> code: '" + language_code + "'");
            
            // Identify the language from the code
            var lang_info = loc_identify_language_from_code(language_code);
            
            if (lang_info != undefined) {
                // Check if this language already exists in our config
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
                    // Add the new language automatically - lang_info already contains all fields
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

/**
 * Identifies language configuration from a 2-letter language code
 * @function loc_identify_language_from_code
 * @param {string} code - 2-letter language code (e.g., "en", "jp", "fr")
 * @returns {Object|undefined} Language configuration object, or undefined if not found
 * @description Maps common language codes to full language configurations
 */
function loc_identify_language_from_code(code) {
    code = string_lower(string_trim(code));
    
    // Use a switch statement instead of struct/array for reliability
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
            // If not found, create a generic entry
            show_debug_message("Unknown language code: '" + code + "', creating generic entry");
            // Determine if this language likely needs special fonts
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

/**
 * Navigates to the next language in sequence
 * @function loc_next_language
 * @returns {Object} Current language information after navigation
 */
function loc_next_language() {
    return loc_update(undefined, 1);
}

/**
 * Navigates to the previous language in sequence
 * @function loc_prev_language
 * @returns {Object} Current language information after navigation
 */
function loc_prev_language() {
    return loc_update(undefined, -1);
}

/**
 * Gets the current language name (compatibility function)
 * @function loc_get_current_lang_name
 * @returns {string} Current language name (e.g., "ENGLISH")
 */
function loc_get_current_lang_name() {
    return global.LANGUAGE_CONFIG.get_by_id(global.lang).name;
}

/**
 * Gets the current language display name (compatibility function)
 * @function loc_get_current_display_name
 * @returns {string} Current language display name (e.g., "English")
 */
function loc_get_current_display_name() {
    return global.LANGUAGE_CONFIG.get_by_id(global.lang).display_name;
}

/**
 * Main translation function - retrieves localized text by key
 * @function loc_gettext
 * @param {string} key - Translation key to look up
 * @returns {string} Localized text, or the key itself if not found
 * @example
 * var title = loc_gettext("ui.config.title");
 * // Returns "Configuration" if English, "Configuration" if French, etc.
 */
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
    
    // Find the key in column 0 (COMMENT)
    for (var row = 1; row < grid_height; row++) {
        var comment_val = string(global.dialogue_grid[# 0, row]);
        comment_val = string_trim(comment_val);
        
        if (comment_val == search_key) {
            // Get current language
            var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
            
            // SIMPLE COLUMN MAPPING:
            // Column 0: COMMENT (key)
            // Column 1: en dialogue
            // Column 2: fr dialogue
            // Column 3: jp dialogue
            var lang_column = -1;
            
            switch (current_lang.id) {
                case 1: lang_column = 1; break; // English
                case 2: lang_column = 2; break; // French
                case 3: lang_column = 3; break; // Japanese
                default: lang_column = 1; // English fallback
            }
            
            // Ensure column exists
            if (lang_column >= grid_width) {
                return search_key;
            }
            
            // Get translation
            var translation = string(global.dialogue_grid[# lang_column, row]);
            translation = string_trim(translation);
            
            // If empty, try English fallback
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
    
    // Key not found
    return search_key;
}
	
/**
 * Gets language-specific font based on current language
 * @function loc_get_font
 * @param {number|string} _font_index - Font index or name
 * @returns {number|string} Language-specific font index or name
 * @description Appends font suffix for languages needing special fonts
 */
function loc_get_font(_font_index) {
    // Get current language info
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    // ONLY use special fonts for languages that need them (Japanese)
    if (current_lang.needs_special_font) {
        if (is_string(_font_index)) {
            // Scribble font - append language suffix
            return _font_index + current_lang.font_suffix;
        } else {
            // Regular GameMaker font - convert to language-specific version
            var font_name = font_get_name(_font_index);
            var lang_font_name = font_name + current_lang.font_suffix;
            var lang_font_id = asset_get_index(lang_font_name);
            
            if (lang_font_id != -1) {
                return lang_font_id;
            } else {
                // Fallback to original font
                return _font_index;
            }
        }
    } else {
        // For non-special languages (English, French), return original font
        return _font_index;
    }
}

/**
 * Gets font key with language suffix for Scribble library
 * @function loc_get_font_key
 * @param {string} _font_string - Font string/name
 * @returns {string} Font string with language suffix if needed
 */
function loc_get_font_key(_font_string) {
    if (is_undefined(_font_string) || !is_string(_font_string)) {
        return _font_string; // Return as-is if not a string
    }
    
    // Get current language info
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    
    // Check if this language needs a special font suffix
    if (current_lang.needs_special_font) {
        return _font_string + current_lang.font_suffix;
    } else {
        return _font_string;
    }
}
	
/**
 * Reloads all fonts for the current language
 * @function loc_reload_fonts
 */
function loc_reload_fonts() {
    // Clean up existing fonts
    if variable_struct_exists(global, "fnt_main_sm") font_delete(global.fnt_main_sm);
    if variable_struct_exists(global, "fnt_main_md") font_delete(global.fnt_main_md);
    if variable_struct_exists(global, "fnt_main_lg") font_delete(global.fnt_main_lg);
    if variable_struct_exists(global, "fnt_sans") font_delete(global.fnt_sans);
    
    // Reload fonts with new language
    loc_default_font();
}

/**
 * Updates language settings without breaking existing text lookups
 * @function loc_update_language_only
 * @param {number} new_lang - New language ID to set
 * @returns {boolean} Always returns true
 * @description Updates language and reloads sprites without full reinitialization
 */
function loc_update_language_only(new_lang) {
    show_debug_message("=== loc_update_language_only() called ===");
    
    if (new_lang == undefined) {
        show_debug_message("No language provided, skipping");
        return false;
    }
    
    // Always update the language
    var old_lang = global.lang;
    global.lang = new_lang;
    
    // Get current language info
    var current_lang = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    global.LOC = current_lang.name;
    
    show_debug_message("Language set to: " + current_lang.display_name + " (ID: " + string(global.lang) + ")");
    
    // ALWAYS reload sprites - no conditions, no early exit
    show_debug_message("Calling loc_default_sprites()...");
    loc_default_sprites();
    
    // Save if language actually changed
    if (old_lang != new_lang) {
        save_config();
        show_debug_message("Config saved (language changed from " + string(old_lang) + ")");
    } else {
        show_debug_message("Language unchanged, but sprites reloaded anyway");
    }
    
    show_debug_message("=== loc_update_language_only() complete ===");
	
	// Bake outlined fonts
	var sourceFont = loc_get_font("fnt_main_small")
	scribble_font_bake_outline_4dir(sourceFont,current_lang.needs_special_font == true ? "fnt_outline" + current_lang.font_suffix : "fnt_outline",c_black,false)
    
    return true; // Always return true since we always update sprites
}
	
/**
 * Debug function to display CSV structure and translation mappings
 * @function loc_debug_csv_structure
 */
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
    
    // Show all column headers
    show_debug_message("Column headers (row 0):");
    for (var col = 0; col < grid_width; col++) {
        var header = string(global.dialogue_grid[# col, 0]);
        show_debug_message("  Column " + string(col) + ": '" + header + "'");
    }
    
    // Show first 10 keys
    show_debug_message("First 10 keys (COMMENT column):");
    for (var row = 1; row < min(11, grid_height); row++) {
        var key = string(global.dialogue_grid[# 0, row]);
        key = string_trim(key);
        if (key != "") {
            show_debug_message("  Row " + string(row) + ": '" + key + "'");
            
            // Show all translations for this key
            for (var col = 2; col < min(5, grid_width); col++) { // Start at col 2 to skip COMMENT and speaker
                var translation = string(global.dialogue_grid[# col, row]);
                translation = string_trim(translation);
                var header = string(global.dialogue_grid[# col, 0]);
                show_debug_message("    " + header + ": '" + translation + "'");
            }
        }
    }
    
    // Test some specific keys
    var test_keys = ["ui.config.title", "ui.config.audio", "choice.back"];
    show_debug_message("Testing specific keys:");
    for (var i = 0; i < array_length(test_keys); i++) {
        var result = loc_gettext(test_keys[i]);
        show_debug_message("  '" + test_keys[i] + "' -> '" + result + "'");
    }
    
    show_debug_message("=== END CSV DEBUG ===");
}

// Example: Adding a new language (Spanish) later
// NOTE: This is only needed if for whatever reason the langauge isnt auto detected from the CSV
// Which is incredibly unlikely
// global.LANGUAGE_CONFIG.add_language(4, "SPANISH", "ESP_ES", "Español", "ES", false);