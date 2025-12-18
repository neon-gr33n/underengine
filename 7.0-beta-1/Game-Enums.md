# Game Enums

## Game Enumerations
Standardized value sets used throughout the game for consistency.

## Direction Enum (DIR)
Angular direction values in degrees (0-360).

| Enum Value | Degrees | Description |
| ---------- | ------- | ----------- |
| `UP` | 90° | Straight up |
| `DOWN` | 270° | Straight down |
| `LEFT` | 180° | Straight left |
| `RIGHT` | 0° | Straight right |
| `UP_RIGHT` | 45° | Up-right diagonal |
| `UP_LEFT` | 135° | Up-left diagonal |
| `DOWN_LEFT` | 225° | Down-left diagonal |
| `DOWN_RIGHT` | 315° | Down-right diagonal |

## Speaker Type Enum (SPEAKER_TYPE)
Types of dialogue speakers.

| Enum Value | Description |
| ---------- | ----------- |
| `REGULAR` | Standard NPC or character |
| `SHOP` | Shopkeeper/special merchant |

## Easing Type Enum (easetype)
Animation easing functions for smooth transitions.

| Category | Enum Values |
| -------- | ----------- |
| **Basic** | `none`, `linear`, `percent` |
| **Quadratic** | `easeInQuad`, `easeOutQuad`, `easeInOutQuad` |
| **Cubic** | `easeInCubic`, `easeOutCubic`, `easeInOutCubic` |
| **Quartic** | `easeInQuart`, `easeOutQuart`, `easeInOutQuart` |
| **Quintic** | `easeInQuint`, `easeOutQuint`, `easeInOutQuint` |
| **Sine** | `easeInSine`, `easeOutSine`, `easeInOutSine` |
| **Circular** | `easeInCirc`, `easeOutCirc`, `easeInOutCirc` |
| **Exponential** | `easeInExpo`, `easeOutExpo`, `easeInOutExpo` |
| **Elastic** | `easeInElastic`, `easeOutElastic`, `easeInOutElastic` |
| **Back** | `easeInBack`, `easeOutBack`, `easeInOutBack` |
| **Bounce** | `easeInBounce`, `easeOutBounce`, `easeInOutBounce` |

## Language Enum (LANGUAGES)
Supported game languages with numeric IDs.

| Enum Value | ID | Description |
| ---------- | -- | ----------- |
| `ENG_US` | 1 | English (United States) |
| `FRA_FR` | 2 | French (France) |
| `JPN_JP` | 3 | Japanese (Japan) |

## Usage Examples
```gml
// Direction usage
var direction = DIR.UP;
image_angle = DIR.RIGHT; // Face right

// Easing animation
TweenFire(obj, easetype.easeOutQuad, 0, 0, 0, 30, "x", start_x, end_x);
