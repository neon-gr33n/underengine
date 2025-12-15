// Apply physics
hspeed *= friction;
vspeed += gravity;
x += hspeed;
y += vspeed;

// Update rotation
rotation += rotation_speed;

// Fade out
life--;
alpha -= fade_speed;

// Optional: shrink over time
// size *= 0.995;

// Destroy when faded or life ended
if (life <= 0 || alpha <= 0) {
    instance_destroy();
}