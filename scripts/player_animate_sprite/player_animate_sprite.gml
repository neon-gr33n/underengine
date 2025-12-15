function player_animate_sprite()
{

//Update Sprite
var _cardinal_direction = round(direction/90);
var _total_frames = sprite_get_number(sprite_index) / 4;
local_frame %= _total_frames;
image_index = floor(local_frame) + (_cardinal_direction * _total_frames);
local_frame += sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps) / 4;

//If animation would loop on next game step
if (local_frame >= _total_frames)
{
	animation_end = true;
	local_frame -= _total_frames;
}
else animation_end = false;

}