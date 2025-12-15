depth = -99999;

dialogue = {
	dialogueText: "",
	dialogueFont: "",
	dialogueVoice: undefined,
	dialogueSpeed: 0.55,
	dialoguePortrait: undefined
}

dialoguePosition = "dynamic";
dialogueOutline = false;
dialogueXOffset = 0;
dialogueXPosition = x//190;
dialogueYPosition  = y//260;
hasDialoguePortrait = false;
canSkip = false;
textFinished = false;
t_c=0;

selectedChoice  = 0;
typist = scribble_typist();
typist.in(dialogue.dialogueSpeed,0);

function replaceInputIcons(text) {
    var processed_text = text;
    
    var pos = string_pos("[input:", processed_text);
    while (pos > 0) {
        var search_text = string_copy(processed_text, pos, string_length(processed_text) - pos + 1);
        var end_pos = string_pos("]", search_text);
        
        if (end_pos > 0) {
            end_pos = pos + end_pos - 1;
            var marker_length = end_pos - pos + 1;
            var full_marker = string_copy(processed_text, pos, marker_length);
            var verb_name = string_copy(processed_text, pos + 7, end_pos - (pos + 7));
            
            var replacement_text = verb_name; // Default fallback
            
            show_debug_message("Processing: " + verb_name + ", Device: " + global.input_device);
            
            if (global.input_device == "gamepad") {
                // Try different binding sets for gamepad
                var binding_set = 0; // 0 - Main, 1 - Alternate
                var binding = input_binding_get(verb_name, 0, binding_set);
                show_debug_message("Gamepad binding for " + verb_name + ": " + string(binding));
                
                if (binding != -1) {
                    var input_icon = input_binding_get_icon(binding);
                    show_debug_message("Input icon: " + string(input_icon));
                    
                    if (input_icon != -1 && input_icon != noone) {
                        var sprite_name = sprite_get_name(input_icon);
                        replacement_text = "[" + sprite_name + "]";
                        show_debug_message("Sprite name: " + sprite_name);
                    } else {
                        show_debug_message("Invalid icon, falling back to text");
                        replacement_text = string(input_binding_get(verb_name, 0, binding_set));
                    }
                } else {
                    show_debug_message("No gamepad binding found, trying keyboard fallback");
                    // Fallback to keyboard binding
                    replacement_text = string(input_binding_get(verb_name, 0, 0));
                }
            } else {
                // Keyboard
                replacement_text = string(input_binding_get(verb_name, 0, 0));
            }
            
            processed_text = string_replace(processed_text, full_marker, replacement_text);
            pos = string_pos("[input:", processed_text);
        } else {
            break;
        }
    }
    
    return processed_text;
}

function get_plain_text_for_typist(_text_with_gradients) {
    var _plain_text = _text_with_gradients;
    
    // Remove all gradient tags for typist
    while (string_pos("[gradient:", _plain_text) > 0) {
        var _grad_start = string_pos("[gradient:", _plain_text);
        var _grad_end = string_pos("]", _plain_text);
        var _close_tag = string_pos("[/gradient]", _plain_text);
        
        if (_grad_end <= _grad_start || _close_tag <= _grad_end) break;
        
        var _params_str = string_copy(_plain_text, _grad_start + 10, _grad_end - _grad_start - 10);
        var _grad_text = string_copy(_plain_text, _grad_end + 1, _close_tag - _grad_end - 1);
        
        // Replace gradient tag with just the text content
        _plain_text = string_replace(_plain_text, "[gradient:" + _params_str + "]" + _grad_text + "[/gradient]", _grad_text);
    }
    
    return _plain_text;
}