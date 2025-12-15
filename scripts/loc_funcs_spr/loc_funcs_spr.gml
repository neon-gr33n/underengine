/**
 * Loads all default sprites for the current language.
 * Initializes or re-initializes the global sprite storage with language-specific sprites.
 * 
 * @function loc_default_sprites
 * @description Loads all default localized sprites for the current language setting.
 *              Cleans up any previously loaded sprites, then loads new sprites from
 *              the appropriate language folder. Uses English as a fallback if sprites
 *              are missing for the current language.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Called when language changes or on game initialization
 * loc_default_sprites();
 * 
 * @throws {Error} May fail silently if sprite files are missing, but logs debug messages.
 * 
 * @note Cleans up all previously loaded sprites before loading new ones.
 * @note Creates global.loc_sprites struct if it doesn't exist.
 * @note Uses language-specific folders based on language name (lowercase).
 * @note Falls back to English sprites if current language sprites are missing.
 * @note Currently loads battle interface sprites (buttons, miss indicators).
 * 
 * @see global.loc_sprites - Global struct storing loaded sprite indices
 * @see global.LANGUAGE_CONFIG - Language configuration object
 * @see loc_load_sprite - Function that loads individual sprites
 * @see loc_get_sprite - Function to retrieve loaded sprites
 * 
 * @sideeffects
 * - Creates/overwrites global.loc_sprites struct
 * - Deletes any previously loaded sprites from memory
 * - Loads new sprites into sprite resources
 * - Outputs debug messages about loading process
 * 
 * @global
 * @modifies global.loc_sprites
 * @requires sprite resources in language-specific folders
 * 
 */
function loc_default_sprites() {
    // Initialize sprite storage if it doesn't exist
    if (!variable_global_exists("loc_sprites")) {
        global.loc_sprites = {};
    } else {
        // Clean up existing sprites first
        var keys = variable_struct_get_names(global.loc_sprites);
        for (var i = 0; i < array_length(keys); i++) {
            var spr_index = global.loc_sprites[$ keys[i]];
            if (is_real(spr_index) && spr_index != -1 && sprite_exists(spr_index)) {
                sprite_delete(spr_index);
            }
        }
    }
    
    // Clear the struct for new sprites
    global.loc_sprites = {};
    
    // Get current language info for debug
    var language_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    show_debug_message("=== Loading sprites for: " + language_info.display_name + " ===");
    
    // Load new sprites
    global.loc_sprites.battle_bt = loc_load_sprite("battle_buttons", 10, 55, 21);
    global.loc_sprites.battle_miss = loc_load_sprite("battle_miss", 1, 55, 21);

    
    show_debug_message("Sprite loading complete");
}
	
/**
 * Loads a single sprite from the current language's sprite folder.
 * Attempts to load from language-specific folder, falls back to English.
 * 
 * @function loc_load_sprite
 * @description Loads a localized sprite from the file system. Searches in the
 *              current language's sprite folder first, then falls back to English
 *              if the sprite is not found. Automatically handles Android asset paths.
 * 
 * @param {string} sprite_name - Name of the sprite file (without extension).
 *                               Example: "battle_buttons", "battle_miss"
 * @param {number} subimages - Number of subimages in the sprite.
 *                             Determines animation frames or variants.
 * @param {number} xorig - X origin point for the sprite (pivot point).
 *                         Used for positioning and rotation.
 * @param {number} yorig - Y origin point for the sprite (pivot point).
 *                         Used for positioning and rotation.
 * 
 * @returns {number} Sprite index if loaded successfully, -1 if sprite not found.
 * 
 * @example
 * // Load battle buttons sprite with 10 frames
 * var btn_sprite = loc_load_sprite("battle_buttons", 10, 55, 21);
 * 
 * @example
 * // Load a simple sprite with single frame
 * var miss_sprite = loc_load_sprite("battle_miss", 1, 55, 21);
 * 
 * @throws {Error} Returns -1 if sprite file not found in any location.
 * 
 * @note Path structure: ./data/sprite/{language}/{sprite_name}.png
 * @note On Android: assets/data/sprite/{language}/{sprite_name}.png
 * @note Language folder names are lowercase versions of language names.
 * @note Uses sprite_add_ext for precise sprite loading control.
 * @note English is used as universal fallback language.
 * 
 * @see sprite_add_ext - GameMaker function to load sprites with extended options
 * @see global.LANGUAGE_CONFIG.get_by_id - Gets current language information
 * @see is_android - Platform detection function
 * 
 * @sideeffects
 * - Loads sprite resource into GameMaker's sprite system
 * - Outputs debug messages about loading success/failure
 * - May create new sprite index in resource table
 * 
 * @requires PNG sprite files in appropriate language folders
 * 
 */
