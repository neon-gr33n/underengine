function timer_setup(_unit = "s", _timer_index = undefined, _duration){
	///@desc Creates a timer, dependant on the unit, and assigns the given duration to allow the timer to function
	///@arg unit - The unit of time  (can be "s" for seconds or "ms" for milliseconds)
	///@arg obj - What specific timer should be called? (each timer object contains unique events, 
	///ensure you are calling the one you desire, if it doesn't exist yet, create it! it's very simple)
	///@arg duration - The length to set the timer for
	if _unit == "s"{ 
		instance_create(0,0,_timer_index)
		if instance_exists(_timer_index) {
			with(_timer_index){
				time_unit = time.s
				timer_length = _duration 
			}
		}
	} else if _unit =="ms" {
		instance_create(0,0,_timer_index)
		if instance_exists(_timer_index) {
			with(_timer_index){
				time_unit = time.ms
				timer_length = _duration 
			}
		}	
	}
}