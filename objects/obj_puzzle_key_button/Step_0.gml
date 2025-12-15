if (place_meeting(x, y, target_obj)) {   
    if (target_obj != noone) {
        // Check if targets feet, or in the case of a rock, "underside", are on the button
        var _feet_x = target_obj.x;
        var _feet_y = target_obj.bbox_bottom;
        
        if (_feet_x >= bbox_left && _feet_x <= bbox_right &&
            _feet_y >= bbox_top && _feet_y <= bbox_bottom) {
            
            var _lock = instance_find(obj_puzzle_lock, 0);
            image_index = 1;
			if(!snd_played && alarm[0] == -1){
				alarm[0] = 1;	
			}
            if (instance_exists(_lock)) {
                _lock.puzzle_activate(key_value, id);
            }
        }
    }
}