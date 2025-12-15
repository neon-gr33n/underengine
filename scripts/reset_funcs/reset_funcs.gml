/// @function reset_party_progress()
/// Resets all party stats and progress but preserves character names
function reset_party_progress() {
    // Reset party stats
    party_set_stat("KILLS", 0);
    party_set_stat("DEATHS", 0);
    party_set_stat("SPARES", 0);
    party_set_stat("GOLD", 0);
    
    // Reset inventory to starting items
    party_set_attribute("INVENTORY", ["BLUNT_AXE", "BROKEN_LOCKET"]);
    party_set_attribute("STORAGE", []);
    
    // Reset party to just CHARA
    party_abandon("FRISK");
    
    // Reset all members' stats
    var members = party_get_attribute("MEMBERS");
    for (var i = 0; i < array_length(members); i++) {
        var member = members[i];
        
        // Keep the name (it's already set)
        
        // Reset stats to defaults
        member_set_stat(member, "EXP", 0);
        member_set_stat(member, "LV", 1);
        member_set_stat(member, "HP", 20);
        member_set_stat(member, "MAX_HP", 20);
        member_set_stat(member, "ATK", 0);
        member_set_stat(member, "TEMP_ATK", 0);
        member_set_stat(member, "TEMP_DEF", 0);
        member_set_stat(member, "DEF", 0);
        member_set_stat(member, "MP", 0);
        member_set_stat(member, "MAX_MP", 20);
		
        // Set default equipment based on member
        if (member == "FRISK") {
            member_set_stat(member, "WEAPON", "BLUNT_AXE");
        } else {
            member_set_stat(member, "WEAPON", "NO_WEAPON");
        }
        member_set_stat(member, "ARMOUR", "NO_ARMOUR");
    }
    
    // Ensure CHARA has starting equipment
    if (party_get_index("FRISK") >= 0) {
        member_set_stat("FRISK", "WEAPON", "BLUNT_AXE");
    }
}

/// @function perform_game_reset(slot)
/// Main reset function using helper functions
function perform_game_reset(slot) {
    show_debug_message("=== Starting reset for slot " + string(slot) + " ===");
    
    // Step 1: Load existing persistent data FIRST
    var loaded = persist_load(false); // false = don't goto gamebroke on error
    
    if (!loaded) {
        // If persist_load failed, initialize fresh persistent data
        show_debug_message("persist_load failed, initializing fresh persistent data");
        flags_init(true); // This creates global.pflags
    }
    
    // Step 2: Get current reset count and increment it
    var current_resets = 0;
    if (ds_map_exists(global.pflags, "resets")) {
        current_resets = ds_map_find_value(global.pflags, "resets");
    }
    
    show_debug_message("Current resets: " + string(current_resets));
    
    // Increment the reset counter
    var new_reset_count = current_resets + 1;
    ds_map_set(global.pflags, "resets", new_reset_count);
    ds_map_set(global.pflags, "last_reset_slot", slot);
    
    // Save the updated persistent data
    persist_save();
    show_debug_message("Updated resets to: " + string(new_reset_count));
    
    // Step 3: Reset INI data
    show_debug_message("Resetting INI data for slot " + string(slot));
    ini_open("underengine.ini");
    
    var starting_room = rm_fallen;
    ini_write_real("General-SL" + string(slot), "room", starting_room);
    ini_write_real("General-SL" + string(slot), "pX", 0);
    ini_write_real("General-SL" + string(slot), "pY", 0);
    ini_write_real("General-SL" + string(slot), "pDir", 0);
    
    ini_write_real("World-SL" + string(slot), "SP", 0);
    ini_write_real("World-SL" + string(slot), "MN", 0);
    ini_write_real("World-SL" + string(slot), "SC", 0);
    ini_write_real("World-SL" + string(slot), "HR", 0);
    ini_write_string("World-SL" + string(slot), "roomname", get_room_name(starting_room));
    
    ini_close();
    
    // Step 4: Load existing save to preserve character name
    var old_chara_name = "Frisk";
    if (file_exists("PARTYINFO" + string(slot))) {
        try {
            var partyBuff = buffer_load("PARTYINFO" + string(slot));
            var partyJson = buffer_read(partyBuff, buffer_text);
            buffer_delete(partyBuff);
            var old_party = json_parse(partyJson);
            
            // Try to get the character name
            if (variable_struct_exists(old_party, "FRISK") && 
                variable_struct_exists(old_party.FRISK, "NAME")) {
                old_chara_name = old_party.FRISK.NAME;
            } else if (variable_struct_exists(old_party, "__PARTY__") && 
                      variable_struct_exists(old_party.__PARTY__, "NAME") &&
                      old_party.__PARTY__.NAME != "NULL") {
                old_chara_name = old_party.__PARTY__.NAME;
            }
        } catch(e) {
            show_debug_message("Error loading old PARTYINFO: " + string(e));
        }
    }
    
    show_debug_message("Preserving character name: " + old_chara_name);
    
    // Step 5: Set up fresh game state
    var old_filechoice = global.filechoice;
    global.filechoice = slot;
    
    // Initialize game flags (not persistent flags)
    flags_init(true); // This resets global.flags
    
    // Set game state
    global.currentroom = starting_room;
    global.time = 0;
    global.currentarea = 0;
    
    // Step 6: Create fresh PARTY_INFO
    global.PARTY_INFO = {
        __PARTY__ : {
            NAME : old_chara_name != "Chara" ? old_chara_name : "NULL",
            MEMBERS : ["CHARA"],
            MAXPARTYSIZE : 4,
            STATS : { KILLS: 0, GOLD: 0, DEATHS: 0, SPARES: 0 },
            INVENTORY : ["BLUNT_AXE", "BROKEN_LOCKET"],
            MAXINVSIZE : 8,
            MAXSTORAGESIZE : 21,
            STORAGE : [],
        },
        CHARA : {
            NAME : old_chara_name,
            RACE: "Human",
            SPRITES : {
                IDLE : spr_frisk_idle,
                MOVE : spr_frisk_move,
                RUN: spr_frisk_move,
            },
            STATS : {
                EXP : 0, LV : 1, HP : 20, MAX_HP : 20,
                ATK : 0, TEMP_ATK : 0, TEMP_DEF : 0, DEF : 0,
                MP: 0, MAX_MP : 20, WEAPON : "STICK",
                ARMOUR : "NO_ARMOUR", 
            },
            DESCRIPTION : "It's you!"
        },
        PLACEHOLDER : {
            NAME : "PLACEHOLDER",
            RACE : "Monster",
            SPRITES : {
                IDLE : spr_PLACEHOLDER_idle,
                MOVE : spr_PLACEHOLDER_move,
                RUN: spr_PLACEHOLDER_move,
            },
            STATS : {
                EXP : 0,
                LV : 1,
                HP : 20,
                MAX_HP : 20,
                ATK : 0,
                TEMP_ATK : 0,
                TEMP_DEF : 0,
                DEF : 0,
                MP: 0,
                WEAPON : "NO_WEAPON",
                ARMOUR : "NO_ARMOUR",
            },
            DESCRIPTION : "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Maecenas non semper\nnulla.",
        }
    };
    
    // Step 7: Use helper function to ensure proper reset
    reset_party_progress();
    
    // Step 8: Save the reset game
    show_debug_message("Saving reset game...");
    savegame(slot); // Use the slot directly, not global.filechoice
    
    // Restore original filechoice if needed
    global.filechoice = old_filechoice;
    
    // Step 9: Go to naming room
    show_debug_message("Reset complete! Going to naming room.");
    room_goto(rm_naming);

    return true;
}