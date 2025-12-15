
//#region PROCESS MENU VISUAL EVENTS
if abs(tweened)>=6
	tweened=(sign(tweened)*(tweened-(sign(tweened)*6))%360)*sign(tweened)
else
	tweened=0
with obj_text_writer { visible = true } // temporarily re-enable the writer
_cx=320
_cy=410
_mar=100
_mir=20

if(global.debug){
    if(keyboard_check_pressed(vk_subtract)){    
        if(instance_exists(obj_bt)){
            with(obj_bt){
                event_user(3);
            }
        }
    }
}

	//draw_sprite_ext(spr_battle_soul_core,0,_cx+ sin((i)*180/pi)*_mar,_cy+ cos((i)*180/pi)*_mir,0.5,0.5,0,c_white,1)
for (i=0;i<5;i++) {
	temped=((i)*72-tweened)/180*pi
	if layer_exists(layer_get_id(string(i))) layer_destroy(layer_get_id(string(i)))
	_layer=layer_create(-1000-cos(temped)*100,string(i))
	_sprited=layer_sprite_create(layer_get_id(string(i)),_cx+sin(temped)*_mar,_cy+cos(temped)*_mir,global.loc_sprites[$ "battle_bt"])
	_cool_depth_thing=power(abs(layer_sprite_get_y(_sprited)/(_cy+10)),10)
	layer_sprite_xscale(_sprited,1*_cool_depth_thing)
	layer_sprite_yscale(_sprited,1*_cool_depth_thing)
	layer_sprite_blend(_sprited,make_color_hsv(0,0,255*_cool_depth_thing))
	layer_sprite_index(_sprited,(i+battleMenuSelection)*2%10+(i == 0 ? 1 : 0))
	if i == 0 && HEART.currentState == "inMenu" {
		HEART.image_xscale=1*_cool_depth_thing
		HEART.image_yscale=1*_cool_depth_thing
		HEART.x=_cx+sin(temped)*_mar-36*HEART.image_xscale
		HEART.y=_cy+cos(temped)*_mir
		HEART.depth=-1000-cos(temped)*100-1
		HEART.image_blend=make_color_hsv(0,0,255*_cool_depth_thing)
	}
}
	
	