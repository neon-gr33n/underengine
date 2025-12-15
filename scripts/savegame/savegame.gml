function savegame(){
	if(global.tempsave_buffer != noone && buffer_exists(global.tempsave_buffer)){
		buffer_delete(global.tempsave_buffer);
		global.tempsave_buffer=noone;
	}
	var saveid=global.filechoice;
	if (argument_count==1)
		saveid=argument[0]
	var buffOverall=buffer_create(512, buffer_grow, 1);
	buffer_write(buffOverall,buffer_u8,1);
	buffer_write(buffOverall,buffer_text,"UNDERENGINE")
	var buff = buffer_create(512,buffer_grow,1);
	savegame_serialize(buff);
	if (!global.just_reset){
	save_general(0);
	}
    buffer_copy(buff, 0, buffer_get_size(buff), buffOverall, buffer_tell(buffOverall))
	buffer_seek(buffOverall,buffer_seek_relative,buffer_get_size(buff))
	buffer_delete(buff)
	var json_string = json_stringify(global.PARTY_INFO);
	var bytes = string_byte_length(json_string);
	var buf = buffer_create(bytes, buffer_fixed, 1);
	buffer_write(buf, buffer_text, json_string);
    buffer_save(buf,("PARTYINFO" + string(saveid)));
	buffer_delete(buf)
	buffer_save(buffOverall,("file" + string(saveid)));
	buffer_delete(buffOverall)
	return;
}