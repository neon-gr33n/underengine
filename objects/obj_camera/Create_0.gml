/// @description
//camera
stanncam_init(320,180,640,360);
sprite_index=noone;
cam1 = new stanncam(x,y,global.game_w,global.game_h);
cam1.follow = noone;

cam2 = -1;

split_screen = false;

//pointer
pointer = false;
pointer_x = 0;
pointer_y = 0;

zoom_mode = 0;
zoom_text = cam1.zoom_amount

speed_mode = 1;

game_res = 2;
gui_hires = false;
gui_res = 0;

resolutions = [
{ w:400 ,  h:400 }, //1:1
{ w:500 ,  h:250 }, //2:1
{ w:320 ,  h:180 }, //16:9
{ w:640 ,  h:360 },
{ w:1280 , h:720 },
{ w:1920 , h:1080 },
{ w:2048,  h:1152},
{ w:2560 , h:1440 },
{ w:2880,  h:1620 },
{ w:3072,  h:1728 },
{ w:3840,  h:2160 },
{ w:4096,  h:2304 },
{ w:5120,  h:2880 },
{ w:6144,  h:3456},
{ w:7680,  h:4320},
{ w:8192,  h:4608}
]