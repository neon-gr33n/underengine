///@arg sprite
///@arg {real} x1
///@arg {real} y1
///@arg {real} x2
///@arg {real} y2
///@arg {real} color
///@arg index
function draw_9_slice(){
var sprite, x1, y1, x2, y2, color, slice_width, slice_height, width, height, index;
sprite = argument[0]
x1 = argument[1]
y1 = argument[2]
x2 = argument[3]
y2 = argument[4]
color = argument[5]
slice_width = (sprite_get_width(sprite) / 3)
slice_height = (sprite_get_height(sprite) / 3)
if ((sprite_get_width(sprite) % 3) != 0 || (sprite_get_height(sprite) % 3) != 0)
    print_log("WARNING: Sprite is not a multiple of 3.")
width = abs((x2 - x1))
height = abs((y2 - y1))
if (argument_count == 7)
    index = argument[6]
else
    index = 0
draw_sprite_part_ext(sprite, index, 0, 0, slice_width, slice_height, x1, y1, 1, 1, color, 1)
draw_sprite_part_ext(sprite, index, slice_width, 0, slice_width, slice_height, (x1 + slice_width), y1, ((width - (slice_width * 2)) / slice_width), 1, color, 1)
draw_sprite_part_ext(sprite, index, (slice_width * 2), 0, slice_width, slice_height, (x2 - slice_width), y1, 1, 1, color, 1)
draw_sprite_part_ext(sprite, index, 0, slice_height, slice_width, slice_height, x1, (y1 + slice_height), 1, ((height - (slice_height * 2)) / slice_height), color, 1)
draw_sprite_part_ext(sprite, index, slice_width, slice_height, slice_width, slice_height, (x1 + slice_width), (y1 + slice_height), ((width - (slice_width * 2)) / slice_width), ((height - (slice_height * 2)) / slice_height), color, 1)
draw_sprite_part_ext(sprite, index, (slice_width * 2), slice_height, slice_width, slice_height, (x2 - slice_width), (y1 + slice_height), 1, ((height - (slice_height * 2)) / slice_height), color, 1)
draw_sprite_part_ext(sprite, index, 0, (slice_height * 2), slice_width, (slice_height * 2), x1, (y2 - slice_height), 1, 1, color, 1)
draw_sprite_part_ext(sprite, index, slice_width, (slice_height * 2), slice_width, slice_height, (x1 + slice_width), (y2 - slice_height), ((width - (slice_width * 2)) / slice_width), 1, color, 1)
draw_sprite_part_ext(sprite, index, (slice_width * 2), (slice_height * 2), slice_width, slice_height, (x2 - slice_width), (y2 - slice_height), 1, 1, color, 1)

}