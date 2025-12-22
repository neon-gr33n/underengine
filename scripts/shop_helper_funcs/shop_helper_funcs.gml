
#region INITIALIZATION AND SETUP
/// @function ShopekeeperInit(shop_id, shop_type)
/// @desc Initializes a new shop with the given ID and type
/// @param {string} shop_id - Unique ID for this shop
/// @returns {struct} The created shop struct
function ShopekeeperInit(shop_id) {
    // Check if SHOP_INFO exists, create it if not
    if (!variable_global_exists("SHOP_INFO")) {
       shop_data_init();
    }
    
    // Get the DEFAULT template
    var default_shop = variable_struct_get(global.SHOP_INFO, "DEFAULT");
    
    // Use your struct_copy function
    var new_shop = struct_copy(default_shop);
    
    // Clear items for fresh start
    new_shop.ITEMS = [];
    new_shop.SOLD_OUT_ITEMS = {};
    
    // Store shop in global registry
    global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id] = new_shop;
    
    // Set as current shop
    global.current_shop = shop_id;
    
    // Initialize shop object appearance
    var shop = global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    
    // Set up shop object appearance
    if (instance_exists(obj_shopkeeper)) {
        obj_shopkeeper.sprite_index = global.characters[$ shop.SHOPKEEPER].portraits.neutral;
    }
    
    if (instance_exists(obj_shop_bg) && shop.BACKGROUND != undefined) {
        obj_shop_bg.sprite_index = shop.BACKGROUND;
    }
    
    if (shop.MUSIC != "") {
        mus_playx(mus_load(shop.MUSIC), true, , , 0.95);
    }
    
    return shop;
}
/// @function ShopInitializeGlobal()
/// @desc Initializes the global shop system if not already initialized
function ShopInitializeGlobal() {
    if (!variable_global_exists("SHOP_INFO")) {
        // Force initialization by calling ShopekeeperInit once
        ShopekeeperInit("__INIT__", "default");
        // Remove the initialization shop
        variable_struct_remove(global.SHOP_INFO.__SHOP__.SHOPS, "__INIT__");
        global.current_shop = undefined;
    }
}

// Add this helper function:
/// @function ShopExists(shop_id)
function ShopExists(shop_id) {
    return variable_global_exists("SHOP_INFO") && 
           variable_struct_exists(global.SHOP_INFO.__SHOP__.SHOPS, shop_id);
}
#endregion

#region ITEM MANAGEMENT

/// @function ShopitemAdd(item_id, can_sell_out, max_stock, buy_bonus_a, buy_bonus_b)
/// @desc Adds an item to the current shop
/// @param {string} item_id - Item ID from equipment system
/// @param {bool} [can_sell_out=false] - Can this item sell out?
/// @param {number} [max_stock=-1] - Max quantity (-1 = infinite)
/// @param {string} [buy_bonus_a=""] - Primary bonus text (e.g., "+35 HP")
/// @param {string} [buy_bonus_b=""] - Secondary bonus text (e.g., "+1 MP")
function ShopitemAdd(item_id, can_sell_out = false, max_stock = -1, buy_bonus_a = "", buy_bonus_b = "") {
    // Debug: Check if shop system exists
    if (!variable_global_exists("SHOP_INFO")) {
        show_debug_message("ERROR: SHOP_INFO doesn't exist! Call ShopekeeperInit first!");
        return;
    }
    
    // Debug: Check if current_shop exists
    if (!variable_global_exists("current_shop")) {
        show_debug_message("ERROR: current_shop not set! Call ShopekeeperInit first!");
        return;
    }
    
    var shop_id = global.current_shop;
    
    // Debug: Check if shop exists
    if (!variable_struct_exists(global.SHOP_INFO.__SHOP__.SHOPS, shop_id)) {
        show_debug_message("ERROR: Shop '" + shop_id + "' doesn't exist in SHOPS!");
        return;
    }
    
    var shop = global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    
    // Now add the item
    shop.add_item(item_id, can_sell_out, max_stock, buy_bonus_a, buy_bonus_b);
    show_debug_message("SUCCESS: Added item " + item_id + " to shop " + shop_id);
}

