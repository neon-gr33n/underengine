function create_cutscene(){
///@description create_cutscene(scene_info) - Creates a cutscene using the given scene_info argument
///@arg scene_info

var inst = instance_create_layer(0,0,"Instances",obj_cutscene_handler)
with(inst) 
{
		scene_info = argument0;
	//	PLAYER.cutscene_paused=true;
		event_perform(ev_other, ev_user0);
}

}