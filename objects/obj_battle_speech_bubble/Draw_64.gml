// DO NOTHING
if(live_call()) return live_result;
draw_self()
if flipped_horizontal {
	image_xscale = -1;
} else { image_xscale = 1; }

if flipped_vertical {
	image_yscale = -1;
} else { image_yscale = 1; }
switch(template){
	case "wide horizontal":
		sprite_index = spr_speechbub_wide_h
	break;
	case "wide vertical":
		sprite_index = spr_speechbub_wide_v
	break;
	case "top horizontal":
		sprite_index = spr_speechbub_top_h
	break;
	case "bottom horizontal":
		sprite_index = spr_speechbub_btm_h
	break;
	
	
}