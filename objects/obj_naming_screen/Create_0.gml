// create event
image_alpha = 1;

// Character sets as arrays (Undertale-style)
hiragana_rows = ["あいうえおかきくけこがぎぐげご",
                 "さしすせそざじずぜぞらりるれろ",
                 "たちつてとだぢづでどなにぬねの",
                 "はひふへほばびぶべぼぱぴぷぺぽ",
                 "まみむめもやゆよゃゅょわをんー",
                 "ぁぃぅぇぉっゎ"]

katakana_rows = ["アイウエオカキクケコガギグゲゴ",
                 "サシスセソザジズゼゾラリルレロ",
                 "タチツテトダヂヅデドナニヌネノ",
                 "ハヒフヘホバビブベボパピプペポ",
                 "マミムメモヤユヨャュョワヲンー",
                 "ァィゥェォッヮヵヶヴ"]

// Store lowercase version for toggling
naming_rows_lower = ["abcdefg",
                     "hijklmn", 
                     "opqrstu",
                     "vwxyz"]
                     
naming_rows_upper = ["ABCDEFG",
                     "HIJKLMN", 
                     "OPQRSTU",
                     "VWXYZ"]

naming_rows = naming_rows_upper; // Start with uppercase

// Character selection
char_x = 0;      // column index (0-based)
char_y = 0;      // row index (0-based)
_charset = 0;    // 0=hiragana, 1=katakana, 2=alphabet
_current_charset = hiragana_rows; // Start with hiragana for Japanese
japanese_nav_state = 0; // 0=character grid, 1=charset row, 2=control row
japanese_charset_selection = 0; // Which charset is selected (0=hiragana, 1=katakana, 2=alphabet)

english_char_x = 0;    // Column for English (0-12, 13 letters per row)
english_char_y = 0;    // Row for English (0-3 for letters, 4 for controls)
english_control_sel = 0; // Which control is selected (0=QUIT, 1=CLEAR, 2=RANDOMIZE, 3=ACCEPT)
letterSelection = 0;
_choice = 0;
_validName = true;
_currentNameEntry = ""
_currentNameDescript = ""
_charToAdd = ""
checkingName = false;
nameConfirmed = false;

// CAPITALIZATION TOGGLE VARIABLES
global.english_caps_toggle = true; // Start with uppercase
global.japanese_alpha_caps_toggle = true; // For Japanese alphabet mode

// Scribble setup
typist = scribble_typist();
typist.in(0.5, 1.2);
typewriter_state = 0;
typist.skip();

// Font and color
__font = "fnt_main_small"
__color = "c_white"

// Random names list
randomizedName = ds_list_create()
ds_list_add(randomizedName, "Ness")
ds_list_add(randomizedName, "Lucas")
ds_list_add(randomizedName, "Poo")
ds_list_add(randomizedName, "Porky")
ds_list_add(randomizedName, "Beatle")
randomize();
r = irandom(ds_list_size(randomizedName) - 1);

// Confirmation animation
_confirm_name_scale = 2;
_confirm_name_offset_x = 0;
_confirm_name_offset_y = 0;
_tween_executed_once = false;

#region Functions
// Grid drawing function using scribble
function draw_character_grid(x, y, typist) {
    if (!checkingName) {
        var font = global.LOC == "JAPANESE" ? "[fnt_main_small_jp]" : "[fnt_main_small]";
        
        // Build formatted grid string with shake effect
        var grid_string = "";
        for (var i = 0; i < array_length(_current_charset); i++) {
            var row = _current_charset[i];
            for (var j = 0; j < string_length(row); j++) {
                var char = string_char_at(row, j + 1);
                
                // Highlight selected character
                if (i == char_y && j == char_x) {
                    grid_string += "[c_yellow][shake]" + char + "[/shake][/c]";
                } else if (_charset == 1) {
                    // Katakana - make bold
                    grid_string += char
                } else {
                    grid_string += char;
                }
                
                // Add space between characters
                if (j < string_length(row) - 1) {
                    grid_string += " ";
                }
            }
            
            // Add line break
            if (i < array_length(_current_charset) - 1) {
                grid_string += "#";
            }
        }
        
        // Create scribble object
        var scribble_object = scribble(font + "[speed,0.2]" + grid_string)
            .starting_format(__font, __color)
            .wrap(640 - x - 42 + y);
        
        if (visible) {
            // Adjust position for Japanese
            var draw_x = x;
            if (global.LOC == "JAPANESE") {
                draw_x = x - 115;
            }
            
            scribble_object.draw(draw_x, y, typist);
            typist.skip();
        }
    }
}

// Get the currently selected letter/character
function get_selected_letter() {
    if (global.LOC == "ENGLISH") {
        if (english_char_y < 4) {
            // Letter is selected - use naming_rows array
            var row = naming_rows[english_char_y];
            var char = string_char_at(row, english_char_x + 1);
            return char; // Already properly capitalized based on toggle
        }
        return ""; // Control button selected
    } else {
        // Japanese mode - only returns characters when in character grid
        if (japanese_nav_state == 0) {
            var row = _current_charset[char_y];
            return string_char_at(row, char_x + 1);
        }
        return ""; // On charset selection or control row
    }
}

