function cutscene_move_board(_board_x,_board_y,_board_xscale,_board_yscale, _angle, _duration)
{
	///@arg board_x
	///@arg board_y
	///@arg board_xscale
	///@arg board_yscale
	///@arg angle
	///@arg duration
	if instance_exists(BOARD) with(BOARD) { // Ensure the battle board exists before modifying it 
		TweenFire(BOARD, EaseLinear, 0, 0, 0, _duration, 
		"board_x", BOARD.board_x, _board_x, 
		"board_y", BOARD.board_y, _board_y, 
		"board_xscale", BOARD.board_xscale, _board_xscale,
		"board_yscale", BOARD.board_yscale, _board_yscale, 
		"board_angle", BOARD.board_angle, _angle
		)
	}
}