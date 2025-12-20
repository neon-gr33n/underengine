if(dialogue.dialoguePortrait != undefined){
	hasDialoguePortrait = true;
} else {
	hasDialoguePortrait = false;	
}

if (instance_exists(PLAYER1))
{
    // Get the current view's position and size
    var cam = view_camera[0]; // Assuming view 0
    var view_y = camera_get_view_y(cam);
    var view_height = camera_get_view_height(cam);
    
    // Check if player is in top part of screen (e.g., top third)
    var screen_relative_y = PLAYER1.y - view_y;
    __top = (screen_relative_y < view_height * 0.33); // Top third of screen
}

_scene=instance_exists(obj_cutscene_handler) ? obj_cutscene_handler.scene : noone;

if is_string(actual_position){
	show_debug_message("Writer is in pos: " + actual_position)
}
//if is_array(dialogue.dialogueText) && dialogue.dialogueText[t_c][1]=="" && t_c<array_length(dialogue.dialogueText)-1 {
//	t_c++;
//}
