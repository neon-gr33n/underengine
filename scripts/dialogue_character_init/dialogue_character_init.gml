function dialogue_character_init() {
	global.generic = {
		font: "fnt_main_small",
		voice: snd_soft_v
	}
	global.generic2 = {
		font: "fnt_main_small",
		voice: snd_writer_v
	}
	#region Sans Portraits
	global._sans_ports = ds_map_create()
	ds_map_add(global._sans_ports,"generic",spr_port_sans_gen)
	ds_map_add(global._sans_ports,"sass",spr_port_sans_sass)
	ds_map_add(global._sans_ports,"chuckle",spr_port_sans_chuckle)
	ds_map_add(global._sans_ports,"sidel",spr_port_sans_side_l)
	ds_map_add(global._sans_ports,"closed",spr_port_sans_closed_eyes)
	ds_map_add(global._sans_ports,"wink",spr_port_sans_wink)
	ds_map_add(global._sans_ports,"danger",spr_port_sans_badtime)
	
	global.sans = {
		font: "fnt_sans",
		voice: snd_sans_v,
		portrait: "generic",		
	}
	#endregion
}