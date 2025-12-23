line = 0;
finished = false;
lines_per_tick = 1;  // only remove 1 line per frame
vapor_delay = 2;     // number of frames to wait before next line
vapor_counter = 0;
pixel_scale = 1;

audio_play_sound(snd_dusted, 1, false);