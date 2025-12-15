if(_magnitude>0){
	if(!is_real(_shake_original)){
		_shake_original=variable_instance_get(_obj,_vared);
	}
	
	if(_shake_interval>0){
		_shake_interval-=1;
	}else{
		_shaked=random_range(-_magnitude,_magnitude);
		_shake_interval=_shake_length;
		_magnitude-=_shake_dec
	}
	variable_instance_set(_obj,_vared,_shake_original+_shaked);
	_shake_duration--
}else{
	variable_instance_set(_obj,_vared,_shake_original);
	instance_destroy();
}