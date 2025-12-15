/**
 * Starts an encounter during a cutscene
 * 
 * @param {string} encounter - Encounter identifier or name
 * @param {string} mus_id - Music track ID to play during encounter
 * @param {number} mus_pitch - Music pitch (1.0 = normal)
 * @param {boolean} exclaim - Show exclamation mark before encounter
 * @param {boolean} quick - Quick transition (skips some animations)
 * @param {boolean} boss - Whether this is a boss encounter
 */
function cutscene_start_encounter(encounter,mus_id,mus_pitch,exclaim, quick, boss){
	encounter_start(encounter,mus_id,mus_pitch,exclaim, quick, boss);
	cutscene_end_action();
}