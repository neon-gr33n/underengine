__font = loc_get_font("fnt_main_small")
__color = "c_white"
__text=[
	loc_gettext("intro.cut.0"), // In times long past,#two races reigned over#the peaceful EARTH- #MONSTERS and HUMANS.
	loc_gettext("intro.cut.1"), // One day, without warning-#a conflict broke out#between the two races.
	loc_gettext("intro.cut.2"), // Many MONSTERS were slain#but the HUMANS remained#victorious
	loc_gettext("intro.cut.3"), // QUEEN TORIEL surrendered as #the humans used a magic spell...
	loc_gettext("intro.cut.4"), // ...to seal the MONSTERs #underground for all eternity.
	loc_gettext("intro.cut.5"), // MT. EBBOT #202X[delay,10]
	loc_gettext("intro.cut.6"), // Today, that very same mountain# stands tall,the LEGENDs#carrying on throughout generations.
	loc_gettext("intro.cut.7"), // ...No one dares to#go near the mountain#as anyone who enters...
	loc_gettext("intro.cut.8"), // ...is said to never return.
    "[delay,10]",
    "[delay,10]",
    "[delay,400][alpha,0]"
]
_speed = 0.8;
_alpha = 1;
_sprite_alpha = 1;
_voiceSound = snd_writer_v
_duration = 290;
_currentText = ""; // Start blank

_index = 0;
_image_index = 0;
_start_delay = 5;
_fade_timer = 0;
_is_fading = false;
_image_changed = false;
_all_text_complete = false;

typist = scribble_typist();
// Don't start typing yet - text is blank
typewriter_state = 0;

depth=-999999999;

x += 120;

mus_playx(mus_load("story"),false,global.mus_volume,0,1,2)

// Start with the 5-second delay
alarm[0] = _start_delay;