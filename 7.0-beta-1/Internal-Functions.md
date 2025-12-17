# Internal Functions

## `create_cutscene()` → *Instance*
Creates and starts a cutscene using the provided scene information array
Instantiates obj_cutscene_handler and initializes it with scene data

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`scene_info` |Array |Array containing cutscene sequence data and actions |

**Returns:** Instance ID of the created cutscene handler object
```gml
 // Create a simple cutscene with dialogue
 scene_info = [
     [cutscene_dialogue, "sans", spr_sans_portrait, "hey kid."],
     [cutscene_dialogue, "paps", spr_paps_portrait, "NYEH HEH HEH!"],
     [cutscene_wait, 60], // Wait 1 second (60 frames)
     [cutscene_flag_set, global.flags, "met_brothers", true]
 ];
 create_cutscene(scene_info);
 
```gml
 // Create a choice-based cutscene
  scene_info = [
     [cutscene_dialogue, "sans", undefined, "want some help?"],
     [cutscene_choice, "Accept help?", "Sure", "Nah",
         function() { show_debug_message("Help accepted"); },
         function() { show_debug_message("Help declined"); }]
 ];
 create_cutscene(scene_info);
```

## `create_cutscene_passive(scene_info)` → *Instance*
Creates and starts a passive cutscene that doesn't pause gameplay
Instantiates obj_cutscene_handler_passive for non-blocking cutscene sequences

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`scene_info` |Array |Array containing passive cutscene sequence data and actions |

**Returns:** Instance ID of the created passive cutscene handler

## `cutscene_end()` → `undefined`
Ends all active cutscenes and restores normal gameplay state
Cleans up cutscene handlers, unfreezes player, and resets interaction state

## `cutscene_end_action()` → `undefined`
Ends the current action
