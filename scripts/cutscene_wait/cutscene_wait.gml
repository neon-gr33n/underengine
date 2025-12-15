/**
 * Pauses cutscene progression for a specified time.
 * 
 * @example
 * // Wait 2 seconds before next cutscene action
 * cutscene_wait(2);
 * 
 * @example
 * // Wait half a second
 * cutscene_wait(0.5);
 * 
 * @param {number} seconds - Time to wait in seconds
 */
function cutscene_wait(){
	///@description cutscene_wait
	///@arg seconds

	timer++;
	if (timer >= argument0 * game_get_speed(gamespeed_fps)) {timer = 0; cutscene_end_action();}
}