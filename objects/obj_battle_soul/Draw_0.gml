//draw_self();
///@desc Process States
if(live_call()) return live_result;
//show_message("hi")

if instance_exists(obj_battle_handler) || room == rm_soul_tester
if currentState == "inMenu" {
	if !layer_exists(layer_get_id("menuHeart")) {
		layer_create(depth,"menuHeart")
		_spritec=layer_sprite_create(layer_get_id("menuHeart"),x,y,spr_battle_soul_core)
		_sprite=layer_sprite_create(layer_get_id("menuHeart"),x,y,sprite_index)
	}
	if layer_get_depth(layer_get_id("menuHeart"))!=depth {
		layer_depth(layer_get_id("menuHeart"),depth)
	}
	_spritex=layer_sprite_get_x(_sprite)
	_spritey=layer_sprite_get_y(_sprite)
	if abs(_spritex-x)+abs(_spritey-y)!=0 {
		if instance_exists(obj_battle_handler) && obj_battle_handler.currentState=="menuBegin" {
			layer_sprite_x(_sprite,x)
			layer_sprite_y(_sprite,y)
			layer_sprite_x(_spritec,x)
			layer_sprite_y(_spritec,y)
		} else {
			_spritex+=(x-_spritex)/8
			_spritey+=(y-_spritey)/8
			//if abs(_spritex-x)<1
			//	_spritex=x
			//if abs(_spritey-y)<1
			//	_spritey=y
			layer_sprite_x(_sprite,_spritex)
			layer_sprite_y(_sprite,_spritey)
			layer_sprite_x(_spritec,_spritex)
			layer_sprite_y(_spritec,_spritey)
		}
	}
	layer_sprite_xscale(_sprite,image_xscale)
	layer_sprite_yscale(_sprite,image_xscale)
	layer_sprite_blend (_sprite,colour_change >= 0 ? colour_change : soul_type)
	layer_sprite_index (_sprite,image_index)
	layer_sprite_xscale(_spritec,image_xscale)
	layer_sprite_yscale(_spritec,image_xscale)
	layer_sprite_speed(_spritec,0)
	layer_sprite_blend (_spritec,global.EMOTION[$ global.soul_emotion][$ "COLOUR"]-(c_white-image_blend))
} else {
	if layer_exists(layer_get_id("menuHeart")) layer_destroy(layer_get_id("menuHeart"))
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale, image_yscale,image_angle,colour_change >= 0 ? colour_change : soul_type,image_alpha)
	draw_sprite_ext(spr_battle_soul_core,0,x,y,image_xscale, image_yscale,0,global.EMOTION[$ global.soul_emotion][$ "COLOUR"]-(c_white-image_blend),image_alpha)
}