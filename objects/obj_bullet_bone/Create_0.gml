/// @desc Initialize
event_inherited();

enum BONE_MODE {
	NOMOVE = c_aqua, // BLUE bone, you MUST avoid moving through this to avoid taking damage
	MOVE = c_orange,  // ORANGE bone, you MUST move through this to not take damage
	GEN = c_white   // Basic WHITE bone, always deals damage on contact (+ Karma where applicable)
}

_bone_angle = 0;
_bone_hspd = 0;
_bone_vspd = 0;

_bone_xscale = 1;
_bone_yscale = 1;
_bone_mode = BONE_MODE.GEN; // Default to basic white bone

_bone_sin = 0;
_bone_sinoffset = 0;
_bone_sinmultiplier = 0;

_is_circular = false; // Is this going to be a circle of bones?