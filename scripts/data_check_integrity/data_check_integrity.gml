function data_check_integrity(){
	  if (global.osflavor != 1 && os_type != os_macosx)
    {
        if ((!directory_exists("data")) || (!directory_exists("data/mus"))) //|| (!directory_exists("data/lang")))
            return 0;
    }
    global.integrity_fail = ""
    var musicList = ["battle"] // Populate with you own music files
    var l = array_length(musicList)
    for (var i = 0; i < l; i++)
    {
        if (!(file_exists(((global.musfpath + musicList[i]) + ".ogg"))))
        {
            global.integrity_fail = musicList[i]
            return 0;
        }
    }
    return 1;	
}