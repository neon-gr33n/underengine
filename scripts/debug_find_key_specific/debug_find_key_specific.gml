function debug_find_key_specific(key_to_find) {
    show_debug_message("=== SEARCHING FOR KEY: '" + string(key_to_find) + "' ===");
    
    var grid_width = ds_grid_width(global.dialogue_grid);
    var grid_height = ds_grid_height(global.dialogue_grid);
    
    // Search through all rows
    for (var row = 0; row < grid_height; row++) {
        var cell_value = string(global.dialogue_grid[# 0, row]);
        show_debug_message("Row " + string(row) + ", col 0: '" + cell_value + "'");
        
        if (cell_value == key_to_find) {
            show_debug_message("*** FOUND KEY at row: " + string(row) + " ***");
            
            // Show all columns for this row
            var row_info = "Full row: ";
            for (var col = 0; col < grid_width; col++) {
                row_info += "[" + string(col) + "]'" + string(global.dialogue_grid[# col, row]) + "' ";
            }
            show_debug_message(row_info);
            return row;
        }
    }
    
    show_debug_message("*** KEY NOT FOUND ***");
    return -1;
}