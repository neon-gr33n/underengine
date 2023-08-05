if !variable_instance_exists(self,"persistant") {persistant = false}

create_cutscene(scene_info);
if persistant = false {instance_destroy();}