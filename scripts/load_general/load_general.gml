// Load all relevant game data for display using an ini file
function load_general(){
	var loadedroom; 
	if(file_exists("underengine.ini"))
	{
		ini_open("underengine.ini");
		loadedroom							= ini_read_real("General-SL"+string(global.filechoice),"room",1);
		PLAYER1.x									= ini_read_real("General-SL"+string(global.filechoice),"pX",320)
		PLAYER1.y									= ini_read_real("General-SL"+string(global.filechoice),"pY",320)
		PLAYER1.direction								= ini_read_real("General-SL"+string(global.filechoice),"pDir",360)
		obj_game_handler.ticks			= ini_read_real("World-SL0","SP",0)
		obj_game_handler.minutes	 =ini_read_real("World-SL0","MN",0)
		obj_game_handler.seconds    =ini_read_real("World-SL0","SC",0)
		ini_close();
		room_goto(loadedroom);
	}
}