global.asp_ratio	= 0	// 0 - 4:3 (Default)  1 - 16:9 (Ideal for recording or wide screen displays, some of which may lack support for 4:3)
 global.input_device = "keyboard"
 global.ploaded = 0
 global.was_reset = false;
 global.just_reset = false;
#region Variables

sprite_index=noone;

hideScreen=false
screenXOffset = 0; 
screenYOffset = 0; 
screenWidth = 1; 
screenHeight = 1;

screenXScale  = 0;
screenYScale = 0;

garbageTimer=0;
guiSurface = undefined;
performanceInfo = false;

ticks=0;
minutes=0;
seconds=0;
drawnseconds=0;
drawmninutes=0;

holdTimer=0;
holdAlpha=0;
holdIndex=0;

global.delta = 0;

_delta = delta_time/1000000;
#endregion

audio_group_load(mus)
audio_group_load(sfx)

instance_create(0,0,obj_mobile_ui);

//function defaultDrawScreen()
//{
//	if surface_exists(application_surface) {
//		draw_surface_ext(application_surface,screenXOffset,screenYOffset,screenXScale,screenYScale,0,c_white,1)	
//	}
//	return;
//}

function checkShaderSupport(){
	if(shaders_are_supported()){
		// add additional shader sepecific checks here
	} else {
	    show_error("Your computer doesn't seem to either support shaders or your graphics drivers are outdated.\nTry running DirectX and see if the problem fixes itself.\n"
		+ "https://www.microsoft.com/en-us/download/details.aspx?displaylang=en&id=35\n" + "If the problem continues, then your computer doesn't support the shaders required to run this game currently.", 1)
	}
	
}

if __UNDERENGINE_LOGGING {
	show_debug_message("[UNDERENGINE] Initializing... " + "underengine " + __UNDERENGINE_VERSION)	
}

// Execute any necessary functions - initialize data
game_init();

 loc_debug_csv_structure();

event_user(0);