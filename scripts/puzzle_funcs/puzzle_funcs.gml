function room_setup_solved_state() {
    // Just manually set up what should be different when puzzle is solved
    switch(room) {
        //case rm_ruins_puzzle:
        //    // Destroy the door
        //    var _door = instance_find(obj_ruins_door, 0);
        //    if (instance_exists(_door)) instance_destroy(_door);
            
        //    // Move rocks to their solved positions
        //    var _rock1 = instance_find(obj_rock, 0);
        //    if (instance_exists(_rock1)) {
        //        _rock1.x = 200;
        //        _rock1.y = 150;
        //        _rock1.has_been_pushed = true;
        //    }
        //    break;
            
		case rm_sandbox:
		    for (var i = 0; i < instance_number(obj_puzzle_key_button); i++) {
		        var btn = instance_find(obj_puzzle_key_button, i);
		        btn.image_index = 1;
		    }
			 for (var i = 0; i < instance_number(obj_puzzle_lock_spike); i++) {
		        var lck = instance_find(obj_puzzle_lock_spike, i);
		        lck.image_index = 1;
				lck.active_and_enabled = false;
				lck.is_solved = true;
		    }
			
			instance_deactivate_object(inst_596D3D5B)
		break;

            break;
    }
}