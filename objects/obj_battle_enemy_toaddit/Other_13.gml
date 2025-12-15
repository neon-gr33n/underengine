/// @description Turn Start
create_speech_bubble("wide horizontal", "fnt_dotumche",choose("Leap,#Leap.","Crrroak!","Croak!"),id.x+40,id.y-120)
if(instance_exists(obj_battle_enemy_whimsun) && !obj_battle_enemy_whimsun.spared){
	instance_create(0,0,choose(obj_bt_flies_basic,obj_bt_flies_dive,obj_bt_fly_gentle));
} else {
	instance_create(0,0,choose(obj_bt_flies_basic,obj_bt_flies_dive,obj_bt_fly_gentle,obj_bt_toad_leap));
}
