///@category Configuration
///@title System Configuration Macros
#region Documentation text
///@text ## UnderEngine Configuration Macros
///Core engine constants and settings that define the UnderEngine framework's behavior.
///
///## Engine Information Macros
///
///| Macro Name | Purpose | Default Value |
///| ---------- | ------- | ------------- |
///| `__UNDERENGINE_VERSION` | Current version of the UnderEngine framework | "v0.7.0-beta-1" |
///| `__UNDERENGINE_LOGGING` | Enable or disable engine logging system | true |
///
///## Build Configuration Macros
///
///| Macro Name | Purpose | Default Value |
///| ---------- | ------- | ------------- |
///| `DEVELOPERBUILD` | Developer mode flag (1 = enabled, 0 = disabled) | 0 |
///| `GRID_CELL_SIZE` | Size of grid cells for positioning and alignment | 20 |
///
///## Usage Examples
///```gml
///// Check engine version
///show_debug_message("Using UnderEngine " + __UNDERENGINE_VERSION);
///
///// Conditional logging
///if (__UNDERENGINE_LOGGING) {
///    show_debug_message("Engine logging enabled");
///}
///
///// Developer features
///if (DEVELOPERBUILD == 1) {
///    show_debug_message("Developer build - extra features enabled");
///}
///
#endregion

#region Engine
/// @macro __UNDERENGINE_VERSION
/// @description Current version of the UnderEngine framework
#macro __UNDERENGINE_VERSION "v0.7.4-beta-1"

/// @macro __UNDERENGINE_LOGGING
/// @description Enable or disable engine logging system
#macro __UNDERENGINE_LOGGING true

/// @macro DEVELOPERBUILD
/// @description Developer build flag (1 = enabled, 0 = disabled)
#macro DEVELOPERBUILD 1

/// @macro GRID_CELL_SIZE
/// @description Size of grid cells for positioning and alignment
#macro GRID_CELL_SIZE 20 
#endregion

#region Useful Macros
#macro kill for(;;{instance_destroy(a); break}) var a =
#macro elif else if
#macro this self
#macro forceinline gml_pragma("forceinline")
#endregion