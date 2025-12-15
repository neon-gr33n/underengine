depth = -600;
image_angle = 0;
sprite_index = global.rounded_box ? spr_battle_board_rounded : spr_battle_board;
up = 65;
down = 65;
left = 283;
right = 283;
upTween = 65;
downTween = 65;
leftTween = 283;
rightTween = 283;
_surface = noone;
surf_buff = noone;
ring_buff = noone;
true_x = 320;
true_y = 300;
thickness_frame = 5

function reset_border(){
	up = 65;
	down = 65;
	left = 283;
	right = 283;
}


_last_vertex_array = [];
_vertex_array = [[-left, -up], [0, -up * 2], [right, -up], [right, down], [-left, down]];

vertex_format_begin(); {
	vertex_format_add_position();
	vertex_format_add_texcoord();
	vertex_format_add_color();
} surf_format = vertex_format_end();

vertex_format_begin(); {
	vertex_format_add_position();
	vertex_format_add_color();
} ring_format = vertex_format_end();