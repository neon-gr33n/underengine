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