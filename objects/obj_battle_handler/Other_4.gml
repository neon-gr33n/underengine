CAM.following = noone
with(CAM){
	x=0
	y=0
	camera_set_position()
	view_zoom = 1;
	camera_set_zoom()
}
with(CAM) camera_setup(0, window_get_fullscreen(), true, 1)

mus_playx(mus_load(global.battlemus),true,0.5,0,global.battlemus_pitch,2)
encounter_create()
instance_create(0,0,obj_battle_hud);