function cutscene_move_board(_board_up,_board_down,_board_left,_board_right, _angle, _duration)
{
	///@arg board_up
	///@arg board_down
	///@arg board_left
	///@arg board_right
	///@arg angle
	///@arg duration
	
	//up = 65;
	//down = 65;
	//left = 283;
	//right = 283;
	if instance_exists(BOARD) with(BOARD) { // Ensure the battle board exists before modifying it 
		TweenFire(BOARD, EaseLinear, 0, 0, 0, _duration, 
		"board_up", BOARD.x, _board_x, 
		"board_down", BOARD.x, _board_y, 
		"board_left", BOARD.board_xscale, _board_xscale,
		"board_right", BOARD.board_yscale, _board_yscale, 
		"board_angle", BOARD.board_angle, _angle
		)
	}
}