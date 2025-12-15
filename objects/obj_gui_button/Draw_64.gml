/// Draw GUI Event
if (live_call()) return live_result;

// Draw the 9-slice or button sprite
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

// Calculate true hitbox based on scale
var sw = sprite_get_width(sprite_index);
var sh = sprite_get_height(sprite_index) / 2;
var x1 = x;
var y1 = y;
var x2 = x + (sw * image_xscale);
var y2 = y + (sh * image_yscale);

// Get mouse position in GUI space
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Detect hover and click
var mouseover = point_in_rectangle(mx, my, x1, y1, x2, y2);
var click = mouse_check_button_pressed(mb_left);

// Run custom function if clicked
if (mouseover && click) {
    if (is_callable(on_click)) {
        on_click(); // Execute the assigned function
    }
}

// Draw label text centered (optional)
var text_x = x + (sw * image_xscale / 2) - 32;
var text_y = y + (sh * image_yscale / 2) - 6;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_ftext(fnt_main_jp, c_white, text_x, text_y, 1, 1, 0, label_text);
