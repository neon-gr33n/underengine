//draw_self();
///@desc Process States
if(live_call()) return live_result;
if (global.debug){
	draw_text(600, 20, _charge_timer)
	draw_text(600, 30, input.action)
	draw_text(600, 40, _charge_shot_delay)
}
	
if !instance_exists(obj_battle_handler) && room != rm_soul_tester {
	if abs(_spritex-x)+abs(_spritey-y)!=0 {
		_spritex+=(x-_spritex)/8
		_spritey+=(y-_spritey)/8
		//if abs(_spritex-x)<1
		//	_spritex=x
		//if abs(_spritey-y)<1
		//	_spritey=y
	}
	depth=-9999
	draw_sprite_ext(sprite_index,image_index,_spritex,_spritey,image_xscale,image_yscale,image_angle,soul_type,image_alpha)
	switch(soul_type){
		case TYPES.YELLOW:
			if (_charge_timer  >= 15)
		    {
		        z_charge = (_charge_timer - 15)
		        if (z_charge >= 35)
		            z_charge = 35
		        for (i = 0; i < 4; i += 1)
		        {
		           var  rotx = ((i * 90) + (z_charge * 5))
		            var xx = (sin(degtorad(rotx)) * (35 - z_charge))
		            var yy = (cos(degtorad(rotx)) * (35 - z_charge))
		            draw_sprite_ext(spr_yellow_charge, 0, ((x-6) - xx), ((y-6) - yy), (4 - ((z_charge * 2) / 35)), (4 - ((z_charge * 2) / 35)), 0, c_white, (z_charge / 5))
		        }
			}
		break;
	}
} 
