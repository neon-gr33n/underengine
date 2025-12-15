// End Step Event
if (typist.get_state() == 1) 
{
    if (input.action_pressed) {
        if (is_array(dialogue.dialogueText)) {
            // Check if there are more lines
            if (t_c + 1 < array_length(dialogue.dialogueText)) {
                // Advance to next line
                t_c++;
                typist.reset(); // Restart typing for new line
            } else {
                // No more lines - destroy everything
                instance_destroy(obj_battle_speech_bubble);
            }
        } else {
            // Not an array - single line, destroy when done
			  instance_destroy(obj_battle_speech_bubble)
        }
    }
}
