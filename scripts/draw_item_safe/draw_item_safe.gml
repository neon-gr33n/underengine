// Safe item drawing function for OBJ_SHOP
function draw_item_safe(index, x, y) {
    var item = party_get_attribute("INVENTORY")[@ index];
    
    // Check if item exists and is valid
    if (item == noone) return;
    
    // Safely get cost and name with fallbacks
    var cost = item_get_attribute(item, "SELL_VALUE")
    var name = item_get_attribute(item, "NAME")
    
    if (cost == undefined || name == undefined)
        return false;
    draw_ftext_transformed(loc_get_font(fnt_main_small), _menuSellSelection == index ? c_yellow : c_white,
        x, y, string(cost) + "G" + "- " + name, 
        0, 32, 2, 2, 0, 1)
    return true;
}