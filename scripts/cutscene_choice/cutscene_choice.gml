// I'll be blunt, this would be worth revising at some point, making it easier to add new options and such
function cutscene_choice(_text = "", _choice0 = "Yes", _choice1 = "No", _func0 = function(){}, _func1 = function(){}, _text_level=0, _preselected = 0){
	///@arg text
	///@arg choice_0
	///@arg choice_1
	///@arg func_0*
	///@arg func_1*
	///@arg text level*
	///@arg default*
	if !instance_exists(obj_choice_text) {
		instance_create(x,y,obj_choice_text)
	} with(obj_choice_text) {
		displayChoiceLabel = _text
		displayChoices = [_choice0, _choice1]
		outputChoices = [_func0, _func1]
		level = _text_level
		selection = _preselected
	}
	cutscene_end_action()
}