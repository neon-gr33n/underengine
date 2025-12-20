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
		x += dx * spd * global.__delta_stepFactor
		y += dy * spd * global.__delta_stepFactor
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

#region Yellow Soul Variables
_charge_shot_delay=0;
_charge_timer=0;
z_charge=35;
#endregion