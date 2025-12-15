/**
 * Initializes border system with default settings.
 */
function border_init() {
    global._border_id = "SIMPLE";
    global._border_sel = 0;
    global._border_enabled = true;
    global._border_type_index = 1;
    global._border_type = [0, 1, 2];
    global.temp_surface = noone;
}

/**
 * Enables or disables border drawing.
 * @param {boolean} enabled - True to enable borders, false to disable.
 */
function border_set_enabled(enabled) {
    global._border_enabled = enabled;
}

/**
 * Checks if border drawing is enabled.
 * @returns {boolean} True if borders are enabled.
 */
function border_get_enabled() {
    return global._border_enabled;
}

/**
 * Sets the current border type by name.
 * @param {string} border_name - Border identifier (e.g., "FANCY", "SIMPLE").
 */
function border_set_id(border_name) {
    global._border_id = border_name;
}

/**
 * Draws the specified border style around the game view.
 * @param {string} [border="FANCY"] - Border style to draw.
 */
function border_draw(border = "FANCY") {
    if (live_call()) return live_result;
    if (border_get_enabled() == true && global.asp_ratio == 1) {
        // Calculate alpha values - background should always be full alpha
        var background_alpha = 1; // Background always full alpha
        var border_overlay_alpha = 1; // Default border alpha
        
        // Only apply camera's border_alpha to the border overlay, not the background
        if ((global._border_type_index == 0 || global._border_type_index == 1) && 
            variable_instance_exists(obj_master_camera, "border_alpha")) {
            border_overlay_alpha = obj_master_camera.border_alpha;
        }
        
        switch (border) {
            case "PLACEHOLDER":
                draw_sprite_stretched_ext(spr_border_placeholder, 0, 0, 0, (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w, (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h, c_white, border_overlay_alpha);
                break;
            
            case "SIMPLE":
                draw_sprite_stretched_ext(spr_border_black, 0, 0, 0, (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w, (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h, c_white, border_overlay_alpha);
                break;
    
            case "FANCY":
                shader_set(shd_gausblur);
                
                // Get the uniform location
                var size_uniform = shader_get_uniform(shd_gausblur, "size");
    
                // Set the uniform values
                var radius = 0.05 / 6;
                var tex_width = texture_get_width(surface_get_texture(application_surface));
                var tex_height = texture_get_height(surface_get_texture(application_surface));
    
                shader_set_uniform_f(size_uniform, tex_width, tex_height, radius);
                
                // Draw BACKGROUND with full alpha (1)
                draw_surface_stretched_ext(application_surface, 0, 0,
                    (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w,
                    (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h,
                    c_white, background_alpha);
                    
                shader_reset();
                
                // Draw BORDER OVERLAY with its own alpha
                var border_sprite = global.rounded_box ? spr_textborder_outer_rounded : spr_textborder_outer;
                draw_sprite_stretched_ext(border_sprite, 0, 0, 0, 
                    (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w,
                    (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h,
                    c_white, border_overlay_alpha);
                break;
    
            case "SEPIA":
                // Force normal blend mode for proper alpha
                gpu_set_blendmode(bm_normal);
                pal_swap_set(pal_sepia, 1, false);
                draw_sprite_stretched_ext(spr_border_sepia, 0, 0, 0,
                    (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w,
                    (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h,
                    c_white, border_overlay_alpha);
                pal_swap_reset();
                break;
    
            default:
                draw_sprite_stretched_ext(spr_px, 0, 0, 0,
                    (640 * 1.5) * (window_get_fullscreen() ? display_get_width() / 1.5 : global._display_width) / GAME_RES.w,
                    (640 * 1.5) * 9 / 16 * (window_get_fullscreen() ? display_get_width() * 3 / 1.5 / 4 : global._display_height) / GAME_RES.h,
                    c_black, border_overlay_alpha);
                break;
        }
    }
}