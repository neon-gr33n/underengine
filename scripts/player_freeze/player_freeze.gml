function player_freeze(){
	if player_exists() with (PLAYER1) {
		PLAYER1.state = stateCutsceneStasis() // Puts the player into a 'Cutscene Stasis' disallowing movement inputs
	}
}