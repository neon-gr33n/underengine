# Other Functions

## `cutscene_wait(seconds)` → `undefined`
Pauses cutscene progression for a specified time
Uses frame-based timer to wait before advancing to next cutscene action

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`seconds` |Number |Time to wait in seconds (converted to frames internally) |











## `cutscene_wait_for_dialogue()` → `undefined`
Pauses cutscene progression until current dialogue typing completes
Waits for text writer to finish displaying text before advancing cutscene
Checks both that dialogue text is empty AND typist is in finished state

## `cutscene_run_code(func, [...args])` → `undefined`
Executes arbitrary code during a cutscene with support for arguments
Flexible function that can run any script or function as part of cutscene sequence

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`func` |Function |Function to execute (script name or function reference) |
|`args` |...Any |Variable number of arguments to pass to the function |
```gml
 // Execute a simple function without arguments
 cutscene_run_code(function() {
     show_debug_message("Cutscene code executed!");
 });
```

## `cutscene_item_add(item, [quantity], [overflow])` → `undefined`
Adds an item to inventory during a cutscene
Wrapper for inven_add_item() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`item` |Asset|String |Item to add (item asset ID or name) |
|`[quantity=1]` |Number |Number of items to add (default 1) |
|`[overflow=true]` |Bool |Allow inventory overflow beyond capacity (default true) |






## `cutscene_play_sound(soundid, [priority], [loops], [gain])` → `undefined`
Plays a sound effect during a cutscene
Wrapper for audio_play_sound() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |Sound|Asset |Sound asset to play (e.g., snd_door_open, snd_click) |
|`[priority=0]` |Number |Audio priority (0 = normal, higher = more important) |
|`[loops=false]` |Bool |Whether sound should loop continuously |
|`[gain=1.0]` |Number |Volume/gain level (0.0 = silent, 1.0 = full volume) |







## `cutscene_stop_sound(soundid)` → `undefined`
Stops a currently playing sound during a cutscene
Wrapper for audio_stop_sound() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |Sound|Asset |Sound asset to stop (must be currently playing) |







## `cutscene_start_encounter(encounter, mus_id, mus_pitch, exclaim, quick, boss)` → `undefined`
Starts a battle encounter during a cutscene
Wrapper for encounter_start() that automatically advances cutscene

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`encounter` |String |Encounter identifier or name (e.g., "test") |
|`mus_id` |String |Music track ID to play during encounter |
|`mus_pitch` |Number |Music pitch multiplier (1.0 = normal speed) |
|`exclaim` |Bool |Show exclamation mark "!" animation before encounter starts |
|`quick` |Bool |Use quick transition (skips some animations for faster start) |
|`boss` |Bool |Whether this is a boss encounter ( |




