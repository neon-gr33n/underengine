// obj_shop Create Event
/// @description Shop Initialization
_itemSelection = 0;
_menuSelection = 0;
_menuItemSelection = 0;
_menuSellSelection = 0;
_menuTalkSelection = 0;
currentState = "initializing"; // Start in initialization state

// Shop state variables
showItemInfo = false; // Show item info panel by default
_shop_initialized = false;

// Text variables (will be populated from shop struct)
__color = "c_white";
__outline_color = c_black;
__text = "";
__shopkeeperText = "";
__talkText = "";
__exitText = "";
__buyText = "";
__buyFailText = "";
__buyNoSpaceText = "";
__sellNoItemsText = "";
__sellFailText = ""; // New: for when selling is not allowed
__text2 = "What would#you like#to buy?";

// Character/sound variables
character = "";
_voiceSound = undefined;
__font = fnt_main;
_speed = 1.5;
_alpha = 1;

// Typists for text animation
typist = scribble_typist();
typist.in(_speed, 0.1);
typewriter_state = 0;

typist2 = scribble_typist();
typist2.in(_speed, 0.1);

// Cursor positions
selCursorYPos = 205;
selCursorXPos = 72;

// Talk system variables
dialogueKey = "";
dialogueIndex = 0;
talk_options = [];
talkDialogue = {};
talkPortraits = [];

/// @function shop_find_first_valid_item(available_items, start_index = 0)
/// @desc Finds first non-sold-out item starting from start_index
function shop_find_first_valid_item(available_items, start_index = 0) {
    var total_items = array_length(available_items);
    
    for (var i = start_index; i < total_items + 1; i++) {
        if (i == total_items) {
            // Exit option (always valid)
            return i;
        } else {
            var item = available_items[i];
            if (!(item.can_sell_out && item.current_stock == 0)) {
                return i;
            }
        }
    }
    
    // Should never reach here, but fallback
    return total_items; // Exit option
}
	
function shop_find_category_subtitle(category){
	switch(category){
		case "CONSUMABLE":
			return "Healing item"
		break;
		case "WEAPON":
			return "Physical weapon"
		break;
		case "ARMOUR":
			return "Defensive charm"
		break;
	}
}