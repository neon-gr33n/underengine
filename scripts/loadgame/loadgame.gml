function loadgame()
{
	gotogamebroke=0
	var saveid=global.filechoice;
    if (argument_count >= 1)
    {
        var saveid = argument[0]
		 if (argument_count >= 2)
            var gotogamebroke = argument[1]
        else
            gotogamebroke = 1
    }
	if !file_exists("file" + string(saveid))
		return;
	var buff = buffer_load(("file" + string(saveid)))
	var v = buffer_read(buff, buffer_u8)
	if (buff == -1 || buffer_get_size(buff) < 21)
    {
		 global.gamebroke = 2
         if gotogamebroke
            room_goto(rm_gamebroke)
        buffer_delete(buff)
        return;
    }
    if (chr(buffer_read(buff, buffer_u8)) != "S" || chr(buffer_read(buff, buffer_u8)) != "W" || chr(buffer_read(buff, buffer_u8)) != "A" 
	|| chr(buffer_read(buff, buffer_u8)) != "P"|| chr(buffer_read(buff, buffer_u8)) != "P"|| chr(buffer_read(buff, buffer_u8)) != "E") 
	|| chr(buffer_read(buff, buffer_u8)) != "D" || chr(buffer_read(buff, buffer_u8)) != "M" || chr(buffer_read(buff, buffer_u8)) != "Y" || chr(buffer_read(buff, buffer_u8)) != "T" || chr(buffer_read(buff, buffer_u8)) != "H"
    {
       //global.gamebroke = 2
      //  if gotogamebroke
     //       room_goto(rm_gamebroke)
        buffer_delete(buff)
        return;
    }
    loadgame_unserialize(buff, gotogamebroke)
	var buf = buffer_load("PARTYINFO"+string(saveid));
	var json = buffer_read(buf, buffer_text);
	global.PARTY_INFO = json_parse(json);
	show_debug_message(global.PARTY_INFO)
	//buffer_delete(newBuff);
	buffer_delete(buff);
	global.ploaded = 1;
	room_goto(global.currentroom==-1 ? rm_fallen : global.currentroom)
    return;
}