function loc_load_sprite(sprite_name, subimages, xorig, yorig) {
    // Get language folder from current language ID
    var language_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
    var _loc_folder = string_lower(language_info.name);
    
    var _sprite_path = is_android() 
        ? "assets/data/sprite/" + _loc_folder + "/"
        : "./data/sprite/" + _loc_folder + "/";
    
    var file_path = _sprite_path + sprite_name + ".png";
    
    if (file_exists(file_path)) {
        var spr_index = sprite_add_ext(file_path, subimages, xorig, yorig, false);
        show_debug_message("Loaded: " + sprite_name + " from " + _loc_folder);
        return spr_index;
    }
    
    // English fallback
    show_debug_message(sprite_name + " not found in " + _loc_folder + ", trying English...");
    var english_path = (is_android() ? "assets/data/sprite/english/" : "./data/sprite/english/") + sprite_name + ".png";
    
    if (file_exists(english_path)) {
        var spr_index = sprite_add_ext(english_path, subimages, xorig, yorig, false);
        show_debug_message("Loaded English fallback: " + sprite_name);
        return spr_index;
    }
    
    show_debug_message("ERROR: " + sprite_name + " not found anywhere");
    return -1;
}

/**
 * Retrieves a previously loaded localized sprite index.
 * Provides safe access to sprites loaded by loc_default_sprites().
 * 
 * @function loc_get_sprite
 * @description Gets the sprite index for a localized sprite that was previously loaded.
 *              Includes safety checks to ensure the sprite exists and is valid.
 *              Used throughout the game to access language-specific graphics.
 * 
 * @param {string} sprite_name - Name of the sprite to retrieve.
 *                               Must match a key in global.loc_sprites.
 *                               Examples: "battle_bt", "battle_miss"
 * 
 * @returns {number} Sprite index if found and valid, -1 if sprite not found or invalid.
 * 
 * @example
 * // Get battle buttons sprite for drawing
 * var sprite_to_draw = loc_get_sprite("battle_bt");
 * if (sprite_to_draw != -1) {
 *     draw_sprite(sprite_to_draw, 0, x, y);
 * }
 * 
 * @example
 * // Check if a sprite is available before using it
 * if (loc_get_sprite("special_effect") != -1) {
 *     // Use the localized special effect sprite
 * }
 * 
 * @throws {Error} Returns -1 and logs warning if sprite not found in loc_sprites.
 * @throws {Error} Returns -1 if sprite was loaded but later deleted.
 * 
 * @note Always check return value before using (-1 indicates failure).
 * @note Uses sprite_exists() to validate sprite hasn't been deleted.
 * @note Provides debug messages for troubleshooting missing sprites.
 * @note Relies on global.loc_sprites being properly initialized.
 * 
 * @see global.loc_sprites - Global struct storing loaded sprite indices
 * @see sprite_exists - GameMaker function to check if sprite resource exists
 * @see loc_default_sprites - Function that loads sprites into loc_sprites
 * 
 * @sideeffects
 * - Outputs warning debug messages for missing sprites
 * - Validates sprite existence in resource table
 * 
 */
function loc_get_sprite(sprite_name) {
    if (!variable_global_exists("loc_sprites") || !variable_struct_exists(global.loc_sprites, sprite_name)) {
        show_debug_message("Warning: Sprite '" + sprite_name + "' not found in loc_sprites");
        return -1;
    }
    
    var spr_index = global.loc_sprites[$ sprite_name];
    
    // Safety check - if sprite was deleted somehow
    if (spr_index != -1 && !sprite_exists(spr_index)) {
        show_debug_message("Sprite '" + sprite_name + "' was missing");
        return -1;
    }
    
    return spr_index;
}