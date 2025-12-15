function copy_general(src, dst){
   ini_open("underengine.ini");
    
    // Read all data from source slot
    var saved_room = ini_read_real("General-SL" + string(src), "room", 1);
    var player_x = ini_read_real("General-SL" + string(src), "pX", 320);
    var player_y = ini_read_real("General-SL" + string(src), "pY", 320);
    var player_dir = ini_read_real("General-SL" + string(src), "pDir", 360);
    
    var ticks = ini_read_real("World-SL" + string(src), "SP", 0);
    var minutes = ini_read_real("World-SL" + string(src), "MN", 0);
    var seconds = ini_read_real("World-SL" + string(src), "SC", 0);
    var hours = ini_read_real("World-SL" + string(src), "HR", 0);
    var room_name = ini_read_string("World-SL" + string(src), "roomname", "");
    
    // Write all data to destination slot
	 ini_write_real("World-SL" + string(dst), "SP", ticks);
    ini_write_real("World-SL" + string(dst), "MN", minutes);
    ini_write_real("World-SL" + string(dst), "SC", seconds);
    ini_write_real("World-SL" + string(dst), "HR", hours);
    ini_write_string("World-SL" + string(dst), "roomname", room_name);
	
    ini_write_real("General-SL" + string(dst), "room", saved_room);
    ini_write_real("General-SL" + string(dst), "pX", player_x);
    ini_write_real("General-SL" + string(dst), "pY", player_y);
    ini_write_real("General-SL" + string(dst), "pDir", player_dir);
    
    ini_close();
}