/**
 * Replaces the nearest instance of a type with another instance during a cutscene.
 * 
 * @example
 * // Replace nearest enemy with defeated version at player position
 * cutscene_replace_instance_nearest(obj_enemy, obj_enemy_defeated, player.x, player.y);
 * 
 * @param {object} target_instance - Object type to find and replace
 * @param {instance} replacer_instance - Instance to take its position
 * @param {number} x - X coordinate to search from
 * @param {number} y - Y coordinate to search from
 */
function cutscene_replace_instance_nearest(){
///@description cutscene_replace_instance_nearest
///@arg target_instance
///@arg replacer_instance
///@arg x
///@arg y

var obj1 = instance_nearest(argument2, argument3, argument0), obj2 = argument1;

obj2.x = obj1.x
obj2.y = obj1.y;

with obj1 {instance_destroy();}
cutscene_end_action();
}