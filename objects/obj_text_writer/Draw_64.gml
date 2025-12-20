if(live_call()) return live_result;

typewriter_state = self.typist.get_state();

var is_top = __top ? false : true;

// Determine actual position based on dialoguePosition and __top
actual_position = dialoguePosition;

// If position is dynamic, check __top to decide
if (dialoguePosition == "dynamic") {
    actual_position = is_top ? "bottom" : "top";
}

// Set positions based on the actual (or determined) position
if dialogue.dialoguePortrait == spr_blank || !hasDialoguePortrait {
    dialogueXPosition = 72;
    dialogueYPosition = 350;
} else if actual_position == "top" {
    dialogueXPosition = 52;	
    dialogueYPosition = 350;	
} else if hasDialoguePortrait {
    dialogueXPosition = 200;
    dialogueYPosition = 350;	
}

if actual_position == "battle_generic" {
    dialogueXPosition = 52;	
    dialogueYPosition = 255;
}

#region UNDERTALE STYLE BOX SPECIFIC Y PARAMS
if !global.rounded_box
{
    if actual_position == "bottom"  {
        dialogueYPosition = 340;	
        dialogueXPosition = 190;
    } else {
        if (actual_position == "battle_generic"){
            dialogueYPosition = 255;	
        } else {
            dialogueYPosition = 350;	
        }
    } 
}
#endregion

#region 9SLICED SPRITE BOX + OPACITY SPECIFIC Y PARAMS
if __DRAW_9SLICE_BOX_WITH_OPACITY 
{
    if actual_position == "bottom"  {
        dialogueYPosition = 350;	
        dialogueXPosition = 72;
    } else if actual_position == "top" {
        dialogueXPosition = 72;
        dialogueYPosition = 350 - 320; // Moves it up by 320 pixels for top position
    }
}
#endregion

if actual_position == "none" {
    dialogueXPosition = x;
    dialogueYPosition = y;
}

var _dialogue_text = is_string(dialogue.dialogueText) ? dialogue.dialogueText : dialogue.dialogueText[t_c][1];
_dialogue_text = replaceInputIcons(_dialogue_text);

// Single object for normal text
var scribble_object = scribble(_dialogue_text)
    .starting_format(dialogue.dialogueFont, c_white)
    .wrap(640 - dialogueXPosition + dialogueYPosition)
    .line_spacing(global.lang_ls);
    
if visible {
    if (typist != undefined) {
        scribble_object.draw(dialogueXPosition, dialogueYPosition, typist);
    } else {
        scribble_object.draw(dialogueXPosition, dialogueYPosition);
    }
}
 
//typist.sound([dialogue.dialogueVoice],45,1,1,global.voice_volume);
typist.sound_per_char([dialogue.dialogueVoice],1,1,"  #!.,/\()",global.voice_volume);

//if keyboard_check_pressed(ord("I")) show_message(typist.get_state())

if(input.cancel_pressed){
    self.typist.skip();
    __paused = false;
}

if (input.menu){
    self.typist.skip();
    t_c++;
    __paused = false;
}