_menu_selection=0;
_menu_item_option_selection = 0;
_menu_item_selection = 0; 
_menu_active = 0;  // 0 - HUB 1 - ITEM 2 - STAT 3 - CELL 4 - DIALOG
_activeSel = false;
currentState = "hub";


selCursorYPos = 205;
selCursorXPos = 72;

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
#endregion

state = stateMenuHub();