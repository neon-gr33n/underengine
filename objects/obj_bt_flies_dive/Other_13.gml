/// @desc Turn End

instance_destroy(obj_bullet_fly);
battle_set_menu_state("menuBegin");
if (instance_exists(BOARD)) {
    BOARD.reset();
}
instance_destroy();