/// @description Camera Movement

//State Machine for Camera
switch(camera_state) 
{
	
	case(cameraStates.SETUP):
		
		camera_set_position();
		
	break;
	
	case(cameraStates.HOLD):
		//Holds camera in place
		x = hold_x;
		y = hold_y;
		
	break;
	
	case(cameraStates.FOLLOW):
		
		//positions camera controller
		if instance_exists(following) 
		{
			//Follows player

			x = (global.camera_lerp ? lerp(x,following.x, follow_lerp_speed) : following.x);
			y = (global.camera_lerp ? lerp(y,following.y, follow_lerp_speed) : following.y);

			
		}
		
		//positions view
		camera_set_position();
	
	break;
	
	case(cameraStates.CENTER):
	
		//Keeps view centered on camera
		camera_set_view_pos(view, x - camera_get_view_width(view)/2, y - camera_get_view_height(view)/2);
	
		//Keeps camera centered in room
		x = room_width/2;
		y = room_height/2;
	
	break;
	
	case(cameraStates.DISABLE):
	
		view_visible[(object_index == obj_master_camera) ? global.master_view : player_number] = false;
	
	break;
	
}

if global.debug {
	if keyboard_check_pressed(vk_f12) {
		debugInfoShow = !debugInfoShow
	}
	if keyboard_check(vk_tab){
		camera_lerp_zoom(4,1)	
	}
	
	if keyboard_check(vk_bslash){
		camera_reset_zoom(2)
	}
}

execute_tween(id,"border_alpha",1, "linear", 0.3)

//show_debug_message("border index is: "+string(global._border_type_index))