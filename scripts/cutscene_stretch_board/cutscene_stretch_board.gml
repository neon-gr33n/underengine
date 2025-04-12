function cutscene_stretch_board(_board_xscale, _board_yscale, _duration, _easing="linear"){
	///@arg board_xscale
	///@arg board_yscale
	///@arg duration
	///@arg easing
	execute_tween(BOARD, "image_xscale", _board_xscale, _easing, _duration)
	execute_tween(BOARD, "image_yscale", _board_yscale, _easing, _duration)
	cutscene_end_action()
}