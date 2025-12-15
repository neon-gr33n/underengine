event_inherited(); // parent runs first and initializes defaults

puzzle_code = "231";
puzzle_flag = "test_puzzle";
solve_callback = on_solved;
image_speed = 0;

function on_solved(){
	camera_screenshake(30,0.6,0.5)
    sfx_play(snd_screenshake)

	image_index = 1;
	
	var t_scene_info = [
		[cutscene_dialogue,"gen",spr_blank,"* You did it!"],
		[cutscene_wait_for_dialogue],
	]
	
	create_cutscene(t_scene_info)
}