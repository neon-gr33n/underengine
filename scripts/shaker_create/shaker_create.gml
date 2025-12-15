function shaker_create(pObj,pVar,pMagitude,pInterval,pDecrease){
	var inst=instance_create(0,0,obj_shaker)
	inst._obj=pObj
	inst._vared=pVar
	inst._magnitude=pMagitude
	inst._shake_length=pInterval
	inst._shake_dec=pDecrease
}