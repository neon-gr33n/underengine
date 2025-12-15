if(show_black){
	draw_sprite_ext(spr_px,0,0,0,640,480,0,c_black,0.6);
}
if(show_soul){
	global.danger = true;
} else {
	global.danger = false;	
}