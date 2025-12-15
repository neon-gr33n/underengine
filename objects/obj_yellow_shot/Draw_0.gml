if _big_shot == 2
	draw_sprite_ext(sprite_index, image_index, x + irandom_range(-1, 1), y + irandom_range(-1, 1), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
else
	draw_self();