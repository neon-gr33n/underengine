function create_speech_bubble(_template = "wide_vertical", _font = "fnt_dotumche", _text="No text loaded!", _xx, _yy){
    ///@desc Creates a speech bubble
    
    if(!instance_exists(obj_battle_speech_bubble) || instance_count < 3){
        var bubble = instance_create_depth(_xx, _yy, -9999, obj_battle_speech_bubble,
        {
            template: _template
        })
        
        var inst = instance_create_depth(
            bubble.x + 40,
            bubble.y + 15,
            -99999, obj_text_writer_bubble)
        
        with (inst) {
            dialoguePosition = "none"
            dialogue.dialogueFont = loc_get_font(_font)
            
            // Handle multiple lines with newline separator
            if (is_string(_text)) {
                // Check if we should split (has # or newline)
                if (string_pos("\n", _text) > 0) {
                    // Split by # OR newline for multiple lines
                    // string_split_ext needs an array of delimiters
                    dialogue.dialogueText = string_split_ext(_text, ["\n"], true);
                    t_c = 0;
                    typist.reset();
                } else {
                    // Single line (no delimiters found)
                    dialogue.dialogueText = _text;
                }
            } else if (is_array(_text)) {
                // Already an array
                dialogue.dialogueText = _text;
                t_c = 0;
                typist.reset();
            } else {
                // Single line (not a string or array)
                dialogue.dialogueText = string(_text);
            }
        }
        
        // Store reference to text writer in bubble
        bubble.text_writer = inst; // store the instance directly
        
        return bubble;
    }
    
    return noone;
}