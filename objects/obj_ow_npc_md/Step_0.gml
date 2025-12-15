if (float == true){
	siner2++;
	y = ystart + (cos(siner2 / 16) * 8);
	aetimer++;
}

if ((aetimer % move_speed) == 0 && image_alpha != 0 && afterimage == true)
{
	instance_create_depth(x, y, depth + 1, obj_afterimage, 
	{
		sprite_index: sprite_index,
		image_alpha: 0.6,
		fadeSpeed: 0.02,
		hspeed: after_image_rate * 0.5,
		image_index: image_index,
		image_speed: 0	
	});	
}

