target_width = 700;
target_height = 165;
target_x = x;
target_y = y;
target_angle = 0;
width = 700;
height = 165;
angle = 0;

left = instance_create_depth(x - 50, y - 50, -9999, obj_battle_wall, {image_xscale: 0.8, image_yscale: 10});
right = instance_create_depth(x - 50, y - 50, -9999, obj_battle_wall, {image_xscale: 0.8, image_yscale: 10});

up = instance_create_depth(x - 50, y - 50, -9999, obj_battle_wall, {image_xscale: 10, image_yscale: 0.8});
down = instance_create_depth(x - 50, y - 50, -9999, obj_battle_wall, {image_xscale: 10, image_yscale: 0.8});

reset = function(){
	target_width = 700;
	target_height = 165;
}

rotate = function(px, py, side) {
	side.x = (px - x) * dcos(-angle) - (py - y) * dsin(-angle) + x;
	side.y = (py - y) * dcos(-angle) + (px - x) * dsin(-angle) + y;
}

transform = function(args) {
	var names = struct_get_names(args);
	for (var i = 0; i < array_length(names); i++) {
		var n = names[i];
		switch n {
			case "x": target_x = obj_battle.x+args[$ n]; break;
			case "y": target_y = obj_battle.y+args[$ n]; break;
			
			case "width": target_width = args[$ n]; break;
			case "height": target_height = args[$ n]; break;
			
			case "angle": target_angle = args[$ n] break;
		}
	}
}