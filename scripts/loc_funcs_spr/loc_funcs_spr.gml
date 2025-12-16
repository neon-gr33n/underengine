/// @func loc_default_sprites()
/// @desc Initializes and loads language-specific sprites based on current language setting
/// @desc Cleans up existing sprites before loading new ones for the current language
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
    global.loc_sprites.battle_bt = loc_load_sprite("battle_buttons", 8, 55, 21);
    global.loc_sprites.battle_miss = loc_load_sprite("battle_miss", 1, 55, 21);
    
    show_debug_message("Sprite loading complete");
}
	
/// @func loc_load_sprite(sprite_name, subimages, xorig, yorig)
/// @desc Loads a language-specific sprite from the appropriate folder
/// @desc Searches in current language folder first, falls back to English if not found
/// @param {String} sprite_name Name of the sprite file (without extension)
/// @param {Number} subimages Number of subimages in the sprite
/// @param {Number} xorig X origin point for the sprite
/// @param {Number} yorig Y origin point for the sprite
/// @return {Number} Sprite index if loaded successfully, -1 if sprite not found
/// @example
/// var spr_index = loc_load_sprite("battle_buttons", 8, 55, 21);
/// if (spr_index != -1) {
///     sprite_index = spr_index;
/// }
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

/// @func loc_get_sprite(sprite_name)
/// @desc Retrieves a previously loaded language-specific sprite by name
/// @desc Includes safety checks to ensure sprite still exists in memory
/// @param {String} sprite_name Name of the sprite to retrieve (as stored in loc_sprites)
/// @return {Number} Sprite index if found and valid, -1 if sprite not found or deleted
/// @example
/// var battle_sprite = loc_get_sprite("battle_buttons");
/// if (battle_sprite != -1) {
///     draw_sprite(battle_sprite, 0, x, y);
/// }
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