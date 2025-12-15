// Ran inside of savegame()
// Saves all data necessary for loading the game and displaying as strings to an ini file
// Does not take any arguments
function save_general(slot){
	var savroom;
	ini_open("underengine.ini");
	savroom=global.currentroom;
	global.loadroom=savroom;
	ini_write_real("General-SL"+string(global.filechoice),"room",savroom);
	ini_write_real("General-SL"+string(global.filechoice),"pX",PLAYER1.x);
	ini_write_real("General-SL"+string(global.filechoice),"pY",PLAYER1.y);
	ini_write_real("General-SL"+string(global.filechoice),"pDir",PLAYER1.direction);
	ini_write_real("World-SL"+string(global.filechoice),"SP",obj_game_handler.ticks)	
	ini_write_real("World-SL"+string(global.filechoice),"MN",global.timeMinutesPrevious)
	ini_write_real("World-SL"+string(global.filechoice),"SC", global.timeSecondsPrevious)
	ini_write_real("World-SL"+string(global.filechoice),"HR", global.timeHoursPrevious)
	savroom=global.currentroom;
	ini_write_string("World-SL"+string(global.filechoice),"roomname",get_room_name(savroom));
	ini_close();	


}	