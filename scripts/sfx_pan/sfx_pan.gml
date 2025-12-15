// This script pans the audio either to the left or right
function sfx_pan(){
///@arg soundid
///@arg priority
///@arg loop
///@arg pan

audio_falloff_set_model(audio_falloff_linear_distance);
return audio_play_sound_at(argument0, -median(-1, argument3, 1), 0, 0, 1, 0, 0, argument2, argument1);
}