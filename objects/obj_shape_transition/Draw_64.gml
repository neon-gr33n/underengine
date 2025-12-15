if (!surface_exists(clipSurf))
    clipSurf = surface_create(GAME_RES.w, GAME_RES.h)
    
d_width = window_get_fullscreen() ? window_get_width() : surface_get_width(application_surface)
d_height = window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface)

surface_set_target(clipSurf)
draw_clear_alpha(c_black, 0)
draw_set_color(c_black)
draw_rectangle(0, 0, GAME_RES.w, GAME_RES.h, false)

// Get sprite dimensions for proper centering
var spr_width = sprite_get_width(clipSpr) * scale;
var spr_height = sprite_get_height(clipSpr) * scale;
var center_x = GAME_RES.w / 2;
var center_y = GAME_RES.h / 2;

gpu_set_blendmode(bm_subtract)
draw_sprite_ext(clipSpr, 0, center_x, center_y, scale, scale, 0, c_white, 1)
gpu_set_blendmode(bm_normal)
surface_reset_target()

draw_surface(clipSurf, 0, 0)