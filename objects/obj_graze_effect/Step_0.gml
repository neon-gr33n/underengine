// Animate through frames
image_index += image_speed;

// Loop animation if we have multiple frames (4 frames = 0-3)
if (image_index >= 4) {
    image_index = 0;
}

// Scale up over time
if (scale < max_scale) {
    scale += 0.03;
}

// Apply scale
image_xscale = scale;
image_yscale = scale;

// Fade out after fade_start frames
if (life > fade_start) {
    // First part of life - full or increasing alpha
    image_alpha = min(1, image_alpha + 0.05);
} else {
    // Fade out during last part of life
    image_alpha -= 0.1;
}

life--;

// Destroy when life ends or fully faded
if (life <= 0 || image_alpha <= 0) {
    instance_destroy();
}