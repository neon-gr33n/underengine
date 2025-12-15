//Get tilemap
var tilemap = layer_tilemap_get_id("WaterTiles");

//Set surface
surface_set_target(water_surf);

//Draw tilemap
var cx = camera_get_view_x(view_camera);
var cy = camera_get_view_y(view_camera);
draw_tilemap(tilemap, -cx, -cy);

//Draw reflected player sprite
//Get player y offset for reflection
var yoff = (PLAYER1.sprite_height - PLAYER1.sprite_yoffset)*2;

//Set blendmode
gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);

//Draw reflection
draw_sprite_ext(PLAYER1.sprite_index, PLAYER1.image_index, PLAYER1.x - cx, (PLAYER1.y-yoff) - cy, PLAYER1.image_xscale, -PLAYER1.image_yscale, 0, -1, 0.6);

//Reset blendmode
gpu_set_blendmode(bm_normal);

//Reset surface
surface_reset_target();

//Draw surface in game
draw_surface(water_surf, cx, cy);