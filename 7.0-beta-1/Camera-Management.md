# Camera Management

## `camera_setup([view_port], [_full_screen], [_pix_perf], [view_scale])` → `undefined`
Sets up the camera view and display settings

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[view_port=0]` |number |Viewport index to configure |
|`[_full_screen=noone]` |boolean |Fullscreen state (noone = keep current) |
|`[_pix_perf=true]` |boolean |Enable pixel perfect rendering |
|`[view_scale=0.5]` |number |Camera zoom scale factor |






































## `fullscreen_toggle([_pix_perf])` → *boolean*
Toggles between fullscreen and windowed mode

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_pix_perf=true]` |boolean |Maintain pixel perfect rendering |

**Returns:** Current fullscreen state after toggle

## `camera_set_zoom()` → `undefined`
Adjusts camera zoom based on mouse wheel input

## `camera_lerp_zoom(scale, [zoom_spd])` → `undefined`
Smoothly transitions camera zoom to a target scale

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`scale` |number |Target zoom scale |
|`[zoom_spd=0.025]` |number |Lerp speed (0-1) |







## `camera_reset_zoom([zoom_spd])` → `undefined`
Smoothly resets camera zoom to default

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[zoom_spd=0.025]` |number |Lerp speed (0-1) |






## `camera_set_position()` → `undefined`
Updates camera position and handles screen shake

## `player_link_to_camera([_p_id])` → `undefined`
Links a player to a dedicated camera object

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_p_id=id]` |instance |Player instance to link |


























## `camera_window_resize(_p_full, [_p_width], [_p_height])` → `undefined`
Handles window resizing and fullscreen toggling

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_p_full` |boolean |Enable fullscreen mode |
|`[_p_width=1280]` |number |Window width when not fullscreen |
|`[_p_height=-1]` |number |Window height (-1 = auto-calc as 3:4 ratio) |
































## `set_scales()` → `undefined`
Calculates and sets view scaling values
