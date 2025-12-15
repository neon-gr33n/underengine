// Handle sprite fade effect - only when advancing to next text
if (_is_fading) {
    _fade_timer++;
    var _fade_duration = 30;
    
    if (_fade_timer <= _fade_duration) {
        // Fade out
        _sprite_alpha = 1 - (_fade_timer / _fade_duration);
    } else if (_fade_timer <= _fade_duration * 2) {
        // Fade in after changing image
        _sprite_alpha = (_fade_timer - _fade_duration) / _fade_duration;
    } else {
        // Fade complete
        _is_fading = false;
        _fade_timer = 0;
        _sprite_alpha = 1;
    }
    
    // Change image exactly when we hit the fade duration (fully faded out)
    if (_fade_timer == _fade_duration) {
        _image_index = (_image_index + 1) % sprite_get_number(spr_intro);
    }
}

// Start fade only when typing completes OR when all text is done but images remain
if ((typist.get_state() == 1 && alarm[0] == -1 && !_is_fading) || 
    (_all_text_complete && !_is_fading && _image_index < sprite_get_number(spr_intro) - 1)) {
    
    _is_fading = true;
    _fade_timer = 0;
    
    // Also set the alarm to advance text (if not already set)
    if (alarm[0] == -1 && !_all_text_complete) {
        alarm[0] = 10;
    }
}

// Allow manual skip
if input.action_pressed {
    audio_stop_all()
    room_goto(rm_menu)
}