mus_stop(global.currentmus[0])

_shaking = true;
_shake = 0;
_choice  = 0;
displayChoices = ["Yes","No"];
displayChoiceOffsetX = [180-70, 180 + 220 + 70 + 95]
displayChoiceOffsetY = 332 + 35

_up=-190;
_down=480;
_alpha=0;
_message = ""
_font = "fnt_main_bt"
__writer = noone;

_showMsg = false
_showChoices = false;
_showDeath = false;

alarm[1]=40/image_speed;

function get_gameover_message()
{
	var plot = flag_get(global.flags,"plot")
	var name = string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "NAME"])
	// This function takes no arguments, simply fetches a relavant game over message
	switch(plot){
		case 0:
		case 1:
			_message = "[speed,0.5]"+name+"!"  + "#" + "You musn't give up yet."
		break;	
	}
}