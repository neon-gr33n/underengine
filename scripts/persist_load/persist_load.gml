function persist_load() 
{
    // Check if file exists
    if (!file_exists("file_p")) {
        flags_init(true);
        return true;
    }
    
    var buff = buffer_load("file_p");
    if (buff == -1 || buffer_get_size(buff) < 7) {
        if (buff != -1) buffer_delete(buff);
        flags_init(true);
        return false;
    }
    
    // Skip header if it exists
    buffer_seek(buff, buffer_seek_start, 0);
    var header_check = buffer_read(buff, buffer_text);
    
    if (header_check == "TMUS") {
        // Skip version byte
        buffer_read(buff, buffer_u8);
    } else {
        // No header, go back to start
        buffer_seek(buff, buffer_seek_start, 0);
    }
    
    // Check if we have enough data for flag count
    if (buffer_tell(buff) + 2 > buffer_get_size(buff)) {
        buffer_delete(buff);
        flags_init(true);
        return false;
    }
    
    // Read flag count
    var flagCount = buffer_read(buff, buffer_u16);
    
    // Initialize flags
    flags_init(false);
    
    // Read flags
    for (var i = 0; i < flagCount; i++) {
        // Safety check
        if (buffer_tell(buff) >= buffer_get_size(buff)) break;
        
        var key = buffer_read(buff, buffer_string);
        
        // Safety check
        if (buffer_tell(buff) >= buffer_get_size(buff)) break;
        
        var val = buffer_read(buff, buffer_s8);
        ds_map_set(global.pflags, key, val);
    }
    
    buffer_delete(buff);
    return true;
}