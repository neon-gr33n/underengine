function room_setup_solved_state() {
    // Just manually set up what should be different when puzzle is solved
    switch(room) {
		// this is an example
        case rm_fallen:
            //// Destroy the door
            //var _door = instance_find(obj_ruins_door, 0);
            //if (instance_exists(_door)) instance_destroy(_door);
            
            //// Move rocks to their solved positions
            //var _rock1 = instance_find(obj_rock, 0);
            //if (instance_exists(_rock1)) {
            //    _rock1.x = 200;
            //    _rock1.y = 150;
            //    _rock1.has_been_pushed = true;
            //}
          break;
    }
}