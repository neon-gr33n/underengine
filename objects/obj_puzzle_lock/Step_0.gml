if (active_and_enabled){
	if (!is_solved && puzzle_code != "" && current_input == puzzle_code) {
	    puzzle_solve();
	}

	// Auto-reset if input gets too long or wrong
	if (string_length(current_input) >= 3 && current_input != puzzle_code) {
		// Wait a moment then reset
	    if (alarm[0] == -1) alarm[0] = 60; // 1 second delay
	}

	if (keyboard_check_pressed(vk_scrollock)) {
	    puzzle_reset();
	}
} else {
	// eat my shorts!
}	
