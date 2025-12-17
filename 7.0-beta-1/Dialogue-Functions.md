# Dialogue Functions

## `cutscene_dialogue([_speaker], [_portrait], [_text], [_speed], [_showBox], [_boxPos], [_showCursor])` → `undefined`
Displays dialogue during a cutscene with automatic scene management
Handles character-specific fonts, voices, and dialogue box positioning

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_speaker="generic"]` |String |Character ID (gen, gen2, gen3, sans, paps, asg, or generic) |
|`[_portrait]` |Sprite |Character portrait sprite (optional, uses undefined if not provided) |
|`[_text=""]` |String |Dialogue text to display |
|`[_speed=0.6]` |Number |Text display speed (0-1, default 0.6) |
|`[_showBox=true]` |Bool |Show dialogue box (true) or floating text (false) |
|`[_boxPos="dynamic"]` |String |Position: "bottom", "top", or "dynamic" |
|`[_showCursor=true]` |Bool |Show continue cursor at end of text |
```gml
 scene_info = [
     [cutscene_dialogue, "sans", spr_port_sans_gen, "hey kid, long time, no see."],
	 [cutscene_wait_for_dialogue],
     [cutscene_wait, 60], // Wait 1 second (60 frames)
	 [cutscene_dialogue,"paps", spr_port_paps_normal, "NYEH HEH HEH!", 1.0, true, "top", false],
	 [cutscene_wait_for_dialogue],
     [cutscene_flag_set, global.flags, "met_brothers", true],
	 [cutscene_end]
 ];
 create_cutscene(scene_info);

```gml
 // Cutscene flow notes:
 // - Scene continues automatically unless cutscene_wait() is used
 // - Each dialogue can have different wait behavior
```

## `cutscene_dialogue_array(_array)` → `undefined`
[PLANNED/NOT IMPLEMENTED] Displays a sequence of dialogue lines in a cutscene
This function is not fully implemented - consider it a feature placeholder

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_array` |Array |Array of dialogue objects with speaker and text properties |
```gml
 // Planned usage - not fully implemented
 var dialogueArray = [
     {speaker: "sans", text: "hey."},
     {speaker: "paps", text: "HELLO HUMAN!"},
     {speaker: "sans", text: "don't mind him."}
 ];
 cutscene_dialogue_array(dialogueArray);
```

## `cutscene_choice([_text], [_choice0], [_choice1], [_func0], [_func1], [_text_level], [_preselected])` → `undefined`
Creates a binary choice dialog during cutscenes (Yes/No style)
Note: This function needs revision to make adding new options easier

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_text=""]` |String |Prompt text displayed above choices |
|`[_choice0="Yes"]` |String |Text for first choice option (typically "Yes") |
|`[_choice1="No"]` |String |Text for second choice option (typically "No") |
|`[_func0]` |Function |Callback function executed when first choice is selected |
|`[_func1]` |Function |Callback function executed when second choice is selected |
|`[_text_level=0]` |Number |Text display level/priority (affects rendering order) |
|`[_preselected=0]` |Number |Initially selected choice (0 = first choice, 1 = second choice) |
```gml
 // Simple Yes/No choice
 cutscene_choice("Do you want to continue?", "Yes", "No", 
     function() { show_debug_message("Player chose Yes"); },
     function() { show_debug_message("Player chose No"); });
 
```gml
 // Custom choice with preselected option
 cutscene_choice("Which path will you take?", "Left", "Right",
     function() { go_left(); },
     function() { go_right(); },
     0, 1); // Preselects "Right" (index 1)
 
```gml
 // TODO: Revise this function to support:
 // - Variable number of choices (not just binary)
 // - Easier addition of new options
 // - Better callback handling
```

## `cutscene_floating_text(_xx, _yy, _font, _color, _text, [_voice], [_dur])` → `undefined`
Creates floating text during a cutscene with automatic progression
Similar to create_floating_text() but automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_xx` |Number |X position for the floating text |
|`_yy` |Number |Y position for the floating text |
|`_font` |String |Font name to use (e.g., "fnt_main", "fnt_sans") |
|`_color` |Color |Text color constant (e.g., c_white, c_blue, c_red) |
|`_text` |String |The text content to display |
|`[_voice]` |Sound|Asset |Voice sound to play with text (optional) |
|`[_dur=300]` |Number |Duration in frames before text disappears (default 300 frames ≈ 5 seconds) |
```gml
 // Floating text at position (100, 200) with blue color
 cutscene_floating_text(100, 200, "fnt_main", c_blue, "Hello World!");
 
```gml
 // Floating text with voice sound and custom duration
 cutscene_floating_text(300, 150, "fnt_sans", c_white, "nyeh heh heh!", snd_paps_v, 500);
 
```gml
 // Damage indicator text (short duration, red color)
 cutscene_floating_text(enemy.x, enemy.y-20, "fnt_main_bt", c_red, "-50", undefined, 90);
```

## `dialogue_character_init()` → `undefined`
Initializes the global character database for dialogue system
Sets up character data with fonts, voices, names, and portrait variants
Must be called once at game start before any dialogue functions
```gml
 // Call this once at game start 

 // Call this once at game start 
 dialogue_character_init();

 dialogue_character_init();
 

 
```gml
 // To add a new character:

 // To add a new character:
 // 1. Add an entry in this function with unique character ID

 // 1. Add an entry in this function with unique character ID
 // 2. Include font, voice, name, and type properties

 // 2. Include font, voice, name, and type properties
 // 3. Add portraits object for multiple expressions if needed

 // 3. Add portraits object for multiple expressions if needed
```

## `dialogue_setup([_speaker], [_portrait], _text, [_speed], [_showBox], [_boxPos], [_wait], [_showCursor])` → `undefined`
Sets up a dialogue box with character-specific fonts, voices, and positioning
Handles both dialogue boxes and floating text with proper character styling

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_speaker="gen"]` |String |Character ID: "gen", "sans", "paps", "gen2", "gen3" |
|`[_portrait]` |Sprite |Character portrait sprite (optional) |
|`_text` |String |Dialogue text to display (required) |
|`[_speed=0.55]` |Number |Text display speed (0-1, default 0.55) |
|`[_showBox=true]` |Bool |Show dialogue box (true) or floating text (false) |
|`[_boxPos="dynamic"]` |String |Position: "bottom", "top", or "dynamic" |
|`[_wait=false]` |Bool |Wait for player input before continuing |
|`[_showCursor=true]` |Bool |Show continue cursor at end of text |
```gml
 // Basic dialogue without portrait
 dialogue_setup("gen", spr_blank, "Hello there!");
 
```gml
 // Sans dialogue with portrait and custom speed
 dialogue_setup("sans", spr_sans_portrait, "hey kid.", 0.75, true, "bottom");
```
