/// @description Turn Start
if _terrorized {
	create_speech_bubble("wide horizontal", "fnt_dotumche",loc_gettext("enemy.whimsun.sb.terrorize"),id.x+40,id.y-120)	
} else {
	create_speech_bubble("wide horizontal", "fnt_dotumche",choose(loc_gettext("enemy.whimsun.sb.0"),loc_gettext("enemy.whimsun.sb.1"),loc_gettext("enemy.whimsun.sb.2")),id.x+40,id.y-120)	
}

instance_create(0,0,obj_bt_butterfly_circle);
