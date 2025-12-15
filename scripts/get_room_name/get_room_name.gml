///@desc Fetches the name for the current room
///@arg room_index
function get_room_name(){
	var _room = argument[0];
	var name = "";
	
	_room = global.room_data[$ "ROOMS"][$ global.room_data[$ "__ROOM__"][$ room_get_name(_room)]]
	
	//format: "area - name"
	name=global.room_data[$ "AREAS"][$ _room[$ "AREA"]][$ "NAME"]+" - "+_room[$ "NAME"]
	
	return name;
}