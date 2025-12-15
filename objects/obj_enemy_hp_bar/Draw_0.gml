if(bar_visible){
	// Draw background (black border)
	draw_sprite_ext(spr_px,0,xstart+bar_x-bar_width/2-4,ystart+bar_y+18-4,bar_width+8,13+8,0,c_black,1);
	
	// Draw background bar (gray)
	draw_sprite_ext(spr_px,0,xstart+bar_x-bar_width/2,ystart+bar_y+18,bar_width,13,0,c_dkgray,1);
	
	// Calculate current HP percentage
	var hp_percent = _bar_hp / bar_hp_max;
	var current_width = bar_width / bar_hp_max * _bar_hp;
	
	// Determine bar color based on HP percentage
	var bar_color = c_lime; // Default: green (high HP)
	
	if (hp_percent <= 0.15) {
		// Very low HP (15% or less) - bright red
		bar_color = c_red;
	} else if (hp_percent <= 0.5) {
		// Half HP or less - orange/red
		bar_color = make_color_rgb(255, 128, 0); // Orange
	} else if (hp_percent <= 0.8) {
		// Moderately damaged - yellow
		bar_color = c_yellow;
	}
	// else: >75% HP stays green (c_lime)
	
	// Draw HP bar with dynamic color
	draw_sprite_ext(spr_px,0,xstart+bar_x-bar_width/2,ystart+bar_y+18,current_width,13,0,bar_color,1);
}