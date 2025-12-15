// Inherit the parent event
event_inherited();
if input.action_pressed {
	flag_set(global.flags,"geno",1);
	alarm[0] = 1;	
}