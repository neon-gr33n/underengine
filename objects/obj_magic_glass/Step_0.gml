ar -= 1
if (image_alpha > 0 && ar < 0)
    image_alpha -= 0.1
var alpha = image_alpha
var ided = id
with (obj_ow_party) {
	var _si = sprite_index;
	var _ii = image_index;
	
	sprite_index=spr_frisk_hitbox;
	image_index=0;
	for (i=0;i<array_length(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"]);i++)
		if place_meeting(remx[i*25],remy[i*25],ided) {
			timed = 3
			if (alpha < 1)
			    alpha += 0.2
			break;
		}
	sprite_index=_si;
	image_index=_ii;
}

image_alpha = alpha