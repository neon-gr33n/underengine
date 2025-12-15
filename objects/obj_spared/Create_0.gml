for (var i = 0; i < 14; i += 1)
{
    // Get the enemy's visual center (where it's actually drawn)
    var visual_center_x = x;
    var visual_center_y = y/1.5;
    
    // Create clouds in a circular pattern around the center
    var angle = random(360);
    var distance = random_range(4, 20); // Adjust these values for spread
    
    var cloud_x = visual_center_x + lengthdir_x(distance, angle);
    var cloud_y = visual_center_y + lengthdir_y(distance, angle);
    
    var sdust = instance_create(cloud_x, cloud_y, obj_dustcloud);
    
    // Optional: Add variety to clouds
    if (instance_exists(sdust)) {
        sdust.image_angle = random(360);
        sdust.image_xscale = 0.7 + random(0.6);
        sdust.image_yscale = sdust.image_xscale;
    }
}