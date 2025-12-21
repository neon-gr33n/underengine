npc_interactable = true;

scene_info = [
	[cutscene_dialogue,"gen",spr_blank,"* Start an encounter?"],
	[cutscene_wait_for_dialogue_complete],
	[cutscene_choice,"",loc_gettext("choice.yes"),loc_gettext("choice.no"),function(){encounter_start("test","battle",1)},function(){cutscene_end()},2],
	[cutscene_wait_for_dialogue],
]