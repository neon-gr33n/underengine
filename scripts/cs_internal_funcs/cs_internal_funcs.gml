/// @category Cutscenes
/// @title Internal Functions

/// @func create_cutscene()
/// @desc Creates and starts a cutscene using the provided scene information array
/// @desc Instantiates obj_cutscene_handler and initializes it with scene data
/// @param {Array} scene_info Array containing cutscene sequence data and actions
/// @return {Instance} Instance ID of the created cutscene handler object
/// @example
/// // Create a simple cutscene with dialogue
/// scene_info = [
///     [cutscene_dialogue, "sans", spr_sans_portrait, "hey kid."],
///     [cutscene_dialogue, "paps", spr_paps_portrait, "NYEH HEH HEH!"],
///     [cutscene_wait, 60], // Wait 1 second (60 frames)
///     [cutscene_flag_set, global.flags, "met_brothers", true]
/// ];
/// create_cutscene(scene_info);
/// 
/// @example
/// // Create a choice-based cutscene
///  scene_info = [
///     [cutscene_dialogue, "sans", undefined, "want some help?"],
///     [cutscene_choice, "Accept help?", "Sure", "Nah",
///         function() { show_debug_message("Help accepted"); },
///         function() { show_debug_message("Help declined"); }]
/// ];
/// create_cutscene(scene_info);
function create_cutscene(){
    var inst = instance_create_layer(0, 0, "Instances", obj_cutscene_handler);
    
    with(inst) {
        scene_info = argument0;
        // PLAYER.cutscene_paused = true; // Commented out in original
        event_perform(ev_other, ev_user0);
    }
	
	if instance_exists(obj_cmenu){
		if instance_exists(WRITER) {
			instance_destroy()
		}
		instance_destroy()	
	}
    
    return inst;
}
	
/// @func create_cutscene_passive(scene_info)
/// @desc Creates and starts a passive cutscene that doesn't pause gameplay
/// @desc Instantiates obj_cutscene_handler_passive for non-blocking cutscene sequences
/// @param {Array} scene_info Array containing passive cutscene sequence data and actions
/// @return {Instance} Instance ID of the created passive cutscene handler
function create_cutscene_passive(){
    /// @arg scene_info
    
    var inst = instance_create_layer(0, 0, "Instances", obj_cutscene_handler_passive);
    
    with(inst) {
        scene_info = argument0;
        event_perform(ev_other, ev_user0);
    }
    
    return inst;
}
	
/// @func cutscene_end()
/// @desc Ends all active cutscenes and restores normal gameplay state
/// @desc Cleans up cutscene handlers, unfreezes player, and resets interaction state
function cutscene_end() {
    global._interact = noone;
    
    if (instance_exists(PLAYER1)) {
        player_unfreeze();
        PLAYER1.image_speed = 1;
        PLAYER1.dir = "undefined";
    }
    
    instance_destroy(obj_cutscene_handler);
    instance_destroy(obj_cutscene_handler_passive);
}
	
/// @func cutscene_end_action()
/// @desc Ends the current action
function cutscene_end_action() {
	scene++;
	if (scene > array_length(scene_info)-1) {instance_destroy(); exit;}
	
	event_perform(ev_other, ev_user0);
}

