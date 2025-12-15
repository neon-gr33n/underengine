_menu_selection=0;
// Items
_menu_item_option_selection = 0;
_menu_item_selection = 0; 
_menu_item_section = 0; // 0 - CONSUMABLE  1 - WEAPON - 2 -  ARMORS  3 - KEY ITEMS 
// Contacts
_menu_contact_selection = 0;
_menu_contact_choice_selection = 0;
_menu_active = 0;  // 0 - HUB 1 - ITEM 2 - STAT 3 - CELL 4 - DIALOG
_menu_option_available = 3;

activeSection = "ALL";
_activeSel = false;
currentState = "hub";
__invmain = noone;
__invwep = noone;
__invarm = noone;
__invkey = noone;
__info = noone;

_invmax = 12;
_item_index=0;
_action_selction=0;

_invmain="";

use_text = "";

__stat = noone;
__stat2 = noone;

_contactcount=0;
_contact_index = 0;
__contacts = noone;
__contacts_call_choices = noone;

_contacts = global.CONTACTS[$ "__CONTACTS__"][$ "CONTACTS"]

selCursorYPos = 205;
selCursorXPos = 72;

flag="casg_hello"
flag_func="increment"

#region DEFINE DEFAULT STATE
stateMenuHub = function() {
	currentState = "hub";
	_menu_active = 0;
	_activeSel = false;
}
#endregion

#region DEFINE ITEM MENU STATES
stateMenuItemOpened = function() {
	currentState = "itemOpened";
	_menu_active = 1;
	_menu_item_selection=0;
}

stateMenuItemSelection = function() {
	currentState = "itemChoosing";
}

stateMenuItemUse = function() {
	currentState = "itemUse";
	_menu_active = 4;
}

stateMenuItemDrop = function() {
	currentState = "itemDrop";
	_menu_active = 4;
}

stateMenuItemEquip = function() {
	currentState = "itemEquip";
	_menu_active = 4;
}
#endregion

#region DEFINE STAT MENU STATE
stateMenuStat = function() {
	currentState = "viewStat"
	_menu_active =  2;
}
#endregion

#region DEFINE CELL PHONE STATES
stateMenuCell = function() {
	currentState = "viewContacts"
	_menu_active =  3;
}

stateMenuCellCalling = function() {
	currentState = "dialContact"
	_menu_active =  4;
}

stateMenuCellInCall = function() {
	currentState = "onPhone"
}

function get_cutscene_data_safe() {
    if (_menu_contact_selection < array_length(_contacts)) {
        var contact_name = _contacts[_menu_contact_selection];
        var contact = global.CONTACTS[$ contact_name];
        
        show_debug_message("Contact: " + contact_name);
        
        if (is_struct(contact) && variable_struct_exists(contact, "CHOICE_SCENES")) {
            var choice_scenes = contact.CHOICE_SCENES;
            var scene_keys = struct_get_names(choice_scenes);
            
            // If the struct has a CHOICE_KEYS array, use that for ordering
            if (variable_struct_exists(contact, "CHOICE_KEYS")) {
                var ordered_keys = contact.CHOICE_KEYS;
                var selected_key = ordered_keys[_menu_contact_choice_selection];
            } 
            // Otherwise, fall back to alphabetical sorting
            else {
                scene_keys = array_sort(scene_keys, false);
                var selected_key = scene_keys[_menu_contact_choice_selection];
            }
            
            show_debug_message("Selected key: " + selected_key);
            show_debug_message("Choice selection: " + string(_menu_contact_choice_selection));
            
            if (variable_struct_exists(choice_scenes, selected_key)) {
                var result = choice_scenes[$ selected_key];
                show_debug_message("Result type: " + typeof(result));
                return result;
            }
        }
    }
    return undefined;
}
#endregion


stateMenuHub();

player_freeze()