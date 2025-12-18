# SFX Functions

## `sfx_gain(soundid, level, [time])` → *number*
Gradually increases the volume of a sound effect over time.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to adjust |
|`level` |number |Target volume level (0.0 to 1.0) |
|`[time=0]` |number |Fade duration in frames/milliseconds |

**Returns:** Returns the result of audio_sound_gain

## `sfx_get_pitch(soundid)` → *number*
Gets the current pitch of a sound.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to check |

**Returns:** Current pitch value

## `sfx_pan(soundid, priority, loop, pan)` → *number*
Positions a sound in the stereo field (left/right panning).

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to play with panning |
|`priority` |number |Playback priority |
|`loop` |boolean |Whether to loop the sound |
|`pan` |number |Pan position (-1 = left, 0 = center, 1 = right) |

**Returns:** Returns the sound instance ID

## `sfx_pitch(soundid, [pitch])` → *number*
Adjusts the pitch of a sound.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to modify |
|`[pitch=1]` |number |Target pitch (1.0 = normal) |

**Returns:** Returns the result of audio_sound_pitch

## `sfx_play(soundid, [pitch], [volume], [offset], [priority], [loopable])` → *number*
Plays a sound effect with customizable parameters.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to play |
|`[pitch=1]` |number |Pitch adjustment (1.0 = normal) |
|`[volume=global.sfx_volume]` |number |Volume level (0.0 to 1.0) |
|`[offset=0]` |number |Starting position in milliseconds |
|`[priority=8]` |number |Playback priority |
|`[loopable=false]` |boolean |Whether the sound should loop |

**Returns:** Returns the sound instance ID

## `sfx_play_on(soundid, [pitch], [volume], [offset], [priority], [loopable])` → *number*
Plays a sound effect on a specific audio emitter.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to play |
|`[pitch=1]` |number |Pitch adjustment (1.0 = normal) |
|`[volume=1]` |number |Volume level (0.0 to 1.0) |
|`[offset=0]` |number |Starting position in milliseconds |
|`[priority=8]` |number |Playback priority |
|`[loopable=false]` |boolean |Whether the sound should loop |

**Returns:** Returns the sound instance ID

## `sfx_stop(soundid)` → *number*
Stops playback of a specific sound.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`soundid` |sound |The sound to stop |

**Returns:** Returns the result of audio_stop_sound