// Switch between character sets
function switch_charset(new_charset) {
    _charset = new_charset;
    switch(_charset) {
        case 0: 
            _current_charset = hiragana_rows; 
            break;
        case 1: 
            _current_charset = katakana_rows; 
            break;
        case 2: 
            // For alphabet mode, use appropriate case based on toggle
            if (global.LOC == "ENGLISH") {
                _current_charset = global.english_caps_toggle ? naming_rows_upper : naming_rows_lower;
            } else {
                _current_charset = global.japanese_alpha_caps_toggle ? naming_rows_upper : naming_rows_lower;
            }
            naming_rows = _current_charset;
            break;
    }
    // Reset selection to top-left
    char_x = 0;
    char_y = 0;
}

// Navigation functions
function move_selection_right() {
    var row_length = string_length(_current_charset[char_y]);
    if (char_x < row_length - 1) {
        char_x += 1;
    }
}

function move_selection_left() {
    if (char_x > 0) {
        char_x -= 1;
    }
}

function move_selection_down() {
    var rows = array_length(_current_charset);
    if (char_y < rows - 1) {
        char_y += 1;
        // Ensure selection stays within row bounds
        var row_length = string_length(_current_charset[char_y]);
        if (char_x >= row_length) {
            char_x = row_length - 1;
        }
    }
}

function move_selection_up() {
    if (char_y > 0) {
        char_y -= 1;
        // Ensure selection stays within row bounds
        var row_length = string_length(_current_charset[char_y]);
        if (char_x >= row_length) {
            char_x = row_length - 1;
        }
    }
}

// Check name for special cases
function check_current_entry(name) {
    _validName = true; // Reset
    _currentNameDescript = loc_gettext("ui.naming.description.gen");
    
    switch(name) {
		case "a":
		case "b":
		case "c":
		case "d":
		case "e":
		case "f":
		case "g":
		case "h":
		case "i":
		case "j":
		case "k":
		case "l":
		case "m":
		case "n":
		case "o":
		case "p":
		case "q":
		case "r":
		case "s":
		case "t":
		case "u":
		case "v":
		case "w":
		case "x":
		case "y":
		case "z":
			_currentNameDescript =loc_gettext("ui.naming.description.short");
			break;
        case "aaaaaa":
            _currentNameDescript = loc_gettext("ui.naming.description.notcreative");
            break;
        case "kris":
        case "noelle":
        case "susie":
        case "ralsei":
        case "alvin":
        case "jock":
        case "catti":
        case "berdly":
        case "berghly":
        case "nerdly":
        case "jevil":
        case "seam":
        case "king":
        case "spamton":
        case "mike":
        case "tenna":
            _currentNameDescript = "AN... INTERESTING COINCIDENCE.";
            break;
        case "ness":
        case "lucas":
        case "porky":
        case "poo":
            _currentNameDescript = "I feel a strange almost#otherworldly connection.";
            break;
    }
	
	if (_validName && checkingName && !_tween_executed_once) {
        execute_tween(id, "_confirm_name_offset_x", -145, "linear", 3, false);
        execute_tween(id, "_confirm_name_offset_y", -25, "linear", 3, false);
        execute_tween(id, "_confirm_name_scale", 6, "linear", 3, false);
        _tween_executed_once = true;
    }
}

/// @function calculate_text_width(text, font_index)
/// @desc Calculates width of text using current font
function calculate_text_width(text, font_index = -1) {
	 if (font_index == -1) {
        // Use appropriate font based on language
        var lang_info = global.LANGUAGE_CONFIG.get_by_id(global.lang);
        var is_japanese = lang_info.name == "JAPANESE";
        font_index = is_japanese ? asset_get_index("fnt_main_bt_jp") : asset_get_index("fnt_main_bt");
    }
    
    var old_font = draw_get_font();
    draw_set_font(font_index);
    var width = string_width(text)*1.15;
    draw_set_font(old_font);
    return width;
}
	
// Check if resetted, if so, restore prior name entry
function check_for_reset(){
	if(global.just_reset){
		_validName = true;
		checkingName = true;
		_currentNameEntry = string(member_get_attribute(party_get_leader(), "NAME"))
		_currentNameDescript = "Your name is..."
		
		if (_validName && checkingName && !_tween_executed_once) {
        execute_tween(id, "_confirm_name_offset_x", -145, "linear", 3, false);
        execute_tween(id, "_confirm_name_offset_y", -25, "linear", 3, false);
        execute_tween(id, "_confirm_name_scale", 6, "linear", 3, false);
        _tween_executed_once = true;
    }
	}
}
	
check_for_reset();
	
#endregion