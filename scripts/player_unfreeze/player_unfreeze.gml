function player_unfreeze(){
	if player_exists() with (PLAYER1) {
		PLAYER1.state = statePlayerMoveGeneric() // 'Unfreezes' the player from Cutscene Stasis, re-enabling inputs
	}
}