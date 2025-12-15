if (sprite_index == spr_echo_turn || sprite_index == spr_echo_sink || sprite_index = spr_echo_grow || sprite_index == spr_echo_laugh || sprite_index == spr_echo_tilt || sprite_index == spr_echo_creepy) {
    draw_self();
} else {
    draw_sprite_ext(sprite_index, floor(talk_frame), x, y, 1, 1, 0, c_white, 1);
}