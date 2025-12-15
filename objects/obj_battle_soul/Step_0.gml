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

#region Deltarune-esque bullet grazing effect with MP recovery
	if (_grazing_cooldown > 0) {
	    _grazing_cooldown--;
	}

	// Check for grazing near bullets - ONLY WHEN NOT INVINCIBLE
	if (_grazing_cooldown == 0 && _hurting == 0) {
	    // Use collision_circle for more reliable detection
	    var near_bullets = collision_circle(x, y, GRAZE_RADIUS, obj_parent_bullet, false, true);
    
	    if (near_bullets != noone) {
	        // Check each nearby bullet
	        var bullet = near_bullets;
	        var processed = 0;
        
	        while (bullet != noone && processed < 10) { // Limit checks for safety
	            // Make sure we're not actually colliding
	            if (!place_meeting(x, y, bullet)) {
	                // Check graze cooldown
	                var can_graze = true;
	                if (variable_instance_exists(bullet, "_last_graze")) {
	                    can_graze = (bullet._last_graze <= 0);
	                }
                
	                if (can_graze) {
	                    // Trigger graze
	                    _grazing = true;
	                    _grazing_timer = 15; // Longer visual feedback
	                    _grazing_cooldown = 5;
                    
	                    // Start or continue graze session for MP recovery
	                    if (!_current_graze_session) {
	                        // New graze session
	                        _current_graze_session = true;
	                        _graze_streak = 1;
	                        _graze_mp_timer = 0;
	                        _graze_mp_accumulator = 0;
	                        show_debug_message("Starting new graze session");
	                    } else {
	                        // Continuing graze session
	                        _graze_streak = min(_graze_streak + 1, MAX_GRAZE_STREAK);
	                        show_debug_message("Continuing graze session. Streak: " + string(_graze_streak));
	                    }
                    
	                    // Initialize _last_graze if not exists
	                    if (!variable_instance_exists(bullet, "_last_graze")) {
	                        bullet._last_graze = 0;
	                    }
	                    bullet._last_graze = GRAZE_COOLDOWN;
                    
	                    // Create effect
	                    var graze_sprite = instance_create_depth(x, y, depth - 1, obj_graze_effect);
	                    graze_sprite.image_index = 0;
                    
	                    // Play sound
	                    audio_play_sound(snd_graze, 10, false);
                    
	                    show_debug_message("GRAZE SUCCESS at distance: " + string(point_distance(x, y, bullet.x, bullet.y)));
	                    break;
	                }
	            }
            
	            // Get next bullet
	            bullet = collision_circle(x, y, GRAZE_RADIUS, obj_parent_bullet, false, true);
	            processed++;
	        }
	    }
	}
	
	// Update continuous grazing MP accumulation
	if (_current_graze_session) {
	    _graze_mp_timer++;
	    
	    // Calculate MP gain for this frame
	    var mp_gain_this_frame = GRAZE_MP_BASE + (_graze_streak * GRAZE_STREAK_BONUS);
	    _graze_mp_accumulator += mp_gain_this_frame;
	    
	    // Show visual feedback for active grazing (optional)
	    if (_graze_mp_timer % 15 == 0) { // Every 15 frames
	        show_debug_message("Grazing... MP accumulated: " + string(round(_graze_mp_accumulator * 10) / 10) + 
	                          ", Streak: " + string(_graze_streak));
	    }
	    
	    // End graze session if no graze for 20 frames
	    if (_graze_mp_timer > 20) {
	        // Finalize MP gain
	        finalize_graze_mp_gain();
	    }
	} else if (_graze_mp_accumulator > 0) {
	    // If we left graze session with accumulated MP
	    finalize_graze_mp_gain();
	}
#endregion

	// Update bullet graze cooldowns
	var bullets = instance_find(obj_parent_bullet, 0);
	var bullet_count = 0;
	while (bullets != noone) {
	    if (variable_instance_exists(bullets, "_last_graze") && bullets._last_graze > 0) {
	        bullets._last_graze--;
	    }
	    bullets = instance_find(obj_parent_bullet, bullet_count);
	    bullet_count++;
	}
	
	// Clean up expired graze sprites
	for (var i = array_length(_grazing_sprites) - 1; i >= 0; i--) {
	    if (!instance_exists(_grazing_sprites[i])) {
	        array_delete(_grazing_sprites, i, 1);
	    }
	}
	
	// Update grazing visual feedback
	if (_grazing) {
	    _grazing_timer--;
	    if (_grazing_timer <= 0) {
	        _grazing = false;
	    }
	}

	// MAIN COLLISION DETECTION WITH PROPER UNDERTALE-STYLE INVINCIBILITY
	// Only check for hits when not already invincible
	if (_hurting == 0 && place_meeting(x, y, obj_parent_bullet)) { 
		// Reset any ongoing graze session first
		if (_current_graze_session) {
			show_debug_message("Graze session broken by hit!");
			finalize_graze_mp_gain(); // Give accumulated MP before resetting
		}
		
		_hurting = 1;
		_invTimer = 60; // 60 frames = 2 seconds at 30 FPS
		image_speed = 0.3; // Increased for more visible flashing
		sfx_play(snd_hit);
		camera_screenshake(30, 0.6, 0.5);
		
		// Apply damage here (if you have HP system)
		// global.player_hp -= damage_amount;
		
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
	// Not in soulMoving state - reset graze session
	if (_current_graze_session) {
		finalize_graze_mp_gain();
	}
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