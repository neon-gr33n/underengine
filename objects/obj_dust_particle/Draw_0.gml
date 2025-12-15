// Draw the pixel sprite with proper color and alpha
if (sprite_exists(spr_px)) {
    draw_sprite_ext(spr_px, 0, x, y, 
                   size, size, // Scale
                   rotation, 
                   color_blend, // Color tint
                   alpha);      // Alpha
} else {
    // Fallback: draw a rectangle if spr_pixel doesn't exist
    draw_set_color(color_blend);
    draw_set_alpha(alpha);
    draw_rectangle(x - size/2, y - size/2, x + size/2, y + size/2, false);
    draw_set_alpha(1);
}