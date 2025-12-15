if (_all_text_complete) {
    // All text is done, go to menu
    audio_stop_all()
    room_goto(rm_menu);
} else if (_currentText == "") {
    // Check if we're still within array bounds
    if (_index < array_length(__text)) {
        _currentText = __text[_index];
        
        // Check if this is an empty string - if so, skip to next immediately
        if (_currentText == "") {
            _index++;
            if (_index >= array_length(__text)) {
                // All text done
                _all_text_complete = true;
                alarm[0] = 2; // Short delay before going to menu
            } else {
                alarm[0] = _duration; // Immediate next frame
            }
        } else {
            typist.in(_speed, 0);
        }
    } else {
        // We've run out of text
        _all_text_complete = true;
        alarm[0] = 2; // Short delay before going to menu
    }
} else if (typist.get_state() == 1) {
    // Typing completed - advance to next
    _index++;
    
    if (_index >= array_length(__text)) {
        // All text done
        _all_text_complete = true;
        alarm[0] = 2; // Short delay before going to menu
    } else {
        _currentText = ""; // Set to blank for next cycle
        typist = scribble_typist();
        alarm[0] = _duration;
    }
}