/// @function ShopitemAddCustom(item_id, display_name, price, category, description, can_sell_out, max_stock, buy_bonus_a, buy_bonus_b)
/// @desc Adds a custom item not in the equipment system to the current shop
/// @param {string} item_id - Unique ID for this item
/// @param {string} display_name - Name to display in shop
/// @param {number} price - Price in gold
/// @param {string} category - Item category (CONSUMABLE, WEAPON, ARMOUR, KEY)
/// @param {string} description - Item description
/// @param {bool} [can_sell_out=false] - Can this item sell out?
/// @param {number} [max_stock=-1] - Max quantity (-1 = infinite)
/// @param {string} [buy_bonus_a=""] - Primary bonus text
/// @param {string} [buy_bonus_b=""] - Secondary bonus text
function ShopitemAddCustom(item_id, display_name, price, category, description, can_sell_out = false, max_stock = -1, buy_bonus_a = "", buy_bonus_b = "") {
    if (!variable_global_exists("current_shop")) {
        show_debug_message("Error: No active shop. Call ShopekeeperInit first!");
        return;
    }
    
    var shop_id = global.current_shop;
    var shop = global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    
    var item_data = {
        id: item_id,
        name: display_name,
        price: price,
        category: category,
        description: description,
        can_sell_out: can_sell_out,
        max_stock: max_stock,
        current_stock: max_stock,
        bonus_a: buy_bonus_a,
        bonus_b: buy_bonus_b
    };
    
    array_push(shop.ITEMS, item_data);
    
    if (can_sell_out && max_stock > 0) {
        shop.SOLD_OUT_ITEMS[$ item_id] = false;
    }
}

/// @function ShopitemRemove(item_id)
/// @desc Removes an item from the current shop
/// @param {string} item_id - Item ID to remove
function ShopitemRemove(item_id) {
    if (!variable_global_exists("current_shop")) return;
    
    var shop_id = global.current_shop;
    var shop = global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    
    shop.remove_item(item_id);
}

/// @function ShopitemClearAll()
/// @desc Removes all items from the current shop
function ShopitemClearAll() {
    if (!variable_global_exists("current_shop")) return;
    
    var shop_id = global.current_shop;
    var shop = global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    
    shop.ITEMS = [];
    shop.SOLD_OUT_ITEMS = {};
}

#endregion

#region SHOP PROPERTY MANAGEMENT

/// @function ShopSetBackground(bg_sprite)
/// @desc Sets the background sprite for the current shop
/// @param {string} bg_sprite - Sprite name for background
function ShopSetBackground(bg_sprite) {
    var shop = ShopGetCurrent();
    if (shop) {
        shop.BACKGROUND = bg_sprite;
        if (instance_exists(obj_shop_bg)) {
            obj_shop_bg.sprite_index = bg_sprite;
        }
    }
}

/// @function ShopSetMusic(music_track)
/// @desc Sets the music track for the current shop
/// @param {string} music_track - Audio track name
function ShopSetMusic(music_track) {
    var shop = ShopGetCurrent();
    if (shop) {
        shop.MUSIC = music_track;
        mus_playx(mus_load(shop.MUSIC),true,,,0.95)
    }
}

/// @function ShopSetShopkeeper(shopkeeper_id)
/// @desc Sets the shopkeeper character for the current shop
/// @param {string} shopkeeper_id - Shopkeeper character ID
function ShopSetShopkeeper(shopkeeper_id) {
    var shop = ShopGetCurrent();
    if (shop) {
        shop.SHOPKEEPER = shopkeeper_id;
        if (instance_exists(obj_shopkeeper)) {
            obj_shopkeeper.sprite_index = global.characters[$ shopkeeper_id].portraits.neutral;
        }
    }
}

/// @function ShopSetGreeting(text)
/// @desc Sets the greeting text for the current shop
/// @param {string} text - Greeting text with # for line breaks
function ShopSetGreeting(text) {
    var shop = ShopGetCurrent();
    if (shop) shop.GREETING = text;
}

/// @function ShopSetExitText(text)
/// @desc Sets the exit text for the current shop
/// @param {string} text - Exit text
function ShopSetExitText(text) {
    var shop = ShopGetCurrent();
    if (shop) shop.EXIT_TEXT = text;
}
	
/// @function ShopSetSellFailText(text)
/// @desc Sets the sell fail text for the current shop
/// @param {string} text - Text when selling is not allowed
function ShopSetSellFailText(text) {
    var shop = ShopGetCurrent();
    if (shop) shop.SELL_FAIL_TEXT = text;
}

