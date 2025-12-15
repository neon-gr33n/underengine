alpha = (room_height - PLAYER1.y) / room_height;
siner++;

if (!surface_exists(surf)) {
    surf = surface_create(room_width, room_height);
}

alpha = (room_height - PLAYER1.y) / room_height;
siner++;

surface_set_target(surf);
    draw_clear_alpha(0, alpha * mult);
    gpu_set_blendmode(bm_subtract);
        for (var i = 0; i < array_length(ignore); i++) {
            draw_circle(ignore[i][0], ignore[i][1], ignore[i][2] + sin(siner / 35) * 1.35, false);
        }
    gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface(surf, 0, 0);