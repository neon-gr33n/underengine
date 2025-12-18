if(live_call()) return live_result;

//show_debug_message(currentState);
if (currentState == "soulMoving") {
	switch(soul_type){
		#region DEFAULT / RED SOUL
		case TYPES.RED:
			basicSoulMovement();
			setSoulAngle(0);
		break;
		#endregion
		#region YELLOW SOUL 
		case TYPES.YELLOW:
			basicSoulMovement();
			var CHARGE = input.action
			setSoulAngle(180);
			if !CHARGE && _charge_timer > 0 && _charge_timer <= 39 {
					var shot_inst = obj_yellow_shot;
					instance_create_depth(x, y - 10, HEART.depth, shot_inst);
					sfx_play(snd_ysoul_fire);
					_charge_shot_delay = 10;
				}
			if _charge_timer == 10 {
					audio_play_sound(snd_ysoul_charge, 8, true);
					audio_sound_pitch(snd_ysoul_charge, 0.1);
					audio_sound_gain(snd_ysoul_charge, 0, 0);
					audio_sound_gain(snd_ysoul_charge, 0.3, 20);
			} else if _charge_timer >= 10 && _charge_timer < 40
					audio_sound_pitch(snd_ysoul_charge, 0.1 + (_charge_timer - 20) / 20);
			else if _charge_timer >= 40 && _charge_timer < 180 {
					colour_change = c_white;
			if !CHARGE {
						audio_stop_sound(snd_ysoul_charge);
						sfx_play(snd_ysoul_blast);
						instance_create_depth(x, y - 10, HEART.depth, obj_yellow_shot, /*{_big_shot : 1}*/);
						_charge_timer = 0;
						_charge_shot_delay = 50;
					}
			} else if _charge_timer >= 180 {
					if !CHARGE {
						audio_stop_sound(snd_ysoul_charge);
						sfx_play(snd_ysoul_blast);
						instance_create_depth(x, y - 10, HEART.depth, obj_yellow_shot, 
						{
							_big_shot: true	
						});
						_charge_timer = 0;
						_charge_shot_delay = 200;
					}		
			} else {
					colour_change = noone;
					audio_stop_sound(snd_ysoul_charge);
				}						
			if _charge_timer < 180
				if _charge_shot_delay > 0 {
						_charge_shot_delay--;
						_charge_timer = 0;
			} else if CHARGE _charge_timer++;
				else _charge_timer = 0;
		break;
		#endregion
	}
	// MAIN COLLISION DETECTION WITH PROPER UNDERTALE-STYLE INVINCIBILITY
	// Only check for hits when not already invincible
	if (_hurting == 0 && place_meeting(x, y, obj_parent_bullet)) { 
		_hurting = 1;
		_invTimer = 60; // 60 frames = 2 seconds at 30 FPS
		image_speed = 0.3; // Increased for more visible flashing
		sfx_play(snd_hit);
		camera_screenshake(30, 0.6, 0.5);
		
		show_debug_message("HIT! Starting invincibility: " + string(_invTimer) + " frames");
	} 

	// Handle invincibility flashing - UNDERTALE STYLE
	if (_hurting == 1) {
		_invTimer--;
		
		// Flash the sprite with Undertale-style pattern
		if (_invTimer > 0) {
			// Undertale-style: Flash every 4 frames (2 on, 2 off)
			if (_invTimer % 4 < 2) {
				image_alpha = 0.3; // Very transparent during flash
				// Optional: Add color flash for better visibility
				// image_blend = c_white;
			} else {
				image_alpha = 0.7; // Less transparent
				// image_blend = c_red; // Your soul color
			}
			
			// Keep animation speed for sprite frames if any
			image_speed = 0.3;
		}
		
		// End invincibility
		if (_invTimer <= 0) {
			_hurting = 0;
			image_speed = 0;
			image_index = 0;
			image_alpha = 1; // Ensure fully visible
			// image_blend = c_white; // Reset blend color
			show_debug_message("Invincibility ended");
		}
	} else {
		// Normal state - ensure fully visible
		image_speed = 0;
		image_index = 0;
		image_alpha = 1.
		// image_blend = c_white;
	}
} else {
	image_speed = 0;
	image_index = 0;
	image_alpha = 1;
	// image_blend = c_white;
}

//show_message("hi")
if instance_exists(obj_ow_party) {
	if returning > 0 && !instance_exists(obj_battle_handler) {
			x = (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ? 640 : 0) + min(320, (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ? room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) : (true ? PLAYER1.x : obj_game_handler.player_pos[0][0])) * 2) * (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ?  -1 : 1);
			y = (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ? 480 : 0) + min(240, (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ? room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) : (true ? PLAYER1.y : obj_game_handler.player_pos[1][0])) * 2) * (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ?  -1 : 1) - PLAYER1.sprite_height * PLAYER1.image_yscale / 2;
		if returning > 1 {
				_spritex = (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ? 640 : 0) + min(320, (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ? room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) : (true ? PLAYER1.x : obj_game_handler.player_pos[0][0])) * 2) * (room_width - (true ? PLAYER1.x : obj_game_handler.player_pos[0][0]) < 320 ?  -1 : 1);
				_spritey = (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ? 480 : 0) + min(240, (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ? room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) : (true ? PLAYER1.y : obj_game_handler.player_pos[1][0])) * 2) * (room_height - (true ? PLAYER1.y : obj_game_handler.player_pos[1][0]) < 240 ?  -1 : 1) - PLAYER1.sprite_height * PLAYER1.image_yscale / 2;
			visible = global.danger;
		} else if abs(_spritex - x) < 5 && abs(_spritey - y) < 5
			returning = 2;
	}
	d_height = window_get_fullscreen() ? window_get_height() : surface_get_height(application_surface);
	 // x *= d_height / 480
	 // y *= d_height / 480
	 // _spritex *= d_height / 480
	 // _spritey *= d_height / 480
} else
	if !instance_exists(obj_battle_handler) && returning > 0
		visible = false;