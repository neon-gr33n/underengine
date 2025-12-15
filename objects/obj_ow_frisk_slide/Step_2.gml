PLAYER1.x = x;
PLAYER1.y = y;
if (sliding == 1) {
	y += slide_spd;
	
	slidetimer++;
	
	if (slidetimer > 0){
		// Count existing dust instances
		var dust_count = instance_number(obj_slidedust);

		if (dust_count < 3) {
		    // Determine position based on existing dust count
		    var y_positions = [25, 30, 35]; // Three different Y positions
		    var y_offset = y_positions[dust_count]; // Pick based on current count
    
		    var dust = instance_create(x, y - y_offset, obj_slidedust);
    
		    with (dust) {
		        image_speed = 1;
		        vspeed = -6
        
		        // Add slight rotation or scaling for variety
		        image_angle = random_range(-5, 5);
		        image_xscale = 0.8 + random(0.4);
		        image_yscale = 1;
        
		        // Set short lifespan (6 seconds)
		        alarm[0] = 10;
		    }
}
	}
}