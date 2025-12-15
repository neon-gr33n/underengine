///@desc Update current Discord RPC details
///@arg location - string value, determines RPC details to display
function discord_set_location(location){
	if (!is_android())
	{
	    if (!instance_exists(obj_presence_handler))
	    {
	        obj = instance_create(0, 0, obj_presence_handler)
	        obj.location = location
	        obj.runonce = 1
	    }
	    else
	    {
	        obj_presence_handler.location = location
	        obj_presence_handler.runonce = 1
	    }
	}
}