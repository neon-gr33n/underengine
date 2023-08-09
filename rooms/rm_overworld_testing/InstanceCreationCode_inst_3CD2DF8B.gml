dir = "down";
persistant = true;
scene_info = [
	[cutscene_dialogue,"fnt_sans",spr_port_sans_gen,snd_sans_v,loc_gettext("npc.sans.0"),.95,true, "dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"fnt_sans",spr_port_sans_side_l,snd_sans_v,loc_gettext("npc.sans.1"),.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"fnt_sans",spr_port_sans_wink,snd_sans_v,loc_gettext("npc.sans.2"),.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_dialogue,"fnt_main",spr_port_sans_badtime,snd_sans_v,"d o  y o u  w a n t  t o#h a v e  a  b a d  t i m e ?",.95,true,"dynamic"],
	[cutscene_wait_for_dialogue],
	[cutscene_choice],
	[cutscene_end]
]