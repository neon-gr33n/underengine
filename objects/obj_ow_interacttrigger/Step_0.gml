if !variable_instance_exists(self,"persistant") {persistant = false}

if point_distance(x,y,PLAYER1.x,PLAYER1.y) < preferredDistance && inputdog_pressed("select") && canInteract && !inInteraction
{
	create_cutscene(scene_info);
	inInteraction = true; // We're now interacting
	if persistant = false {instance_destroy();}
}