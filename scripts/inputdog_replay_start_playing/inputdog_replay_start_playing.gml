function inputdog_replay_start_playing() {
	inputdog_replay_file_load();
	replayFrame = 0;
	replayMode = "play";
	show_debug_message("started "+replayFilename+" playback");



}
