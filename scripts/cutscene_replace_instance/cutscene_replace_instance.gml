/**
 * Replaces one instance with another during a cutscene.
 * 
 * @example
 * // Replace obj_npc with obj_npc_happy at same position
 * cutscene_replace_instance(obj_npc, obj_npc_happy);
 * 
 * @param {instance} target_instance - Instance to be replaced/destroyed
 * @param {instance} replacer_instance - Instance to take its position
 */
function cutscene_replace_instance(){
///@description cutscene_replace_instance
///@arg target_instance
///@arg replacer_instance

var obj1 = argument0, obj2 = argument1;

obj2.x = obj1.x
obj2.y = obj1.y;

with obj1 {instance_destroy();}
cutscene_end_action();

}