if(_wiggle){
	_wiggle_sin+=1;
	if(_wiggle_sin%4==0){
	        _body_x = (sin((_wiggle_sin * 0.1)) * 1);
	        _body_y = (sin((_wiggle_sin * 0.2)) * 0.2);
	        _head_x = (sin((_wiggle_sin * 0.1)) * 1);
	        _head_y = (sin((_wiggle_sin * 0.2)) * 0.3);
	}
}else{
	_wiggle_sin=0;
}