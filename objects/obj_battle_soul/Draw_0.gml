//draw_self();
///@desc Process States
if(live_call()) return live_result;
//show_message("hi")

if instance_exists(obj_battle_handler) || room == rm_soul_tester {
    if currentState == "inMenu" {
        if !layer_exists(layer_get_id("menuHeart")) {
            layer_create(depth,"menuHeart")
            _sprite=layer_sprite_create(layer_get_id("menuHeart"),x,y,sprite_index)
        }
        if layer_get_depth(layer_get_id("menuHeart"))!=depth {
            layer_depth(layer_get_id("menuHeart"),depth)
        }
        _spritex=layer_sprite_get_x(_sprite)
        _spritey=layer_sprite_get_y(_sprite)
        if abs(_spritex-x)+abs(_spritey-y)!=0 {
            if instance_exists(obj_battle_handler) && obj_battle_handler.currentState=="menuBegin" {
                layer_sprite_x(_sprite,x)
                layer_sprite_y(_sprite,y)
            } else {
                // Frame-rate independent interpolation
                var interpolation_factor = 8 * global.__delta_stepFactor;
                _spritex += (x - _spritex) / interpolation_factor;
                _spritey += (y - _spritey) / interpolation_factor;
                
                // Optional: Add epsilon check for stability
                // if abs(_spritex - x) < 0.01 _spritex = x;
                // if abs(_spritey - y) < 0.01 _spritey = y;
                
                layer_sprite_x(_sprite, _spritex);
                layer_sprite_y(_sprite, _spritey);
            }
        }
        layer_sprite_xscale(_sprite, image_xscale);
        layer_sprite_yscale(_sprite, image_xscale);
        layer_sprite_blend(_sprite, colour_change >= 0 ? colour_change : soul_type);
        layer_sprite_index(_sprite, image_index);
    } else {
        if layer_exists(layer_get_id("menuHeart")) layer_destroy(layer_get_id("menuHeart"));
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, colour_change >= 0 ? colour_change : soul_type, image_alpha);
    }
}