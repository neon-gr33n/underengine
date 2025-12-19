/// @category Overworld
/// @title Inventory Functions

function inven_get_item(index) {
	var inven = party_get_attribute("INVENTORY");
	
	if (index < array_length(inven)) {
		return inven[@ index];
	} else {
		return noone;
	}
}

function inven_get_item_by_name(item_name) {
    var inven = party_get_attribute("INVENTORY");
    
    for (var i = 0; i < array_length(inven); i++) {
        if (inven[@ i] == item_name) {
            return i; // Return the index where the item was found
        }
    }
    
    return noone; // Return noone if item was not found
}

function storage_get_item(index) {
	var storage = party_get_attribute("STORAGE");
	
	if (index < array_length(storage)) {
		return storage[@ index];
	} else {
		return noone;
	}
}

function inven_get_item_index(item) {
	var inven = party_get_attribute("INVENTORY");
	
	return array_get_index(inven, item);
}

function storage_get_item_index(item) {
	var storage = party_get_attribute("INVENTORY");
	
	return array_get_index(storage, item);
}

function inven_get_space_left() {
	return party_get_attribute("MAXINVSIZE") - array_length(party_get_attribute("INVENTORY"));
}

function storage_get_space_left() {
	return party_get_attribute("MAXSTORAGESIZE") - array_length(party_get_attribute("STORAGE"));
}

function storage_add_item(item, quantity=1){
	var storage = party_get_attribute("STORAGE");
	var space = storage_get_space_left();
	
	repeat (min(quantity, space)) {
		array_push(storage, item);
	}
}

function inven_add_item(item, quantity=1, overflow=true){
	var inven = party_get_attribute("INVENTORY");
	var space = inven_get_space_left();
	
	if (quantity > space) {
		repeat (space) {
			array_push(inven, item);
		}
		if (overflow) {
			storage_add_item(item, quantity - space);
		}
	} else {
		repeat (quantity) {
			array_push(inven, item);
		}
	}
}

function inven_remove_index(index) {
	array_delete(party_get_attribute("INVENTORY"), index, 1);
}

function storage_remove_index(index) {
	array_delete(party_get_attribute("STORAGE"), index, 1);
}

function inven_remove_item(item) {
    // Get the index of the item
    var item_index = inven_get_item_by_name(item);
    
    // If item was found
    if (item_index != noone) {
        // Get the actual item name from inventory
        var inven = party_get_attribute("INVENTORY");
        var item_name = inven[@ item_index];
        
        // Check if it's a KEY item
        if (item_get_category(item_name) != "KEY") {
            inven_remove_index(item_index);
        } else {
            sfx_play(snd_error, 1);
        }
    } else {
        // Item not found in inventory
        sfx_play(snd_error, 1);
    }
}

function storage_remove_item(item) {
	storage_remove_index(storage_get_item_index(item));
}

function inven_to_storage(index) {
	if (storage_get_space_left()) {
		storage_add_item(inven_get_item(index));
		inven_remove_index(index);
		return true;
	}
	return false;
}

function storage_to_inven(index) {
	if (inven_get_space_left()) {
		inven_add_item(storage_get_item(index));
		storage_remove_index(index);
		return true;
	}
	return false;
}

function inven_replace_index(index, item) {
	party_get_attribute("INVENTORY")[@ index] = item;
}

function storage_replace_index(index, item) {
	party_get_attribute("STORAGE")[@ index] = item;
}

function inven_storage_swap(inven_index, storage_index) {
	var temp = inven_get_item(inven_index);
	inven_replace_index(inven_index, storage_get_item(storage_index));
	storage_replace_index(storage_index, temp);
}

function inven_use_item(inv_index, party_index){
	var inven = party_get_attribute("INVENTORY");
	var item = inven_get_item(inv_index);
	var category = item_get_category(item);
	_targ_member = party_get_member(party_index);
	var item_s = item_get_struct(item);
	
	switch (category) {
		case "WEAPON":
		case "ARMOUR":
			var temp = member_get_stat(_targ_member, category);
			member_set_stat(_targ_member, category, item);
			
			if (temp == "NO_ARMOUR" || temp == "NO_WEAPON") {
				// If currently equipped item is "NONE", just remove the new item from inventory
				inven_remove_index(inv_index);
			} else {
				// Otherwise, swap items (put old equipped item into inventory)
				inven_replace_index(inv_index, temp);
			}
			break;
			
		case "CONSUMABLE":
			if (struct_exists(item_s,"EFFECTS"))
				struct_foreach(item_s[$ "EFFECTS"], function(_key, _val) {
					if (is_real(_val))
						member_change_stat(_targ_member, _key, _val);
					else
						member_set_stat(_targ_member, _key, _val);
				});
			
			if (struct_exists(item_s, "TEAM_EFFECTS"))
				struct_foreach(item_s[$ "TEAM_EFFECTS"], function(_key, _val) {
					for (var i = 0; i < array_length(party_get_attribute("MEMBERS")); ++i) {
						if (is_real(_val))
							member_change_stat(party_get_member(i), _key, _val);
						else
							member_set_stat(party_get_member(i), _key, _val);
					}
				});
			
			for (var i = 0; i < array_length(party_get_attribute("MEMBERS")); ++i) {
				var member = party_get_member(i)
				member_set_stat(member, "HP", min(member_get_stat(member, "HP"), member_get_stat(member, "MAX_HP")));
				member_set_stat(member, "MP", min(member_get_stat(member, "MP"), member_get_stat(member, "MAX_MP")));
			}
			
			if (struct_exists(item_s, "SPECIAL_EFFECTS"))
				item_s[$ "SPECIAL_EFFECTS"]();
				
			if (struct_exists(item_s, "SOUND"))
				sfx_play(item_s[$ "SOUND"]);
			else
				sfx_play(snd_heal);
			
			inven_remove_index(inv_index)
			break;
		
		case "KEY":
			if (struct_exists(item_s, "SPECIAL_EFFECTS") )
				item_s[$ "SPECIAL_EFFECTS"]();
			
			if struct_exists(item_s,"SOUND")
				sfx_play(item_s[$ "SOUND"]);
			break;
			
		default:
			show_debug_message("This isn't a category...");
	}
}