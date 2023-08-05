#region Music
///@arg filename
// Loads an external music file and creates a stream
function mus_load(fname){
	var type=".ogg"
	return audio_create_stream(global.musfpath + fname + type);
}

///@arg streamid
// Denitializes an external music file and destroys the stream
function mus_stop(streamid){
	return audio_destroy_stream(streamid);
}

///@arg streamid
function mus_pause(streamid){
	return audio_pause_sound(streamid);	
}

function mus_resume_current() 
{
    if (global.currentmus != -4)
        mus_resume(global.currentmus)
    return;
}

///@arg streamid
function mus_resume(streamid){
	return audio_resume_sound(streamid);	
}

///@arg streamid
///@param {int} pitch
function mus_set_pitch(streamid,pitch=1){
	return audio_sound_pitch(streamid, pitch);
}	

///@arg streamid
///@param {int} volume
///@param {int} time
///@param {boolean} instant - is the fade over time or instantenous end of track?
/// Sets the volume of the given stream over a period of time
function mus_set_volume(streamid,volume=1,time=0,instant=false){
	return audio_sound_gain(streamid, volume, instant ? 0:(10 / room_speed) * 1000);
}

///@arg filename
///@param {boolean} loopable
///@param {int} volume
///@param {int} offset
///@param {int} pitch
function mus_playx(fname, loopable, volume=1, offset=0, pitch=1){
	global.currentmus=audio_play_sound(fname,global.muspriority,loopable,volume,offset,pitch);
	mus_set_pitch(global.currentmus,pitch);
	mus_set_volume(global.currentmus,volume);
}
	
///@arg filename
///@param {boolean} loopable
///@param {int} volume
///@param {int} pitch
///@param {int} time
function mus_playx_on(fname,loopable, volume=1, pitch=1, time=0){
	global.currentmus=audio_play_sound_on(global._gmu_emitter_bgm,filename,loopable,global.muspriority);
	mus_set_volume(global.currentmus,volume,time=0,instant=true);
	mus_set_pitch(global.currentmus, pitch);
	return music;
}

///@arg filename
function mus_is_playing(fname){
	return audio_is_playing(fname);
}
	
///@arg filename
function mus_is_current(fname) 
{
    if (global.currentmus == noone)
        return 0;
    switch fname
    {
        //case "yourgenosonghere":
        //    if (global.currentmus == "yourgenosonghere")
        //        return 1;
        default:
            return global.currentmus== fname;
    }

}

///@arg filename
///@param {boolean} loopable 
///@param {int} volume
///@param {int} pitch
///@param {int} time
function mus_lcplay(fname, loopable, volume=1, pitch=1, time=0) 
{
    var s = mus_load(fname)
    global.currentmus = s
    if (s == noone)
        return -4;
    return mus_playx(s, loopable,volume,pitch,time);
}


	
// Updates the master gain, and clears unecessary values from global.sfx_thisframe
function audio_update(){
	audio_emitter_gain(global._gmu_emitter_bgm, global.bgm_volume)
    audio_emitter_gain(global._gmu_emitter_sfx, global.sfx_volume)
    var c = audio_get_listener_count()
    for (var i = 0; i < c; i++)
    {
        var info = audio_get_listener_info(i)
        audio_set_master_gain(ds_map_find_value(info, "index"), global.master_volume)
        ds_map_destroy(info)
    }
    ds_list_clear(global.sfx_thisframe)
    return;	
}
#endregion
#region SFX
// This script plays a sound on a specific emitter.
function sfx_play(soundid, pitch = 1, volume = 1, offset = 0) {
	return audio_play_sound_on(global.sfxEmitter, soundid, false, 8, volume, offset, pitch);
}

function sfx_playc(soundid, pitch=1, volume=1, offset=0){
	return audio_play_sound(soundid,8,false,volume,0,pitch);	
}

// This script pans the audio either to the left or right
function sfx_pan(){
///@arg soundid
///@arg priority
///@arg loop
///@arg pan

audio_falloff_set_model(audio_falloff_linear_distance);
return audio_play_sound_at(argument0, -median(-1, argument3, 1), 0, 0, 1, 0, 0, argument2, argument1);
}

// This script stops a sound.
function sfx_stop(soundid) {
	return audio_stop_sound(soundid);
}

/// @arg soundid
/// @param level
/// @param time - The amount of time (in frames/ms) it takes to increase volume
function sfx_gain(soundid, level, time=0){
	return audio_sound_gain(soundid, level, time);
}

/// @arg soundid
/// @param pitch
function sfx_pitch(soundid,pitch=1){
	return audio_sound_pitch(soundid,pitch);
}

/// @arg soundid
function sfx_get_pitch(soundid){
	return audio_sound_get_pitch(_snd);	
}
#endregion