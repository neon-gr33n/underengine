///@category Configuration
///@title Game Macros
#region Documentation text
///@text ## Game Configuration Macros
///Core game constants and settings that define the game's behavior and configuration.
///
///## Core Game Macros
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `GAME` | Main game controller object that manages game state |
///| `GAME_NAME` | Display name of the game |
///| `GAME_VERSION` | Current version number of the game |
///| `GAME_AUTHOR` | Author/developer of the game |
///
///## User Interface Macros
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `UTE_ENABLE_DF_CMENU_CURSOR` | Enable custom menu cursor display |
///| `__DRAW_9SLICE_BOX_WITH_OPACITY` | Use 9-slice sprites for dialog boxes with opacity control |
///| `__DRAW_BOX_OPACITY` | Opacity level for dialog box inner borders (0.5-1 recommended) |
///
///## Display and Resolution Macros
///
///| Macro Name | Purpose |
///| ---------- | ------- |
///| `GAME_RES` | Base game resolution in pixels (width × height) |
///
///## Usage Examples
///```gml
///// Set game name and version
///#macro GAME_NAME "My Awesome Game"
///#macro GAME_VERSION "1.0.0"
///
///// Configure display settings
///#macro __DRAW_BOX_OPACITY 0.8  // Semi-transparent dialog boxes
///```
#endregion

/// @macro GAME
/// @description Main game controller object
#macro GAME obj_game_handler

/// @macro GAME_NAME
/// @description Display name of the game
#macro GAME_NAME "Your Game"

/// @macro GAME_VERSION
/// @description Current version number
#macro GAME_VERSION "0.7.0"

/// @macro GAME_AUTHOR
/// @description Game author/developer
#macro GAME_AUTHOR "Author"

/// @macro UTE_ENABLE_DF_CMENU_CURSOR
/// @description Enable custom menu cursor display
#macro UTE_ENABLE_DF_CMENU_CURSOR false

/// @macro __DRAW_9SLICE_BOX_WITH_OPACITY
/// @description Use 9-slice sprites for dialog boxes with opacity control
#macro __DRAW_9SLICE_BOX_WITH_OPACITY true

/// @macro __DRAW_BOX_OPACITY
/// @description Opacity level for dialog box inner borders (0.5-1 recommended)
#macro __DRAW_BOX_OPACITY 1

/// @macro GAME_RES
/// @description Base game resolution in pixels {width, height}
#macro GAME_RES {w:640,h:480}