/// @function ShopCanSell(allow_selling)
/// @desc Sets whether selling is allowed in the current shop
/// @param {bool} allow_selling - True to allow selling items
function ShopCanSell(allow_selling) {
    var shop = ShopGetCurrent();
    if (shop) shop.CAN_SELL = allow_selling;
}

/// @function ShopSetTalkOptions(options_array)
/// @desc Sets the talk options for the current shop
/// @param {array} options_array - Array of talk option strings
function ShopSetTalkOptions(options_array) {
    var shop = ShopGetCurrent();
    if (shop) shop.TALK_OPTIONS = options_array;
}

/// @function ShopSetTalkDialogue(dialogue_struct)
/// @desc Sets the talk dialogue for the current shop
/// @param {struct} dialogue_struct - Struct containing OPT_A, OPT_B, etc. arrays
function ShopSetTalkDialogue(dialogue_struct) {
    var shop = ShopGetCurrent();
    if (shop) shop.TALK_DIALOGUE = dialogue_struct;
}

/// @function ShopSetTalkPortraits(portraits_array)
/// @desc Sets the portrait sequences for talk options
/// @param {array} portraits_array - Array of portrait name arrays
function ShopSetTalkPortraits(portraits_array) {
    var shop = ShopGetCurrent();
    if (shop) shop.TALK_PORTRAITS = portraits_array;
}

#endregion

#region SHOP ACCESS & UTILITIES

/// @function ShopGetCurrent()
/// @desc Gets the current active shop struct
/// @returns {struct} Current shop struct, or undefined if none
function ShopGetCurrent() {
    // Check if global shop system exists
    if (!variable_global_exists("SHOP_INFO")) {
		shop_data_init()
    }
    
    // Check if current_shop exists
    if (!variable_global_exists("current_shop")) {
        return undefined;
    }
    
    var shop_id = global.current_shop;
    
    // Check if the shop exists in SHOPS
    if (!variable_struct_exists(global.SHOP_INFO.__SHOP__.SHOPS, shop_id)) {
        return undefined;
    }
    
    return global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
}

/// @function ShopGet(shop_id)
/// @desc Gets a shop struct by ID
/// @param {string} shop_id - Shop ID to retrieve
/// @returns {struct} Shop struct, or undefined if not found
function ShopGet(shop_id) {
    if (variable_global_exists("SHOP_INFO") && 
        variable_struct_exists(global.SHOP_INFO.__SHOP__.SHOPS, shop_id)) {
        return global.SHOP_INFO.__SHOP__.SHOPS[$ shop_id];
    }
    return undefined;
}

/// @function ShopSetCurrent(shop_id)
/// @desc Sets the current active shop
/// @param {string} shop_id - Shop ID to make active
function ShopSetCurrent(shop_id) {
    if (ShopGet(shop_id)) {
        global.current_shop = shop_id;
    }
}

/// @function ShopGetAvailableItems()
/// @desc Gets all available (not sold out) items from current shop
/// @returns {array} Array of available item structs
function ShopGetAvailableItems() {
    var shop = ShopGetCurrent();
    if (shop) {
        return shop.get_available_items();
    }
    return [];
}

/// @function ShopIsItemSoldOut(item_id)
/// @desc Checks if an item is sold out in the current shop
/// @param {string} item_id - Item ID to check
/// @returns {bool} True if item is sold out
function ShopIsItemSoldOut(item_id) {
    var shop = ShopGetCurrent();
    if (shop) {
        return shop.is_sold_out(item_id);
    }
    return false;
}

/// @function ShopGetItemById(item_id)
/// @desc Gets an item struct by ID from current shop
/// @param {string} item_id - Item ID to retrieve
/// @returns {struct} Item struct, or undefined if not found
function ShopGetItemById(item_id) {
    var shop = ShopGetCurrent();
    if (shop) {
        return shop.get_item_by_id(item_id);
    }
    return undefined;
}

#endregion

#region STOCK MANAGEMENT

/// @function ShopResetStock(shop_id)
/// @desc Resets all limited stock items to their max quantity
/// @param {string} [shop_id=current_shop] - Shop ID to reset (defaults to current)
function ShopResetStock(shop_id = global.current_shop) {
    var shop = ShopGet(shop_id);
    if (shop) {
        shop.reset_stock();
    }
}

