function cutscene_choice(_choice0 = "Yes", _choice1 = "No", _preselected = 0){
	///@arg choice_0
	///@arg choice_1
	///@arg default*
	if !instance_exists(obj_choice_text)
	{
		instance_create(x,y,obj_choice_text)	
	} else with(obj_choice_text){
		displayChoices = [_choice0, _choice1]
		selection = _preselected
	}
}