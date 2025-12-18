# Difficulty

## `difficulty_data_init()` → `undefined`
Initializes the global difficulty settings data structure

## `game_set_difficulty(difficulty_name)` → *boolean*
Sets the game difficulty and applies appropriate stat multipliers

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`difficulty_name` |string |Name of difficulty (EASY, NORMAL, HARD, LUNATIC) |

**Returns:** Success or failure of setting difficulty

## `game_get_difficulty_damage(base_damage)` → *number*
Applies difficulty modifiers to damage values

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`base_damage` |number |The base damage value before difficulty adjustments |

**Returns:** Modified damage based on current difficulty settings

## `game_get_difficulty_info()` → *struct*
Gets the current difficulty settings

**Returns:** Current difficulty settings object

## `game_get_difficulty_label()` → *string*
Gets the display label for the current difficulty

**Returns:** Current difficulty label
