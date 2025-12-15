//draw_self();
///@desc Process States
if !instance_exists(obj_battle_handler) {
	if abs(_spritex-x)+abs(_spritey-y)!=0 {
		_spritex+=(x-_spritex)/8
		_spritey+=(y-_spritey)/8
		//if abs(_spritex-x)<1
		//	_spritex=x
		//if abs(_spritey-y)<1
		//	_spritey=y
	}
	depth=-9999
	draw_sprite_ext(spr_battle_soul_flee,0,_spritex,_spritey,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
} 
