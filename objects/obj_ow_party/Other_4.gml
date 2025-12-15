with(CAM){
	following = PLAYER1;	
	x = PLAYER1.x 
	y = PLAYER1.y;
	camera_state = cameraStates.FOLLOW;
}

if (global.ploaded == 1){
	ini_open("underengine.ini");
	x						= ini_read_real("General-SL"+string(global.filechoice),"pX",320)
	y						= ini_read_real("General-SL"+string(global.filechoice),"pY",320)
	direction		= ini_read_real("General-SL"+string(global.filechoice),"pDir",90);
	ini_close();
	global.ploaded=0;
}

if(room != rm_shop){
	flag_set(global.flags,"rm_r",room)
}