if (!speech_bubble_exists()){
	_timer --;

    // End attack after duration
    if (_timer <= 0) {
        event_user(3);
    }
}