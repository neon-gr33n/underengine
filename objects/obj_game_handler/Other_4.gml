///@desc Update Current Room Index
global.currentroom=room;
room_persistent = false;

tempsave()

// On room start, check puzzle flags and set up the room accordingly
#region Handle puzzle stuff
var _puzzles = instance_find(obj_puzzle_lock, 0);
while (_puzzles != noone) {
    if (_puzzles.puzzle_flag != "" && flag_get(global.flags, _puzzles.puzzle_flag)) {
        // This puzzle was solved - do whatever you need for this specific room
        room_setup_solved_state();
    }
    _puzzles = instance_find(obj_puzzle_lock, _puzzles);
}
#endregion