function sh_set_outline(_color) {
    // Validate input
    if (!is_real(_color)) _color = c_red; // Default to red
    
    // Extract components
    var _r = color_get_red(_color);
    var _g = color_get_green(_color);
    var _b = color_get_blue(_color);
    var _a = 1;
    
    // Set shader uniform (convert 0-255 to 0-1)
    var _uniform = shader_get_uniform(shd_danger, "outlineColor");
    shader_set_uniform_f(_uniform, _r/255, _g/255, _b/255, _a/255);
    
    return true; // Success
}