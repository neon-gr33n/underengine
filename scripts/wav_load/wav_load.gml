///audio_load_wav(fname)

function wav_load(){
	var _fname = global.musfpath+ string(argument0)+".wav";
	if (!file_exists(_fname))
	{
	    show_error("WAV File " + _fname + " does not exist!", true);
	    return -1;
	}
	else
	{
	    var _buffer = buffer_load(_fname);
	    var _soundret = wav_load_buffer(_buffer, 0);
	    buffer_delete(_buffer);
	    return _soundret;
	}
}