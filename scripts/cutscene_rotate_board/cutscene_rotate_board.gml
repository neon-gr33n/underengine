function cutscene_rotate_board( _angle, _duration)
{
	///@arg angle
	///@arg duration
	if instance_exists(BOARD) with(BOARD) { // Ensure the battle board exists before modifying it 
		TweenFire(BOARD, EaseLinear, 0, 0, 0, _duration, 
		"image_angle", BOARD.image_angle, _angle
		)
	}
}