global.SHOP_INFO = {
    __SHOP__: {
        SHOPS: {},
    },
    
    DEFAULT: {
        NAME: "Shop",
        SHOPKEEPER: "shopkeep_1",
        BACKGROUND: spr_shop_bg_test,
        MUSIC: "shop",
        CAN_SELL: true,
        
        // Texts
        GREETING: "* Hello, traveler!#* How may I help you?",
        TALK_TEXT: "* What do you wish#\tto discuss?",
        EXIT_TEXT: "* Come back anytime!",
        BUY_TEXT: "* Thank you for#  your purchase!",
		BUY_CANCEL_TEXT: "* Take your time!", 
        BUY_FAIL_TEXT: "* You don't#  have enough money#  for that!#* Come back later!",
        BUY_NO_SPACE_TEXT: "* You don't#  have enough space#  for that!#",
        SELL_NO_ITEMS_TEXT: "* You don't#  have any items#  to sell!",
        SELL_FAIL_TEXT: "* I'm trying to sell#\tstuff not get#\tmore of it!", 
        
        // Items array will be populated at runtime
        ITEMS: [],
        SOLD_OUT_ITEMS: {},
        
        // Talk options
        TALK_OPTIONS: [
            "Say hello",
            "What to do here",
            "Town history",
            "Your life",
            "Exit"
        ],
        
        TALK_DIALOGUE: {
            OPT_A: [
                "* Hiya! Welcome#  to my shop!#* Take your time looking around."
            ],
            OPT_B: [
                "* You can buy items#  by selecting 'Buy',#  and sell items#  with 'Sell'."
            ],
            OPT_C: [
                "* I've been running#  this shop for years.#* People come and go,#  but I stay here."
            ],
            OPT_D: [
                "* Life is good.#* Business is steady.#* What more could#  I ask for?"
            ]
        },
        
        TALK_PORTRAITS: [
            ["neutral", "neutral"],
            ["neutral"],
            ["neutral"],
            ["neutral"]
        ],
        
        // Helper methods
        add_item: function(item_id, can_sell_out = false, max_stock = -1, buy_bonus_a = "", buy_bonus_b = "") {
		    // Add item to this shop
		    var item_data = {
		        id: item_id,
		        name: item_get_attribute(item_id, "NAME"),
		        price: 10, // Default price - we'll calculate it properly below
		        category: item_get_category(item_id),
		        description: item_get_attribute(item_id, "DESCRIPTION"),
		        can_sell_out: can_sell_out,
		        max_stock: max_stock,
		        current_stock: max_stock,
		        bonus_a: buy_bonus_a,
		        bonus_b: buy_bonus_b
		    };
    
		    // Calculate price correctly using item_get_struct
		    var item_struct = item_get_struct(item_id);
		    if (variable_struct_exists(item_struct, "SELL_VALUE")) {
		        item_data.price = item_struct.SELL_VALUE * 2; // Price is 2x sell value
		    }
    
		    // Auto-populate bonuses from item effects if not provided
		    if (buy_bonus_a == "" || buy_bonus_b == "") {
		        if (variable_struct_exists(item_struct, "EFFECTS")) {
		            var effects = item_struct.EFFECTS;
            
		            if (buy_bonus_a == "") {
		                if (variable_struct_exists(effects, "HP") && effects.HP > 0) {
		                    item_data.bonus_a = "+" + string(effects.HP) + " HP";
		                } else if (variable_struct_exists(effects, "ATK") && effects.ATK > 0) {
		                    item_data.bonus_a = "+" + string(effects.ATK) + " ATK";
		                } else if (variable_struct_exists(effects, "DEF") && effects.DEF > 0) {
		                    item_data.bonus_a = "+" + string(effects.DEF) + " DEF";
		                } else {
		                    item_data.bonus_a = ""; // No primary bonus
		                }
		            }
            
		            if (buy_bonus_b == "") {
		                if (variable_struct_exists(effects, "MP") && effects.MP > 0) {
		                    item_data.bonus_b = "+" + string(effects.MP) + " MP";
		                } else if (variable_struct_exists(effects, "MAX_HP") && effects.MAX_HP > 0) {
		                    item_data.bonus_b = "+" + string(effects.MAX_HP) + " MAX HP";
		                } else if (variable_struct_exists(effects, "MAX_MP") && effects.MAX_MP > 0) {
		                    item_data.bonus_b = "+" + string(effects.MAX_MP) + " MAX MP";
		                } else {
		                    item_data.bonus_b = ""; // No secondary bonus
		                }
		            }
		        } else if (item_data.category == "WEAPON" && variable_struct_exists(item_struct, "ATK")) {
		            item_data.bonus_a = "+" + string(item_struct.ATK) + " ATK";
		        } else if (item_data.category == "ARMOUR" && variable_struct_exists(item_struct, "DEF")) {
		            item_data.bonus_a = "+" + string(item_struct.DEF) + " DEF";
		        }
		    }
    
		    array_push(this.ITEMS, item_data);
    
		    if (can_sell_out && max_stock > 0) {
		        this.SOLD_OUT_ITEMS[$ item_id] = false;
		    }
		},
        
        remove_item: function(item_id) {
            // Remove item from this shop
            for (var i = array_length(this.ITEMS) - 1; i >= 0; i--) {
                if (this.ITEMS[i].id == item_id) {
                    array_delete(this.ITEMS, i, 1);
                    
                    if (variable_struct_exists(this.SOLD_OUT_ITEMS, item_id)) {
                        variable_struct_remove(this.SOLD_OUT_ITEMS, item_id);
                    }
                    break;
                }
            }
        },
        
		get_available_items: function() {
		    // Get ALL items, including sold out ones
		    var all_items = [];
		    for (var i = 0; i < array_length(this.ITEMS); i++) {
		        array_push(all_items, this.ITEMS[i]);
		    }
		    return all_items;
		},

		// Add a new method to check if an item is sold out
		is_item_sold_out: function(item_id) {
		    var item = this.get_item_by_id(item_id);
		    if (item) {
		        return item.can_sell_out && item.current_stock == 0;
		    }
		    return false;
		},
        
        is_sold_out: function(item_id) {
            if (variable_struct_exists(this.SOLD_OUT_ITEMS, item_id)) {
                return this.SOLD_OUT_ITEMS[$ item_id];
            }
            return false;
        },
        
        reset_stock: function() {
            // Reset all limited stock items
            for (var i = 0; i < array_length(this.ITEMS); i++) {
                var item = this.ITEMS[i];
                if (item.can_sell_out) {
                    item.current_stock = item.max_stock;
                    if (variable_struct_exists(this.SOLD_OUT_ITEMS, item.id)) {
                        this.SOLD_OUT_ITEMS[$ item.id] = false;
                    }
                }
            }
        },
        
        // Helper to get item by ID
        get_item_by_id: function(item_id) {
            for (var i = 0; i < array_length(this.ITEMS); i++) {
                if (this.ITEMS[i].id == item_id) {
                    return this.ITEMS[i];
                }
            }
            return undefined;
        }
    }
};