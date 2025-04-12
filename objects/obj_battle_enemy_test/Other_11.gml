///@desc Battle Start
instance_create_depth(0,0,0,obj_cutscene_sansb_intro)
with(obj_cutscene_sansb_intro){
	scene_info = [ 
//		[cutscene_show_buttons,false],
		[cutscene_stretch_board,2,2,0.6],
		[cutscene_change_variable,obj_battle_handler,"currentState","frozen"]
	]	
}