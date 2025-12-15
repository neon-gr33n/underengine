/// @function get_current_room_name()
/// @returns {string} Current room name in current language
function get_current_room_name() {
    var room_key = global.room_data[$ "__ROOM__"][$ room_get_name(room)];
    if (room_key == undefined) return "Unknown Room";
    
    var room_info = global.room_data[$ "ROOMS"][$ room_key];
    if (room_info == undefined) return "Unknown Room";
    
    var area_key = room_info[$ "AREA"];
    
    // Handle different area types
    switch (area_key) {
        case "LUCENT_CAVERNS":
            return loc_gettext("game.location.ruins");
        case "RADIANT_GARDEN":
            return loc_gettext("game.location.ruins_city");
        case "__ENGINE__":
            return "Menu";
        case "__DEBUG__":
            return "Debug";
        case "__VOID__":
            return "Void";
        case "__GAMEJOLT_API__":
            return "Gamejolt API";
        default:
            return area_key; // Fallback
    }
}