if(live_call()) return live_result;
depth = -9999
image_speed = 0;
_inv = 0;
_hurting = 0;
_invTimer = 0;

#region DEFINE SOUL "MOVEMENT" STATE
stateSoulMovement = function()
{
	// Actual movement is handled in step
	currentState = "soulMoving"
	//event_user(1)
}	
#endregion

#region DEFINE SOUL "MENU" STATE
stateMenuSoul = function()
{
	// Soul will reset to "red" during this state
	currentState = "inMenu"	
}
#endregion

basicSoulMovement = function()
{
	spd = 2 - input.cancel;
	var dx = input.right - input.left
	var dy = input.down - input.up
	if place_meeting(x + dx, y + dy, obj_battle_wall) {
		repeat(spd * 10){
			if(!place_meeting(x,y-1,obj_battle_wall)){
				if input.up y -= 0.1
			}
			if(!place_meeting(x,y+1,obj_battle_wall)){
				if input.down { y+=0.1}
			}
			if(!place_meeting(x-1,y,obj_battle_wall)){
				if input.left {x-=0.2} 
			}
			if(!place_meeting(x+1,y,obj_battle_wall)){
				if input.right {x+=0.2}
			} else {
				// do nothing
			}
		}
	} else {
		x += dx * spd
		y += dy * spd
	}
}

setSoulAngle = function(argument0){
	image_angle = argument0	
}

// argument0 - Current value
// argument1 - Value to lerp to
// argument2 - Duration of the lerp
setSoulAngleSmoothed = function(argument0, argument1, argument2){
	image_angle = lerp(argument0,argument1,argument2)
}

// PLEASE NOTE:
// Blue and Green SOUL MODES are currently being implemented
// They are in an EXPERIMENTAL STATE and may need further revisions and polish

enum TYPES {
	RED = c_red,
	BLUE = c_blue,
	YELLOW = c_yellow
}

soul_type = TYPES.RED;
colour_change = noone;
stateSoulMovement();
currentState = "soulMoving";

_spritex = 0;
_spritey = 0;

returning = 0;

spd = 2;

#region Grazing Variables
_grazing = false;
_grazing_timer = 0;
_grazing_cooldown = 0;
_grazing_sprites = []; // Array to store grazing sprite instances
MAX_GRAZING_SPRITES = 1; // Limit simultaneous grazing effects
GRAZE_RADIUS = 24; // How close you need to be to graze (adjust as needed)
GRAZE_COOLDOWN = 60; // Frames between grazing the same bullet
#endregion

#region Grazing MP Recovery
_graze_mp_timer = 0;          // Timer for continuous grazing
_graze_mp_accumulator = 0;    // Accumulated MP to give
_graze_streak = 0;            // How many consecutive grazes
MAX_GRAZE_STREAK = 10;        // Max streak bonus
GRAZE_MP_BASE = 0.1;          // Base MP per graze frame
GRAZE_STREAK_BONUS = 0.05;    // Extra MP per streak level
MAX_MP_PER_GRAZE = 2;         // Max MP you can gain from one graze session
_current_graze_session = false;// Are we currently in a graze session?

function finalize_graze_mp_gain() {
    if (_graze_mp_accumulator > 0) {
		       // Cap the MP gain
		var mp_to_gain = min(_graze_mp_accumulator, MAX_MP_PER_GRAZE);

		// Round DOWN to nearest whole number
		mp_to_gain = floor(mp_to_gain);

		// Get current MP and max MP
		var member = global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0];
		var current_mp = global.PARTY_INFO[$ member][$ "STATS"][$ "MP"];
		var max_mp = global.PARTY_INFO[$ member][$ "STATS"][$ "MAX_MP"];

		// Only add MP if not at max and we have at least 1 MP to gain
		if (current_mp < max_mp && mp_to_gain >= 1) {
		    var new_mp = min(current_mp + mp_to_gain, max_mp);
    
		    // Use your member_set_stat function
		    member_set_stat(member, "MP", new_mp);
    
		    // Show feedback with whole numbers
		    show_debug_message("Gained " + string(mp_to_gain) + " MP from grazing! Total: " + string(new_mp));
		}
    }
    
    // Reset graze session
    _current_graze_session = false;
    _graze_mp_timer = 0;
    _graze_mp_accumulator = 0;
    _graze_streak = 0;
}
#endregion

#region Yellow Soul Variables
_charge_shot_delay=0;
_charge_timer=0;
z_charge=35;
#endregion