fade_basic(1,0,30)
if (!variable_global_exists("next_shop") || global.next_shop == "") {
    // Default shop if none specified (for testing)
    global.next_shop = "DEFAULT"
}