// create event - COMPLETE
hspeed = -1;
image_speed = 1;
depth = -9999

currentState = "inMenu";
__fleeResponse = "";

// Initialize layer sprite references
_sprite = -1;
_spritex = 0;
_spritey = 0;

sfx_play(snd_flee,1,global.sfx_volume);

fleeResponses = ds_list_create()
ds_list_add(fleeResponses,loc_gettext("bt.flee.0"))
ds_list_add(fleeResponses,loc_gettext("bt.flee.1"))
ds_list_add(fleeResponses,loc_gettext("bt.flee.2"))
ds_list_add(fleeResponses,loc_gettext("bt.flee.3"))
randomize();
r=irandom(ds_list_size(fleeResponses)-1);
ds_list_shuffle(fleeResponses) randomize(); 
__fleeResponse=string(ds_list_find_value(fleeResponses,r))