# BGM Functions

## `mus_playx(fname, loopable, [volume], [offset], [pitch], [index])` → `undefined`
Plays the loaded BGM at a specific index with comprehensive audio controls
Only plays if the specified music slot is not already playing the requested file

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`fname` |String |Audio asset name to play |
|`loopable` |Bool |Whether the music should loop continuously |
|`[volume=global.mus_volume]` |Number |Playback volume (0-1 or 0-100 depending on system) |
|`[offset=0]` |Number |Starting position in seconds |
|`[pitch=1]` |Number |Pitch multiplier (1.0 = normal speed) |
|`[index=0]` |Number |Music slot index (0 = Overworld, 1 = Battle, 2 = Cutscene/Ambience) |
```gml
 // Play overworld theme with looping
 mus_playx(mus_load("overworld"), true, 0.8, 0, 1.0, 0);
 
 // Play battle music without looping
 mus_playx(mus_load("battle"), false, 1.0, 0, 1.0, 1);
```

## `mus_playx_on(fname, loopable, [volume], [pitch], [time], [index])` → *Number*
Plays BGM on a specific audio emitter with gradual volume/pitch changes
Uses spatial audio features for positioned sound playback

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`fname` |String |Audio asset name to play |
|`loopable` |Bool |Whether the music should loop continuously |
|`[volume=1]` |Number |Initial playback volume (0-1) |
|`[pitch=1]` |Number |Pitch multiplier (1.0 = normal speed) |
|`[time=0]` |Number |Time in seconds for volume fade-in |
|`[index=0]` |Number |Music slot index for tracking |

**Returns:** Audio instance ID of the playing sound
```gml
 // Play music on the global music emitter with fade-in
 var music_id = mus_playx_on("snd_dungeon", true, 0.7, 1.0, 2.0, 0);
 
 // Play instant battle music
 var battle_music = mus_playx_on("snd_battle_intense", false, 1.0, 1.2, 0, 1);
```

## `mus_load(fname)` → *Number <span style="color: red;"> *or* </span> Real*
Loads an external music file and creates an audio stream for playback
Searches in platform-specific music directories for OGG format files

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`fname` |String |Name of the music file (without extension) |

**Returns:** Audio stream handle if loaded successfully, -1 if file not found
```gml
 var bgm_handle = mus_load("town_theme");
 if (bgm_handle != -1) {
     audio_play_sound(bgm_handle, 0, false);
 } else {
     show_debug_message("Failed to load background music");
 }
```

## `mus_pause(streamid)` → *Bool*
Pauses playback of a music stream

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`streamid` |Number|Real |Audio stream handle to pause |

**Returns:** Returns true if successful, false if failed
```gml
 // Assuming bgm_handle is a valid audio stream
 if (mus_pause(bgm_handle)) {
     show_debug_message("Music paused successfully");
 }
```

## `mus_resume(streamid)` → *Bool*
Resumes playback of a previously paused music stream

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`streamid` |Number|Real |Audio stream handle to resume |

**Returns:** Returns true if successful, false if failed
```gml
 // Resume a paused music stream
 if (mus_resume(paused_bgm)) {
     show_debug_message("Music resumed successfully");
 } else {
     show_debug_message("Failed to resume music");
 }
```

## `mus_set_pitch(streamid, [pitch])` → *Bool*
Sets the playback pitch of a music stream

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`streamid` |Number|Real |Audio stream handle to modify |
|`[pitch=1]` |Number |Pitch multiplier (1.0 = normal speed, 0.5 = half speed, 2.0 = double speed) |

**Returns:** Returns true if successful, false if failed
```gml
 // Slow down music for dramatic effect
 if (mus_set_pitch(bgm_handle, 0.75)) {
     show_debug_message("Music pitch lowered successfully");
 }
 
 // Reset to normal speed
 mus_set_pitch(bgm_handle, 1.0);
```

## `mus_set_volume(streamid, [volume], [time], [instant])` → *Bool*
Sets the volume of a music stream with optional fade transition
Supports both instant volume changes and gradual fades over time

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`streamid` |Number|Real |Audio stream handle to modify |
|`[volume=1]` |Number |Target volume level (0-1) |
|`[time=0]` |Number |Time in seconds for volume transition (0 = instant) |
|`[instant=false]` |Bool |DEPRECATED - Use time=0 instead for instant changes |

**Returns:** Returns true if successful, false if failed
```gml
 // Instant volume change to 50%
 mus_set_volume(bgm_handle, 0.5);
 
 // Gradual fade to silence over 3 seconds
 mus_set_volume(bgm_handle, 0, 3);
 
 // Instant mute (legacy parameter style)
 mus_set_volume(bgm_handle, 0, 0, true);
```

## `mus_stop(streamid)` → `undefined`
Stops playback and destroys an audio stream, freeing its resources
Combines audio_stop_sound() and audio_destroy_stream() for convenience

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`streamid` |Number|Real |Audio stream handle to stop and destroy |
```gml
 // Stop and clean up a music stream
 mus_stop(bgm_handle);
 bgm_handle = -1; // Mark as invalid
```
