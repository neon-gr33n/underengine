# Localization Functions

## `init_language_config()` → *Object*
Initializes the global LANGUAGE_CONFIG object with default languages and utility methods

**Returns:** The initialized LANGUAGE_CONFIG object
```gml
 init_language_config();

 init_language_config();
 // LANGUAGE_CONFIG is now available globally

 // LANGUAGE_CONFIG is now available globally
```

## `add_language()` → `undefined`

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`id` |Number |Unique identifier for the new language |
|`name` |String |Uppercase name (e.g., "SPANISH") |
|`code` |String |Language code (e.g., "ESP_ES") |
|`display_name` |String |Human-readable display name |
|`file_suffix` |String |File suffix for language-specific resources |
|`[needs_special_font=false]` |Bool |Whether language requires special fonts |
```gml
         global.LANGUAGE_CONFIG.add_language(4, "SPANISH", "ESP_ES", "Español", "ES", false);
```

## `get_by_id()` → *Object*
Retrieves language configuration by ID

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`id` |Number |Language ID to search for |

**Returns:** Language configuration object, or English fallback if not found

## `get_by_name()` → *Object*
Retrieves language configuration by name

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`name` |String |Language name to search for (e.g., "ENGLISH") |

**Returns:** Language configuration object, or English fallback if not found

## `get_next()` → *Object*
Gets the next language in sequence (circular navigation)

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`current_id` |Number |Current language ID |

**Returns:** Next language configuration object

## `get_prev()` → *Object*
Gets the previous language in sequence (circular navigation)

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`current_id` |Number |Current language ID |

**Returns:** Previous language configuration object

## `get_index_by_id()` → *Number*
Gets the array index of a language by ID

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`id` |Number |Language ID to find |

**Returns:** Array index, or 0 if not found

## `get_current_info()` → *Object*
Gets current language information based on global.lang

**Returns:** Current language configuration object

## `get_all_names()` → *Array*
Gets array of all language names (for compatibility with old system)

**Returns:** Array of language names

## `get_languages()` → *Array*
Gets the languages array directly (for compatibility)

**Returns:** The languages array

## `loc_update(new_lang, [dir])` → *Object*
Updates the current language with navigation support

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[new_lang]` |Number |New language ID to set (optional if using navigation) |
|`[dir=0]` |Number |Navigation direction: 1 for next, -1 for previous, 0 for direct set |

**Returns:** Current language information after update
```gml
 // Navigate to next language
 loc_update(undefined, 1);
 
 // Set specific language
 loc_update(2, 0);
```

## `loc_init()` → `undefined`
Initializes the localization system, loading CSV data and setting up language

## `loc_setup()` → *Bool*
Sets up the language system on game start

**Returns:** Always returns true

## `loc_auto_detect_languages()` → *Bool*
Auto-detects available languages from the CSV file structure

**Returns:** True if detection succeeded, false otherwise

## `loc_identify_language_from_code(code)` → *Object <span style="color: red;"> *or* </span> undefined*
Identifies language configuration from a 2-letter language code

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`code` |String |2-letter language code (e.g., "en", "jp", "fr") |

**Returns:** Language configuration object, or undefined if not found

## `loc_next_language()` → *Object*
Navigates to the next language in sequence

**Returns:** Current language information after navigation

## `loc_prev_language()` → *Object*
Navigates to the previous language in sequence

**Returns:** Current language information after navigation

## `loc_get_current_lang_name()` → *String*
Gets the current language name (compatibility function)

**Returns:** Current language name (e.g., "ENGLISH")

## `loc_get_current_display_name()` → *String*
Gets the current language display name (compatibility function)

**Returns:** Current language display name (e.g., "English")

## `loc_gettext(key)` → *String*
Main translation function - retrieves localized text by key

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`key` |String |Translation key to look up |

**Returns:** Localized text, or the key itself if not found
```gml
 var title = loc_gettext("ui.config.title");
 // Returns "Configuration" if English, "Configuration" if French, etc.
```

## `loc_get_font(_font_index)` → *Number <span style="color: red;"> *or* </span> String*
Gets language-specific font based on current language

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_font_index` |Number|String |Font index or name |

**Returns:** Language-specific font index or name

## `loc_get_font_key(_font_string)` → *String*
Gets font key with language suffix for Scribble library

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_font_string` |String |Font string/name |

**Returns:** Font string with language suffix if needed

## `loc_reload_fonts()` → `undefined`
Reloads all fonts for the current language

## `loc_update_language_only(new_lang)` → *Bool*
Updates language settings without breaking existing text lookups

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`new_lang` |Number |New language ID to set |

**Returns:** Always returns true

## `loc_debug_csv_structure()` → `undefined`
Debug function to display CSV structure and translation mappings
