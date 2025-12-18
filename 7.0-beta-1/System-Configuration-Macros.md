# System Configuration Macros

## UnderEngine Configuration Macros
Core engine constants and settings that define the UnderEngine framework's behavior.

## Engine Information Macros

| Macro Name | Purpose | Default Value |
| ---------- | ------- | ------------- |
| `__UNDERENGINE_VERSION` | Current version of the UnderEngine framework | "v0.7.0-beta-1" |
| `__UNDERENGINE_LOGGING` | Enable or disable engine logging system | true |

## Build Configuration Macros

| Macro Name | Purpose | Default Value |
| ---------- | ------- | ------------- |
| `DEVELOPERBUILD` | Developer mode flag (1 = enabled, 0 = disabled) | 0 |
| `GRID_CELL_SIZE` | Size of grid cells for positioning and alignment | 20 |

## Usage Examples
```gml
// Check engine version
show_debug_message("Using UnderEngine " + __UNDERENGINE_VERSION);

// Conditional logging
if (__UNDERENGINE_LOGGING) {
    show_debug_message("Engine logging enabled");
}

// Developer features
if (DEVELOPERBUILD == 1) {
    show_debug_message("Developer build - extra features enabled");
}

