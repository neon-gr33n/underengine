depth = -99999999;
alpha = 0;
mult = 1.5;

ignore = [];

surf = surface_create(room_width, room_height);

destroy = function() {
	execute_tween(self, "mult", 0, "easeIn", 1);
	alarm[0] = 60;
}

siner = 0;