image_xscale = width/12;
image_yscale = height/12;
image_angle = angle;

draw_sprite_ext(spr_battle_board_rounded, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

rotate(x - width / 2 - 4, y - height / 2, left);
left.image_yscale = width / 20;

rotate(x + width / 2, y - height / 2, right);
right.image_yscale = width / 20;

rotate(x - width / 2, y - height / 2 - 4, up);
up.image_xscale = height / 20;

rotate(x - width / 2, y + height / 2, down);
down.image_xscale = height / 20;

if width < target_width width += (target_width - width) / 6;
else if width > target_width width -= (width - target_width) / 6;
if height < target_height height += (target_height - height) / 6;
else if height > target_height height -= (height - target_height) / 6;

if x < target_x x += (target_x - x) / 6;
else if x > target_x x -= (x - target_x) / 6;
if y < target_y y += (target_y - y) / 6;
else if y > target_y y -= (y - target_y) / 6;

if angle < target_angle angle += (target_angle - angle) / 6;
else if angle > target_angle angle -= (angle - target_angle) / 6;

if (target_width == 0 && width <= 14) || (target_height == 0 && height <= 14) instance_destroy();