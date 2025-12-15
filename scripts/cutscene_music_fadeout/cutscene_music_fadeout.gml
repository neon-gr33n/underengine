function cutscene_music_fadeout(){
///@description cutscene_music_fadeout
///@arg time

gain = 0
audio_sound_gain(obj_music_handler.cutscenesong,gain,argument0)

currentgain = audio_sound_get_gain(obj_music_handler.cutscenesong)
if currentgain = gain 
{
	obj_music_handler.cutscenesong_pos = audio_sound_get_track_position(obj_music_handler.cutscenesong);
	audio_stop_sound(obj_music_handler.cutscenesong);
	cutscene_end_action();
}
}