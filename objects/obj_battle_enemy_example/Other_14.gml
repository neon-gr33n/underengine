//@desc Turn End
with (obj_battle_handler){
	battleMenuSelection	= 1;
}
if (id.SPAREABLE){
		encounter_set_menu_text("* Example no longer wants to fight you.")
} else {
		encounter_set_menu_text("* Example flexes its muscles.", "* Example is... basic");
}