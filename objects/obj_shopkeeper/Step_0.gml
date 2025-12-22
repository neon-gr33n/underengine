if (instance_exists(obj_shop)) {
    // Smooth movement
    if (obj_shop.showItemInfo) {
        execute_tween(id, "x", destX, "linear", 0.1);
    }
    
    // Determine if shopkeeper should talk
    var is_talking = shopkeeper_should_talk();
    
    // Handle animation
    if (is_talking == true) {
        // Animate talking frames (1-2)
        talk_frame += talk_speed;
        
        // Ping-pong between frames 1 and 2
        if (talk_frame >= 3) talk_frame = 1;
        if (talk_frame < 1) talk_frame = 1;
        
        image_index = floor(talk_frame);
    } else {
        // Idle frame (0)
        talk_frame = 0;
        image_index = 0;
    }
    
    // Update portrait if needed (only when not animating)
    if (!is_talking || image_index == 0) {
        update_shopkeeper_portrait();
    }
}

/// Helper function: Check if shopkeeper should be talking
function shopkeeper_should_talk() {
    if (!instance_exists(obj_shop)) return false;
    
    var state = obj_shop.currentState;
    var result = false;
    
    // Debug
    if (keyboard_check_pressed(ord("D"))) {
        show_debug_message("=== SHOPKEEPER DEBUG ===");
        show_debug_message("State: " + state);
        if (obj_shop.typist != undefined) {
            show_debug_message("Typist state: " + string(obj_shop.typist.get_state()));
        }
        if (obj_shop.typist2 != undefined) {
            show_debug_message("Typist2 state: " + string(obj_shop.typist2.get_state()));
        }
    }
    
    // Never talk in sell state
    if (state == "shopSell") {
        if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: false (shopSell)");
        return false;
    }
    
    // Check hub and shopTalk states
    if (state == "hub" || state == "shopTalk" || state == "shopTalkLock") {
        if (obj_shop.typist != undefined) {
            result = obj_shop.typist.get_state() != 1; // Talk when NOT typing
            if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: " + string(result) + " (hub/shopTalk, typist != 1)");
            return result;
        }
        if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: false (no typist)");
        return false;
    }
    
    // Check shopItem state
    if (state == "shopItem") {
        if (obj_shop.typist2 != undefined) {
            result = obj_shop.typist2.get_state() != 1; // Talk when NOT typing
            if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: " + string(result) + " (shopItem, typist2 != 1)");
            return result;
        }
        if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: false (no typist2)");
        return false;
    }
    
    if (keyboard_check_pressed(ord("D"))) show_debug_message("Result: false (default)");
    return false;
}

/// Helper function: Update shopkeeper portrait
function update_shopkeeper_portrait() {
    if (!instance_exists(obj_shop)) return;
    
    var character = obj_shop.character;
    var state = obj_shop.currentState;
    
    // Default to neutral
    var portrait_name = "neutral";
    
    // Get appropriate portrait based on state
    if (state == "shopTalk" || state == "shopTalkLock") {
        var menu_talk_selection = obj_shop._menuTalkSelection;
        if (menu_talk_selection >= 0 && menu_talk_selection < array_length(obj_shop.talkPortraits)) {
            if (array_length(obj_shop.talkPortraits[menu_talk_selection]) >= 1) {
                portrait_name = obj_shop.talkPortraits[menu_talk_selection][0];
            }
        }
    }
    
    // Set the sprite
    sprite_index = global.characters[$ character].portraits[$ portrait_name];
}