/**
 * Sets battle menu text for enemy encounters and stores it for future reference.
 * Configures the text writer object to display encounter-specific dialogue in battle.
 * 
 * @function encounter_set_menu_text
 * @description Updates the battle text display with encounter-specific messages.
 *              Used to show enemy dialogue, attack descriptions, status messages,
 *              or other battle-related text in the battle interface.
 *              Optionally stores the text for later reuse (e.g., repeating messages).
 * 
 * @param {string} _text - The text to display in the battle menu.
 *                         Can be a literal string or a localization key.
 *                         If empty string ("") is provided, text is not stored for reuse.
 * 
 * @returns {void} This function does not return a value.
 * 
 * @example
 * // Display enemy dialogue when encountered
 * encounter_set_menu_text("A wild Goblin appears!");
 * 
 * @example
 * // Display attack description
 * encounter_set_menu_text("The dragon breathes fire!");
 * 
 * @example
 * // Display localized text using loc_gettext
 * encounter_set_menu_text(loc_gettext("enemy.taunt"));
 * 
 * @example
 * // Clear text without storing for reuse
 * encounter_set_menu_text("");
 * 
 * @throws {Error} May fail silently if:
 *                 - obj_text_writer doesn't exist
 *                 - obj_battle_handler doesn't exist
 *                 - loc_get_font fails to return a valid font
 * 
 * @note Uses battle-specific font from localization system.
 * @note Sets text position to "battle_generic" (predefined text position).
 * @note Only stores non-empty text for reuse in encounterMenuText variable.
 * @note The stored text can be retrieved later for repeating messages.
 * 
 * @see obj_text_writer - Object responsible for rendering text in the game
 * @see obj_battle_handler - Main battle controller that stores battle state
 * @see loc_get_font - Function to get language-appropriate fonts
 * @see global.encounterMenuText - Variable storing the last displayed text
 * 
 * @sideeffects
 * - Sets dialogue properties on obj_text_writer:
 *   - dialogue.dialogueFont
 *   - dialoguePosition
 *   - dialogue.dialogueText
 * - Sets encounterMenuText on obj_battle_handler (if text is non-empty)
 * 
 */
function encounter_set_menu_text(_text) {
    /// @arg menuText
    
    // Configure the text writer object with battle-specific settings
    with (obj_text_writer) {
        // Set battle-appropriate font (handles language-specific fonts)
        dialogue.dialogueFont = loc_get_font("fnt_main_bt");
        
        // Use predefined battle text position
        dialoguePosition = "battle_generic";
        
        // Set the actual text to display
        dialogue.dialogueText = _text;
    }
    
    // Store encounter text in a variable for later re-use
    // Only store non-empty text to allow clearing without saving
    if (_text != "") {
        with (obj_battle_handler) {
            encounterMenuText = _text;
        }
    }
}