/// @function ShopRestockItem(item_id, new_stock)
/// @desc Restocks a specific item in the current shop
/// @param {string} item_id - Item ID to restock
/// @param {number} new_stock - New stock quantity (-1 for infinite)
function ShopRestockItem(item_id, new_stock) {
    var shop = ShopGetCurrent();
    if (!shop) return;
    
    for (var i = 0; i < array_length(shop.ITEMS); i++) {
        if (shop.ITEMS[i].id == item_id) {
            shop.ITEMS[i].max_stock = new_stock;
            shop.ITEMS[i].current_stock = new_stock;
            
            // Update sold out status
            if (new_stock > 0 || new_stock == -1) {
                if (variable_struct_exists(shop.SOLD_OUT_ITEMS, item_id)) {
                    shop.SOLD_OUT_ITEMS[$ item_id] = false;
                }
            }
            break;
        }
    }
}

/// @function ShopPurchaseItem(item_id)
/// @desc Handles purchasing an item from the current shop
/// @param {string} item_id - Item ID to purchase
/// @returns {string} Result: "success", "no_gold", "no_space", "sold_out", or "not_found"
function ShopPurchaseItem(item_id) {
    var shop = ShopGetCurrent();
    if (!shop) return "not_found";
    
    var item = shop.get_item_by_id(item_id);
    if (!item) return "not_found";
    
    // Check if sold out
    if (item.can_sell_out && item.current_stock == 0) {
        return "sold_out";
    }
    
    // Check player gold
    if (player_get_gold() < item.price) {
        return "no_gold";
    }
    
    // Check inventory space
    if (inven_get_space_left() == 0) {
        return "no_space";
    }
    
    // Purchase successful
    inven_add_item(item.id);
    player_deduct_gold(item.price);
    
    // Update stock if limited
    if (item.can_sell_out && item.current_stock > 0) {
        item.current_stock--;
        
        // Update in shop items array
        for (var i = 0; i < array_length(shop.ITEMS); i++) {
            if (shop.ITEMS[i].id == item.id) {
                shop.ITEMS[i].current_stock = item.current_stock;
                
                // Mark as sold out if needed
                if (item.current_stock == 0) {
                    shop.SOLD_OUT_ITEMS[$ item.id] = true;
                }
                break;
            }
        }
    }
    
    return "success";
}

#endregion

#region (DEBUG)

/// @function ShopListAll()
/// @desc Returns an array of all shop IDs
/// @returns {array} Array of shop ID strings
function ShopListAll() {
    if (!variable_global_exists("SHOP_INFO")) return [];
    return variable_struct_get_names(global.SHOP_INFO.__SHOP__.SHOPS);
}

/// @function ShopDebugInfo(shop_id)
/// @desc Prints debug information about a shop to the console
/// @param {string} shop_id - Shop ID to debug
function ShopDebugInfo(shop_id = global.current_shop) {
    var shop = ShopGet(shop_id);
    if (!shop) {
        show_debug_message("Shop '" + shop_id + "' not found!");
        return;
    }
    
    show_debug_message("=== SHOP DEBUG: " + shop_id + " ===");
    show_debug_message("Name: " + shop.NAME);
    show_debug_message("Type: " + shop.TYPE);
    show_debug_message("Shopkeeper: " + shop.SHOPKEEPER);
    show_debug_message("Can Sell: " + string(shop.CAN_SELL));
    show_debug_message("Items: " + string(array_length(shop.ITEMS)));
    
    for (var i = 0; i < array_length(shop.ITEMS); i++) {
        var item = shop.ITEMS[i];
        var status = (item.can_sell_out) ? 
                     string(item.current_stock) + "/" + string(item.max_stock) : 
                     "Infinite";
        show_debug_message("  " + item.name + " - " + string(item.price) + "G [" + status + "]");
    }
}

/// @function ShopCleanup()
/// @desc Cleans up shop system (call when switching rooms/areas)
function ShopCleanup() {
    // Reset current shop
    global.current_shop = undefined;
    
    // Optionally: Clear temporary shops
    // var shops = ShopListAll();
    // for (var i = 0; i < array_length(shops); i++) {
    //     if (string_copy(shops[i], 1, 6) == "temp_") {
    //         variable_struct_remove(global.SHOP_INFO.__SHOP__.SHOPS, shops[i]);
    //     }
    // }
}

#endregion

// Initialize global shop system on first include
ShopInitializeGlobal();