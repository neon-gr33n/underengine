//@arg filename
// Loads an external music file and creates a stream
function mus_load(fname) {
    var _path = "";
    var type = ".ogg";
    
    if (is_android()) {
        _path = "assets/data/mus/";
    } else {
        _path = "./data/mus/";
    }
    
    var full_path = _path + fname + type;
    show_debug_message("Attempting to load music: " + full_path);
    
    if (file_exists(full_path)) {
        return audio_create_stream(full_path);
    } else {
        show_debug_message("Music file not found: " + full_path);
        return -1;
    }
}