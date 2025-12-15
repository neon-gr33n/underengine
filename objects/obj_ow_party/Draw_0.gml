if(live_call()) return live_result;

// Health bar drawing...
draw_set_alpha(_hud_alpha)
draw_sprite_ext(spr_px,0,x-8,y+sprite_height-72,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "MAX_HP"],6,0,c_red,_hud_alpha)
draw_sprite_ext(spr_px,0,x-8,y+sprite_height-72,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"],6,0,c_lime,_hud_alpha)
draw_ftext(fnt_mars_smol,c_white,x-10,y+sprite_height-82,1,1,0,string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"])+"/"+string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "MAX_HP"]))
draw_set_alpha(1)

if global.danger {
    image_blend = make_color_hsv(0,0,100)
    
    shader_set(shd_danger);
    
    // Set outline color using function
    sh_set_outline(outline_col);
    
     // Still need to set pixelW and pixelH
    var outlineW = shader_get_uniform(shd_danger, "pixelW")
    shader_set_uniform_f(outlineW, texture_get_texel_width(sprite_get_texture(sprite_index,0)))
    var outlineH = shader_get_uniform(shd_danger, "pixelH")
    shader_set_uniform_f(outlineH, texture_get_texel_height(sprite_get_texture(sprite_index,0)))
} else {
    image_blend = make_color_hsv(0,0,255)
}

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

if global.danger {
    shader_reset();
    outline_set_sprite(spr_battle_soul, 0)
    
    // Use the current outline_col for the battle soul
    var soul_x = x + 4.5; // Default
    if (direction == 180) soul_x = x + 3.5;
    if (direction == 360 || direction == 0) soul_x = x + 5.5;
    
    draw_sprite_centered_ext(spr_battle_soul, 0, soul_x, y-4, 1/2, 1/2, 0, outline_col, 1)
    
    outline_end()
}