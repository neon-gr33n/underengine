function gj_user_logged_in(){
	if global.gj_username != "" && global.gj_token != "" {
		return true;
	} else {
		return false;
	}
}