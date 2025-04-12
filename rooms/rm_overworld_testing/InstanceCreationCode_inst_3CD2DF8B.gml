dir = "down";
persistant = true;

var choice_branch = function() // has to be defined *before* scene_info to prevent errors from occuring
{ 
	if global.soulChosen == 0 {
		create_cutscene(scene_info_branch_1)
	} else if global.soulChosen == 1 {
		create_cutscene(scene_info_branch_0)
	}
}

#region BASE SCENE, ENDS WHEN BRANCH OCCURS
scene_info = [
	[cutscene_dialogue,"sans","generic",loc_gettext("npc.sans.0"),.95,true, "dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"sans","sidel",loc_gettext("npc.sans.1"),.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"sans","wink",loc_gettext("npc.sans.2"),.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"sans","generic","* hey, bud..[delay=25]",.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_move_instance,obj_ow_npc_sans, 160, 475, false, 0.8, "left"],
	[cutscene_set_npc_dir,obj_ow_npc_sans,"down"],
	[cutscene_set_npc_idle,obj_ow_npc_sans],
	[cutscene_dialogue,"sans","generic","* do you wanna#take a break#with me?",.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_choice],	
	[cutscene_wait_for_dialogue],
	[cutscene_branch,choice_branch],
]
#endregion

scene_info_branch_0 = [
	[cutscene_dialogue,"sans","wink","* follow me!#*i know a good shortcut.",.95,true, "dynamic"],
	[cutscene_wait_for_dialogue],
]

scene_info_branch_1 = [ 
	[cutscene_dialogue,"sans","danger","* burn in hell.",.95,true, "dynamic"],
	[cutscene_wait_for_dialogue],
]

