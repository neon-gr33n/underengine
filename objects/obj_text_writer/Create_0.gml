depth = -99999;

dialogue = {
	dialogueText: "",
	dialogueFont: "",
	dialogueVoice: undefined,
	dialogueSpeed: 0.55,
	dialoguePortrait: undefined
}

__top = false;

dialoguePosition = "dynamic";
actual_position = undefined;
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
typist.in(dialogue.dialogueSpeed * global.__delta_stepFactor,0);

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
            
            var replacement_text = verb_name;
            
            // Hardcoded keyboard mappings for common actions
            if (global.input_device == "gamepad") {
                // Gamepad logic (same as before)
                var binding = input_binding_get(verb_name, 0, 0);
                if (binding != -1) {
                    var input_icon = input_binding_get_icon(binding);
                    if (input_icon != -1 && input_icon != noone) {
                        replacement_text = "[" + sprite_get_name(input_icon) + "]";
                    } else {
                        replacement_text = string(binding);
                    }
                } else {
                    // Fallback to hardcoded keyboard keys
                    replacement_text = getHardcodedKey(verb_name);
                }
            } else {
                // For touch/keyboard: use hardcoded keyboard keys
                replacement_text = getHardcodedKey(verb_name);
            }
            
            processed_text = string_replace(processed_text, full_marker, replacement_text);
            pos = string_pos("[input:", processed_text);
        } else {
            break;
        }
    }
    
    return processed_text;
}

function getHardcodedKey(verb_name) {
    // Map common verb names to keyboard keys
    switch (verb_name) {
        case "action":
            return "Z";
        case "cancel":
            return "X";
        case "menu":
            return "C";
        default:
            return "Key";
    }
}