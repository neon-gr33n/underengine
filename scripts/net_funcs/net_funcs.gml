function network_init(){
	global.network_callback = "";
	global.network_connected = false;	
}

function network_check_status(){
	if os_is_network_connected() {
		return global.network_connected == true;	
	} else { global.network_connected = false; }
}

function network_reassign_callback(val){
	global.network_callback = val;
}

function network_gj_request_start(req_type, _username, _token) {
	var url = GJ_API_URL
	var unhashed = url + req_type + "/?game_id=" + string(global.gameid) + "&username=" + string(_username) + "&user_token=" + string(_token) + global.key
	var hashed = md5_string_utf8(unhashed);
	
	var response = http_get(url + req_type + "/?game_id=" + string(global.gameid) + "&username=" + string(_username) + "&user_token=" + string(_token) + "&signature=" + string(hashed));
		
	network_reassign_callback(req_type);
	exit;
}