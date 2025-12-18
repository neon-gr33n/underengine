///@category Configuration
///@title Game Enums
#region Documentation text
///@text ## Game Enumerations
///Standardized value sets used throughout the game for consistency.
///
///## Direction Enum (DIR)
///Angular direction values in degrees (0-360).
///
///| Enum Value | Degrees | Description |
///| ---------- | ------- | ----------- |
///| `UP` | 90° | Straight up |
///| `DOWN` | 270° | Straight down |
///| `LEFT` | 180° | Straight left |
///| `RIGHT` | 0° | Straight right |
///| `UP_RIGHT` | 45° | Up-right diagonal |
///| `UP_LEFT` | 135° | Up-left diagonal |
///| `DOWN_LEFT` | 225° | Down-left diagonal |
///| `DOWN_RIGHT` | 315° | Down-right diagonal |
///
///## Speaker Type Enum (SPEAKER_TYPE)
///Types of dialogue speakers.
///
///| Enum Value | Description |
///| ---------- | ----------- |
///| `REGULAR` | Standard NPC or character |
///| `SHOP` | Shopkeeper/special merchant |
///
///## Easing Type Enum (easetype)
///Animation easing functions for smooth transitions.
///
///| Category | Enum Values |
///| -------- | ----------- |
///| **Basic** | `none`, `linear`, `percent` |
///| **Quadratic** | `easeInQuad`, `easeOutQuad`, `easeInOutQuad` |
///| **Cubic** | `easeInCubic`, `easeOutCubic`, `easeInOutCubic` |
///| **Quartic** | `easeInQuart`, `easeOutQuart`, `easeInOutQuart` |
///| **Quintic** | `easeInQuint`, `easeOutQuint`, `easeInOutQuint` |
///| **Sine** | `easeInSine`, `easeOutSine`, `easeInOutSine` |
///| **Circular** | `easeInCirc`, `easeOutCirc`, `easeInOutCirc` |
///| **Exponential** | `easeInExpo`, `easeOutExpo`, `easeInOutExpo` |
///| **Elastic** | `easeInElastic`, `easeOutElastic`, `easeInOutElastic` |
///| **Back** | `easeInBack`, `easeOutBack`, `easeInOutBack` |
///| **Bounce** | `easeInBounce`, `easeOutBounce`, `easeInOutBounce` |
///
///## Language Enum (LANGUAGES)
///Supported game languages with numeric IDs.
///
///| Enum Value | ID | Description |
///| ---------- | -- | ----------- |
///| `ENG_US` | 1 | English (United States) |
///| `FRA_FR` | 2 | French (France) |
///| `JPN_JP` | 3 | Japanese (Japan) |
///
///## Usage Examples
///```gml
///// Direction usage
///var direction = DIR.UP;
///image_angle = DIR.RIGHT; // Face right
///
///// Easing animation
///TweenFire(obj, easetype.easeOutQuad, 0, 0, 0, 30, "x", start_x, end_x);
#endregion

/// @enum DIR
/// @description Angular direction values in degrees
enum DIR {
	UP = 90,
	DOWN = 270,
	LEFT = 180,
	RIGHT = 0,
	UP_RIGHT = 45,
	UP_LEFT = 135,
	DOWN_LEFT = 225,
	DOWN_RIGHT = 315,
}

/// @enum SPEAKER_TYPE
/// @description Types of dialogue speakers
enum SPEAKER_TYPE {
	REGULAR,
	SHOP
}

/// @enum easetype
/// @description Animation easing functions for smooth transitions
enum easetype{
	none,
	linear,
	percent,
	easeInQuad,
	easeOutQuad,
	easeInOutQuad,
	easeInCubic,
	easeOutCubic,
	easeInOutCubic,
	easeInQuart,
	easeOutQuart,
	easeInOutQuart,
	easeInQuint,
	easeOutQuint,
	easeInOutQuint,
	easeInSine,
	easeOutSine,
	easeInOutSine,
	easeInCirc,
	easeOutCirc,
	easeInOutCirc,
	easeInExpo,
	easeOutExpo,
	easeInOutExpo,
	easeInElastic,
	easeOutElastic,
	easeInOutElastic,
	easeInBack,
	easeOutBack,
	easeInOutBack,
	easeInBounce,
	easeOutBounce,
	easeInOutBounce,
}

/// @enum LANGUAGES
/// @description Supported game languages with numeric IDs
enum LANGUAGES {
	ENG_US=1,
	FRA_FR=2,
	JPN_JP=3
}