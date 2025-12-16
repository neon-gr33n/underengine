# Internal

## `create_floating_text(_xx, _yy, _font, _color, _text, _voice, [_dur])` → *Instance*
Creates floating text at specified position with customizable appearance
Creates an instance of obj_floating_text with text, font, color, and voice properties

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_xx` |Number |X position for floating text |
|`_yy` |Number |Y position for floating text |
|`_font` |Font|String |Font asset or font name to use for text display |
|`_color` |Color |Text color constant (e.g., c_white, c_red, etc.) |
|`_text` |String |Text content to display |
|`_voice` |Sound|Asset |Voice sound asset to play with text (optional) |
|`[_dur=300]` |Number |Duration in frames before text disappears (default 300 frames = ~5 seconds at 60fps) |

**Returns:** Instance ID of the created floating text object
```gml
 // Create red damage text
 create_floating_text(x, y, fnt_main, c_red, "-50", undefined, 120);
 
```gml
 // Create floating dialogue with voice
 create_floating_text(PLAYER1.x, PLAYER1.y-50, fnt_sans, c_white, "hey.", snd_sans_v);
 
```gml
 // Quick floating message (2.5 seconds)
 create_floating_text(mouse_x, mouse_y, fnt_main_small, c_yellow, "Click!", undefined, 150);
```
