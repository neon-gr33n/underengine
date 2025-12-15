image_alpha=0
execute_tween(id,"image_alpha",0.8,easetype.linear,1)

_menued=0;
_menudesc=["",""]

_menu_res_sel = 0;

_menu=0;

ini_open("settings.cfg")
_dmodec = ini_read_real("GRAPHICS","dmode",0);
_dmode = [loc_gettext("ui.config.graphics.windowed"),loc_gettext("ui.config.graphics.fullscreen"),loc_gettext("ui.config.graphics.borderless")]

_bmodec = ini_read_real("EXTRAS","border_mode",2);
_bmode = [loc_gettext("ui.extras.border_mode.static"),loc_gettext("ui.extras.border_mode.dynamic"),loc_gettext("ui.extras.border_mode.disabled")]

//global._border_id = ini_read_real("EXTRAS","border_id",0);
_bassetc = ini_read_real("EXTRAS","border_id",0);
_basset = [];
_basset = ["SIMPLE", "SEPIA", "FANCY"]
ini_close();

seconds=-1;
minutes=-1;
hours=-1;

ori_wid=global._windowed_width;
ori_hei=global._windowed_height;

// Check if we're already targeting a surface
var current_target = surface_get_target();
if (current_target != -1) {
    // Reset any existing surface target first
    surface_reset_target();
}


save_config()

function master_adjust_vol(){
	var _master =  global.master_volume;
	audio_master_gain(_master);
	global.mus_volume = _master
	global.sfx_volume = _master
	global.voice_volume = _master
}

var disp_height= window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface)
HEART.returning=0;
//HEART._spritex=30;
//HEART._spritey=disp_height/4+_menued*40-10;
//HEART.image_xscale=2;
//HEART.image_yscale=2;
//HEART.x=30;
//HEART.y=disp_height/6+_menued*40;
HEART.visible=true;

if (instance_exists(GJ)){
	instance_create(0,0,GJ)
}

//paused_surf = surface_create(room_width, room_height);