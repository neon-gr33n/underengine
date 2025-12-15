draw_set_alpha(1)
draw_set_color(c_white)
draw_set_halign(fa_left)

save_config()
surface_free(global.pause_surf);
audio_resume_all()