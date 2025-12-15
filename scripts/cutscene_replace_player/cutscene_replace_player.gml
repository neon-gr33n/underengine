
function cutscene_replace_player(){
///@description cutscene_replace_player
///@arg replacer_instance

var obj = argument0

obj.x = obj_ow_party.x
obj.y = obj_ow_party.y;

with obj_ow_party {x = -2000; y = -2000;}
cutscene_end_action();

}