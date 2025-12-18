# Game Constants and Macros

## Game Configuration Macros
Core game constants and settings that define the game's behavior and configuration.

## Core Game Macros

| Macro Name | Purpose |
| ---------- | ------- |
| `GAME` | Main game controller object that manages game state |
| `GAME_NAME` | Display name of the game |
| `GAME_VERSION` | Current version number of the game |
| `GAME_AUTHOR` | Author/developer of the game |

## User Interface Macros

| Macro Name | Purpose |
| ---------- | ------- |
| `UTE_ENABLE_DF_CMENU_CURSOR` | Enable custom menu cursor display |
| `__DRAW_9SLICE_BOX_WITH_OPACITY` | Use 9-slice sprites for dialog boxes with opacity control |
| `__DRAW_BOX_OPACITY` | Opacity level for dialog box inner borders (0.5-1 recommended) |

## Display and Resolution Macros

| Macro Name | Purpose |
| ---------- | ------- |
| `GAME_RES` | Base game resolution in pixels (width × height) |

## Usage Examples
```gml
// Set game name and version
#macro GAME_NAME "My Awesome Game"
#macro GAME_VERSION "1.0.0"

// Configure display settings
#macro __DRAW_BOX_OPACITY 0.8  // Semi-transparent dialog boxes
```
