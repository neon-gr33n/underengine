/// SUMMARY:
/// This object exists as a functional variant of the base obj_music_handler
/// allowing you the "USER" to be able to load your music files from included files (and have better control over organization)
/// at the cost of increasing the amount of storage used by the game on build since music loaded from included files CANNOT be compressed
/// or have its filesize otherwise reduced further then it was already upon export, you would have to manually handle optimization inside of 
/// your DAW if you really wish to keep file sizes low even using this option

areasong = ""
areasong_loopable = true; // disable if you don't want a song to loop 
areasong_pos = 0;
areasong_pitch = 1;
sprite_index=noone;

cutscenesong = ""
cutscenesong_loopable = true; // disable if you don't want a song to loop 
cutscenesong_pos = 0;
cutscenesong_pitch = 1;

battlesong = 0;
battlesong_pos = 0;
battlesong_pitch = 1;


song_volume = 0.6;

newsong = 0;

visible=false;