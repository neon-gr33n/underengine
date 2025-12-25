if live_call() return live_result;

// Draw the cropped sprite
if (!finished) {
    var lines_removed = line * 2;
    var remaining_h = max(0, sprite_get_height(sprite_index) - lines_removed);

    if (remaining_h > 0) {
        var draw_x = x - (sprite_get_width(sprite_index) * 0.5) * image_xscale;
        var draw_y = y - remaining_h * 2;

        draw_sprite_part_ext(
            sprite_index,
            0,
            0,
            lines_removed,
            sprite_get_width(sprite_index),
            remaining_h,
            draw_x,
            draw_y,
            image_xscale,
            image_yscale,
            c_white,
            1
        );
    }
}

//// Create vapor pixels (will appear on top)
if (!finished) {
    vapor_counter++;
    if (vapor_counter >= vapor_delay) {
        line += lines_per_tick;
        vapor_counter = 0;
    }
}

// Vapor parsing logic
if (!finished) {
    var ww = 0;
    var ch = 0;

    while(true) {
        if (buffer_tell(vapor_buf) >= buffer_get_size(vapor_buf)) {
            finished = true;
            buffer_delete(vapor_buf);
            instance_destroy();
            exit;
        }

        ch = buffer_read(vapor_buf, buffer_u8);

        if (ch == ord("}") || ch == ord("~")) break;

        // Black space
        if (ch >= 84 && ch <= 121) {
            ww += (ch - 85) * pixel_scale;
        }
        // White vapor pixels
        else if (ch >= 39 && ch <= 82) {
            var len = max(1, ch - 39);

            var vapor_y = (y - remaining_h * 2.1) + lines_removed;

            var p = instance_create_depth(
                x - sprite_get_width(sprite_index)/2 + ww,
                vapor_y, // Align with crop line
                obj_battle_box.depth + 1,
                obj_vaporpx
            );

            p.image_xscale = len;
            ww += len * pixel_scale;
        }
    }

    // Stop at EOF
    if (ch == ord("~")) {
        finished = true;
        buffer_delete(vapor_buf);
        instance_destroy();
    }
}