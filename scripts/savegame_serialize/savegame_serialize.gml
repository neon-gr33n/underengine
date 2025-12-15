function savegame_serialize(buff){
	buffer_write(buff,buffer_u16,global.currentroom);
	buffer_write(buff,buffer_u32,global.time);
	buffer_write(buff,buffer_u8,global.fun);
	buffer_write(buff,buffer_u8,global.currentarea);
	buffer_write(buff,buffer_u16,ds_map_size(global.flags))
	for (var key=ds_map_find_first(global.flags);
	key != undefined; key=ds_map_find_next(global.flags,key))
	{
		buffer_write(buff,buffer_string,key);
		buffer_write(buff,buffer_s8, ds_map_find_value(global.flags,key));
	}
	return;
}