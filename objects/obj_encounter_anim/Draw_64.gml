if (__draw_black)
    draw_sprite_ext(spr_px, 0, 0, 0, global._display_width, global._display_height, 0, c_black, 1);
if (__draw_player)
    draw_sprite_ext(PLAYER1.sprite_index, PLAYER1.image_index, (PLAYER1.x - camera_get_view_x(view_camera[0])) * 2, (PLAYER1.y - camera_get_view_y(view_camera[0])) * 2, PLAYER1.image_xscale * 2, PLAYER1.image_yscale * 2, PLAYER1.image_angle, PLAYER1.image_blend, PLAYER1.image_alpha);
if (__draw_soul)
    draw_sprite_ext(spr_battle_soul, 0, __draw_soul_x, __draw_soul_y, 1, 1, 0, c_red, 1);
