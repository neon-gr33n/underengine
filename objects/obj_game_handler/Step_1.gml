if(garbageTimer++ >= 30)
{
	garbageTimer = 0
	gc_collect()
}

// Update delta time
global.delta = _delta;

delta_step();