//#region PROCESS MENU VISUAL EVENTS
if abs(tweened)>=6
    tweened=(sign(tweened)*(tweened-(sign(tweened)*6))%360)*sign(tweened)
else
    tweened=0
with obj_text_writer { visible = true } // temporarily re-enable the writer
_cx=320
_cy=420

if(global.debug){
    if(keyboard_check_pressed(vk_subtract)){    
        if(instance_exists(obj_bt)){
            with(obj_bt){
                event_user(3);
            }
        }
    }
}

// Undertale-style horizontal menu
var _button_count = 4;
var _total_width = 460; // Total width for all buttons
var _spacing = _total_width / (_button_count - 1);
var _start_x = _cx - _total_width / 2;
var _button_y = _cy;

for (i=0; i<_button_count; i++) {
    // Calculate horizontal position - FIXED based on button index
    var _button_x = _start_x + (i * _spacing);
    
    // Create layer for button
    if layer_exists(layer_get_id(string(i))) layer_destroy(layer_get_id(string(i)))
    _layer=layer_create(-1000, string(i))
    
    // Create button sprite
    _sprited=layer_sprite_create(layer_get_id(string(i)), _button_x, _button_y, global.loc_sprites[$ "battle_bt"])
    
    // No depth effects - all buttons same size and opacity
    layer_sprite_xscale(_sprited, 1.0)
    layer_sprite_yscale(_sprited, 1.0)
    layer_sprite_blend(_sprited, c_white)
    
    // *** SET CORRECT BUTTON FRAME ***
    // Based on our current sprite sheet layout:
    // Frame 0: FIGHT (normal)      - Button 0, frame 0
    // Frame 1: FIGHT (selected)    - Button 0, frame 1
    // Frame 2: ACT (normal)        - Button 1, frame 0
    // Frame 3: ACT (selected)      - Button 1, frame 1
    // Frame 4: ITEM (normal)       - Button 2, frame 0
    // Frame 5: ITEM (selected)     - Button 2, frame 1
    // Frame 6: MERCY (normal)      - Button 3, frame 0
    // Frame 7: MERCY (selected)    - Button 3, frame 1
    
    // Calculate base frame: i * 2 (0, 2, 4, 6)
    var _base_frame = i * 2;
    
    if (i == battleMenuSelection) {
        // Selected button: use the yellow frame (base_frame + 1)
        layer_sprite_index(_sprited, _base_frame + 1);
    } else {
        // Unselected button: use the normal frame (base_frame)
        layer_sprite_index(_sprited, _base_frame);
    }
    
    // Position HEART at the selected button
    if HEART.currentState == "inMenu" && i == battleMenuSelection {
        HEART.image_xscale = 1.0
        HEART.image_yscale = 1.0
        HEART.x = _button_x - 36 // Position left of the selected button
        HEART.y = _button_y
        HEART.depth = -1001 // Below all buttons
        HEART.image_blend = c_white
    }
}