// Safe item drawing function for OBJ_SHOP
function draw_item_safe(index, x, y) {
    var inven = party_get_attribute("INVENTORY");
    
    // Check if index is valid
    if (index >= array_length(inven)) return false;
    
    var item = inven[@ index];
    
    // Check if item exists and is valid
    if (item == noone) return false;
    
    // Skip KEY items entirely
    if (item_get_category(item) == "KEY") return false;
    
    // Safely get cost and name with fallbacks
    var cost = item_get_attribute(item, "SELL_VALUE");
    var name = item_get_attribute(item, "NAME");
    
    if (cost == undefined || name == undefined)
        return false;
        
    draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSellSelection == index ? c_yellow : c_white,
        x, y, string(cost) + "G" + "- " + name, 
        32, 240, 2, 2, 0, 1);
    return true;
}