/// @desc Update State + Depth Sorting
if currentState == "playerMoveGen" {
	xAxis = input.right - input.left;
	yAxis = input.down - input.up;

	// Run speed acceleration logic
	var _is_running = (global.auto_sprint ? !input.cancel : input.cancel) && global.running_enabled;
	var _max_run_speed = 4;
	var _acceleration_rate = 0.1/3; // Adjust this to control how fast speed increases
	var _deceleration_rate = 0.2/2; // Adjust this to control how fast speed decreases
	var inst = noone;

	if (_is_running && (xAxis != 0 || yAxis != 0)) {
	    // Gradually increase run_speed when running and moving
	    run_speed = min(run_speed + _acceleration_rate, _max_run_speed);
		if (run_speed == 4){
			inst =instance_create_depth(x, y, depth + 1, obj_afterimage, 
			{
				sprite_index: sprite_index,
				image_alpha: 0.25,
				fadeSpeed: 0.02,
				hspeed: 2 * 0.5,
				image_index: image_index,
				image_speed: 0	
			});	
		}
		} else {
	    // Gradually decrease run_speed when not running or not moving
	    run_speed = max(walk_speed, run_speed - _deceleration_rate);
		if instance_exists(inst){
			instance_destroy(inst)	
		}
	}

	var mvspeed = walk_speed + _is_running * (run_speed - walk_speed);
	//todo: make smooth camera move a bit faster when running
	image_speed = 1;

	hsp = xAxis * mvspeed;
	vsp = yAxis * mvspeed;

	var _si = sprite_index;
	var _ii = image_index;

	sprite_index = spr_frisk_hitbox;
	image_index = 0;
	if (canMove) {
	    move_and_collide(hsp, 0, obj_solid, mvspeed)  
	    move_and_collide(0, vsp, obj_solid, mvspeed)  
		
		if (instance_exists(obj_random_encounter_handler) &&  xAxis != 0 || yAxis != 0 && !encounterStarted){
			with(obj_random_encounter_handler){
					check_encounter_step();
			}
		}
	}
	sprite_index = _si;
	image_index = _ii;

	//PLAYER FOLLOWERS
	if (x != xprevious or y != yprevious) {
	    for (i = 75; i > 0; i--) {
	        remx[i] = remx[(i - 1)];
	        remy[i] = remy[(i - 1)];
	        remdir[i] = remdir[(i - 1)];
	    }
	    remx[0] = x;
	    remy[0] = y;
	    remdir[0] = (sprite_index == spriteIdle ? remdir[1] : image_index);
	}

	if (input.menu_pressed && !instance_exists(obj_settings)) {
	    instance_create_depth(0, 0, -9999, obj_cmenu);
	}

	//ANIMATION
	var _old_sprite = sprite_index;
	if ((abs(xAxis) || abs(yAxis)) && currentState == "playerMoveGen") {
	    if abs(x - xprevious) + abs(y - yprevious) > 0 {
	        sprite_index = spriteMove;
	        direction = point_direction(0, 0, x - xprevious, y - yprevious)
	    } else {
	        sprite_index = spriteIdle;
	    }
	    if (_is_running && abs(x - xprevious) + abs(y - yprevious) > 0) {
	        sprite_index = spriteRun;	
	    }
	} else { sprite_index = spriteIdle; }
	if (_old_sprite != sprite_index) local_frame = 0;

	switch dir {
	    case "down":
	        direction = 270;
	        break;
	    case "up":
	        direction = 90;
	        break;
	    case "right":
	        direction = 360;
	        break;
	    case "left": 
	        direction = 180;
	        break;
	}

	player_animate_sprite();
} 

if currentState == "inCutscene" 
{
	if (abs(x-xprevious)+abs(y-yprevious)>0) {
		for (i = 75; i > 0; i--){
		    remx[i] = remx[(i - 1)];
		    remy[i] = remy[(i - 1)];
			remdir[i] = remdir[(i - 1)];
		}
		remx[0] = x;
		remy[0] = y;
		remdir[0]=(sprite_index==spriteIdle ? (image_index*4) : image_index)
		sprite_index = spriteMove;
	} else {
		sprite_index = spriteIdle;
	}
	
	switch dir {
		case "down":
			direction = 270;
		break;
		case "up":
			direction  = 90;
		break;
		case "right":
			direction  = 360;
		break;
		case "left": 
			direction  = 180;
		break;
	}
	
	player_animate_sprite();
	// * I.. I CAN'T DO ANYTHING
	// * MY LEGS ARE FUCKIN' BROKEN
	// * I'M IN A GODDAMNED WHEELCHAIR
}

if currentState == "sitting" 
{
	image_alpha = 0;	
	canMove = false;
}

if currentState == "sliding" 
{
	image_alpha = 0;	
	canMove = false;
}


//show_debug_message(string(remdir[0]))
///@desc Depth Sorting
depth = -2000-y;
party_size=array_length(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"])

//if instance_exists(obj_game_handler) obj_ow_party.image_blend=c_white else obj_ow_party.image_blend=c_red

var outlineColor = shader_get_uniform(shd_danger,"outlineColor")
shader_set_uniform_f(outlineColor, 1,0,0,1 )
var outlineW = shader_get_uniform(shd_danger,"pixelW")
shader_set_uniform_f(outlineW, texture_get_texel_width(sprite_get_texture(sprite_index,0)))
var outlineH = shader_get_uniform(shd_danger,"pixelH")
shader_set_uniform_f(outlineH, texture_get_texel_height(sprite_get_texture(sprite_index,0)))

//if layer_exists(layer_get_id("party0")) layer_destroy(layer_get_id("party0"))
//layer_create(-2001-y,"party0")
//layer_shader(layer_get_id("party0"),Shader8)
//layer_script_begin(layer_get_id("party0"),)
//_temp=layer_sprite_create(layer_get_id("party0"),x,y,sprite_index);
//layer_sprite_index(_temp,(sprite_index==spriteIdle ? floor(remdir[0]/4) : remdir[0]));
shader_set(shd_danger);
//draw_self();
shader_reset();


if party_size>1 {
	for (i=1;i<party_size;i++) {
		
		if layer_exists(layer_get_id("party"+string(i))) layer_destroy(layer_get_id("party"+string(i)))
		layer_create(-2001-remy[i*25],"party"+string(i))
		//layer_shader(layer_get_id("party"+string(i)),shd_danger)
		
		_temp=layer_sprite_create(layer_get_id("party"+string(i)),remx[i*25],remy[i*25],global.PARTY_INFO[$(global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][i])][$"SPRITES"][$(sprite_index==spriteIdle ? "IDLE" : "MOVE")])
		layer_sprite_index(_temp,(sprite_index==spriteIdle ? floor(remdir[i*25]/4) : remdir[i*25]))
	}
}

spriteIdle = global.PARTY_INFO[$ (global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0])][$ "SPRITES"][$ "IDLE"];
//show_debug_message(spriteIdle)
spriteMove = global.PARTY_INFO[$ (global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0])][$ "SPRITES"][$ "MOVE"];