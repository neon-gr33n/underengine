function cutscene_stretch_board(_board_up, _board_down,_board_left,_board_right, _duration, _easing="linear"){
	///@arg board_up   - 
	///@arg board_down
	///@arg board_left
	///@arg board_right
	///@arg duration
	///@arg easing
	execute_tween(BOARD, "up", _board_up, _easing, _duration * game_get_speed(gamespeed_fps))
	execute_tween(BOARD, "down", _board_down, _easing, _duration * game_get_speed(gamespeed_fps))
	execute_tween(BOARD, "left", _board_left, _easing, _duration * game_get_speed(gamespeed_fps))
	execute_tween(BOARD, "right", _board_right, _easing, _duration * game_get_speed(gamespeed_fps))
	cutscene_end_action()
}