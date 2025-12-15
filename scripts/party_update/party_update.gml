function party_update(){
	if instance_exists(obj_ow_party) {
		var _x = obj_ow_party.x;
		var _y = obj_ow_party.x;
		var _dir = obj_ow_party.image_index;
		instance_destroy(obj_ow_party);
		instance_create_depth(_x,_y,0,obj_ow_party,{image_index : _dir})
		return true;
	} else
		return false;
}