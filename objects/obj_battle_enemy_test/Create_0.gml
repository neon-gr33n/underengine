/// @desc Initialize
event_inherited();

counter = 0;

_body_x=0;
_body_y=0;
_body_image=0;
_body_speed=0.065;
_body_loop=true;

_wiggle=true;
_wiggle_sin=0;

_head_x=0;
_head_y=0;
_head_image=0;

instance_create_depth(0,0,0,obj_turn_intro_wildbones)

event_user(0)