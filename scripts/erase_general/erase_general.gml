// Erase all general save data for a specific slot
// @param slot - Slot to erase (0, 1, 2)
function erase_general(slot) {
    ini_open("underengine.ini");
    
    // Remove all General-SL keys for this slot
    ini_key_delete("General-SL" + string(slot), "room");
    ini_key_delete("General-SL" + string(slot), "pX");
    ini_key_delete("General-SL" + string(slot), "pY");
    ini_key_delete("General-SL" + string(slot), "pDir");
    
    // Remove all World-SL keys for this slot
    ini_key_delete("World-SL" + string(slot), "SP");
    ini_key_delete("World-SL" + string(slot), "MN");
    ini_key_delete("World-SL" + string(slot), "SC");
    ini_key_delete("World-SL" + string(slot), "HR");
    ini_key_delete("World-SL" + string(slot), "roomname");
    
    // Optional: Also remove the entire section if you want to clean up completely
    ini_section_delete("General-SL" + string(slot));
    ini_section_delete("World-SL" + string(slot));
    
    ini_close();
    
    // Update pre-loaded arrays to reflect deletion
    global.party_names[slot] = "[EMPTY]";
    global.party_times[slot] = "--:--";
    global.party_rooms[slot] = "------------";
}