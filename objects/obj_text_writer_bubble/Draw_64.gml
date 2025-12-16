if(live_call()) return live_result;
typewriter_state = self.typist.get_state();
if dialogue.dialoguePortrait == spr_blank || !hasDialoguePortrait {
	dialogueXPosition = 72;
	dialogueYPosition = 350;
} else if dialoguePosition == "top"{
	dialogueXPosition = 180;	
} else if hasDialoguePortrait {
	dialogueXPosition = 200;
	dialogueYPosition = 350;	
} 

if dialoguePosition ==  "battle_generic" {
		dialogueXPosition = 52;	
		dialogueYPosition = 255;
}

#region UNDERTALE STYLE BOX SPECIFIC Y PARAMS
if !global.rounded_box
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 340;	
		dialogueXPosition = 190;
	} else {
		dialogueYPosition = 350;	
	} 
}
#endregion

#region 9SLICED SPRITE BOX + OPACITY SPECIFIC Y PARAMS
if __DRAW_9SLICE_BOX_WITH_OPACITY 
{
	if dialoguePosition == "bottom"  {
		dialogueYPosition = 350;	
		dialogueXPosition = 190;
	} else if dialoguePosition == "top" {
		dialogueXPosition = 190;
		dialogueYPosition = 350;	
	}
}
#endregion

if dialoguePosition ==  "none" {
		dialogueXPosition = x;
		dialogueYPosition = y;
}

var _dialogue_text = "";
if (is_string(dialogue.dialogueText)) {
    _dialogue_text = dialogue.dialogueText;
} else if (is_array(dialogue.dialogueText)) {
    // Check if t_c is within bounds
    if (t_c < array_length(dialogue.dialogueText)) {
        // Get the current line - it might be a string or an array
        var current_line = dialogue.dialogueText[t_c];
        
        // Check if it's an array with [1] index (like ["font", "text"])
        if (is_array(current_line) && array_length(current_line) > 1) {
            _dialogue_text = current_line[1];
        } else {
            // It's just a string
            _dialogue_text = current_line;
        }
    } else {
        // t_c out of bounds - use first line or empty
        _dialogue_text = array_length(dialogue.dialogueText) > 0 ? 
                        dialogue.dialogueText[0] : "";
    }
} else {
    _dialogue_text = string(dialogue.dialogueText);
}

_dialogue_text = replaceInputIcons(_dialogue_text);

var scribble_object = scribble(_dialogue_text)
        .starting_format(dialogue.dialogueFont, c_black)
        .wrap(640 - dialogueXPosition + dialogueYPosition)
        .line_spacing(global.lang_ls);
	
if visible
scribble_object.draw(dialogueXPosition,dialogueYPosition,typist);
 
//typist.sound([dialogue.dialogueVoice],45,1,1,global.voice_volume);

// FIXED: Removed comma from the character triggers
typist.sound_per_char([dialogue.dialogueVoice],1,1,"  #!,./\()",global.voice_volume);

//if keyboard_check_pressed(ord("I")) show_message(typist.get_state())

if(input.cancel_pressed){
	self.typist.skip();
	__paused = false;
}