CAM.following = noone
with(CAM){
	x=0
	y=0
}

if border_get_enabled() == true && global._border_type_index == 1 {
	border_set_id("SIMPLE")
}