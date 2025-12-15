function cutscene_music_play(){
///@description cutscene_music_play
///@arg index
///@arg loops?
///@arg startgain
///@arg pitch


index = argument0;
loops = argument1;

mus_playx(mus_load(index),loops,argument2,0,argument3,2);

cutscene_end_action();
}