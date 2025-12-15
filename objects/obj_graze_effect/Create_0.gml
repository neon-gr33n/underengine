image_speed = 0.5; // Adjust speed as needed (0.5 = half speed, 1 = normal, 2 = double)
image_index = 0;
life = 15; // How long the effect lasts (in frames)
image_alpha = 0.7;
scale = 0.8; // Start slightly smaller
max_scale = 1.2; // Max size it will grow to
fade_start = 8; // When to start fading out (frame count)

show_debug_message("Graze effect created at: " + string(x) + ", " + string(y));