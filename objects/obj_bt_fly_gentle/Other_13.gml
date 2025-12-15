/// @desc Turn End

with (obj_bullet_fly) {
        instance_destroy();
}
battle_set_menu_state("menuBegin");
if (instance_exists(BOARD)) {
    BOARD.reset();
}
instance_destroy();