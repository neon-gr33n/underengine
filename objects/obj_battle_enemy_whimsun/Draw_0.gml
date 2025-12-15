if(live_call()) return live_result;
if !spared {
	draw_sprite_ext(sprite_index, image_index * image_speed, x, y + sin(current_time * 0.005) * 8, image_xscale, image_yscale, 0, image_blend, image_alpha);
} else {
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, image_blend, image_alpha);
}

