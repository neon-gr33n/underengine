///@desc Creates a bone with the given parameters
///@param xpos
///@param ypos
///@param angle
///@param hspd
///@param vspd
///@param xscale
///@param yscale
///@param mode
///@param sin
///@param sin_offset
///@param sin_multiplier
///@param circular?*
function create_bone(_xx = 0,_yy = 0,_angle = 0, _hspd = 0, _vspd = 0, _xxscale = 0, 
_yyscale = 0, _bmode = 0, _sin = 0, _sin_offset = 0, _sin_multiplier = 0, _bcircular = false)
{
	_xx  = argument0
	_yy  = argument1
	_angle = argument2
	_hspd =  argument3
	_vspd = argument4
	_xxscale = argument5
	_yyscale = argument6
	_bmode = argument7
	_sin = argument8
	_sin_offset = argument9
	_sin_multiplier = argument10
	_bcircular = argument11
	if _bcircular == true {
		var theta  = 0;
			repeat(16){
			var boner = instance_create_depth(lengthdir_x(120,theta),lengthdir_y(120,theta),0,obj_bullet_bone)
			with(boner) {
				x = _xx + lengthdir_x(64,theta)
				y = _yy + lengthdir_y(64,theta)
				_bone_angle  =  point_direction(obj_battle_soul.x/4,obj_battle_soul.y/4,x,y)
				_bone_hspd  = _hspd
				_bone_vspd  = _vspd
				_bone_xscale  = _xxscale
				_bone_yscale  = _yyscale
				_bone_mode  = _bmode
				_bone_sin = _sin
				_bone_sinoffset  = _sin_offset
				_bone_sinmultiplier  =_sin_multiplier
				_is_circular  = _bcircular
			}
			theta += 360/16
			}
	} else {
		var dong = instance_create_depth(_xx,_yy,0,obj_bullet_bone)	
		with(dong) {
				x = _xx
				y = _yy 
				_bone_angle  =  _angle
				_bone_hspd  = _hspd
				_bone_vspd  = _vspd
				_bone_xscale  = _xxscale
				_bone_yscale  = _yyscale
				_bone_mode  = _bmode
				_bone_sin = _sin
				_bone_sinoffset  = _sin_offset
				_bone_sinmultiplier  =_sin_multiplier
				_is_circular  = _bcircular
			}
	}
}