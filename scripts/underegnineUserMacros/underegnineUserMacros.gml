///@category Configuration
///@title Engine User Config Macros
#region Documentation text
///## Camera and Display
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `CAM` | Main camera object for view management |
///| `camx` | Current camera X position |
///| `camy` | Current camera Y position |
///
///## Text and Dialogue
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `WRITER` | Text writer/display object for dialogue |
///
///## Player and Party
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `PLAYER1` | Main player/overworld party controller |
///
///## Battle System
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `BOARD` | Battle UI/menu box object |
///| `HEART` | Player soul/heart object in battle |
///| `TEST_ENC` | Test encounter identifier |
///
///## Room and Collision
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `START_ROOM` | Starting room when game begins |
///| `instance_place` | Alias for place_meeting function |
///
///## Usage Examples
///```gml
///// Camera positioning
///var screen_x = x - camx;
///var screen_y = y - camy;
///
///// Start test encounter
///encounter_start(TEST_ENC);
///```
#endregion

/// @macro CAM
/// @description Main camera object for view management
#macro CAM obj_master_camera

/// @macro WRITER
/// @description Text writer/display object for dialogue
#macro WRITER obj_text_writer

/// @macro PLAYER1
/// @description Main player/overworld party controller
#macro PLAYER1 obj_ow_party

/// @macro BOARD
/// @description Battle UI/menu box object
#macro BOARD obj_battle_box

/// @macro HEART
/// @description Player soul/heart object in battle
#macro HEART obj_battle_soul

/// @macro TEST_ENC
/// @description Test encounter identifier
#macro TEST_ENC "test"

/// @macro START_ROOM
/// @description Starting room when game begins
#macro START_ROOM rm_fallen

/// @macro instance_place
/// @description Alias for place_meeting function
#macro instance_place place_meeting

/// @macro camx
/// @description Current camera X position
#macro camx camera_get_view_x(view_camera[0])

/// @macro camy
/// @description Current camera Y position
#macro camy camera_get_view_y(view_camera[0])