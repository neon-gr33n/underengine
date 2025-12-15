TweenFire(self,EaseLinear,0,0,0,5,"image_xscale",image_xscale,1);
if rec_x>=420&&!done {
	TweenFire(self,EaseLinear,0,0,0,10,"rec_alpha",1,0);
	done=true
	instance_create_depth(global.enc_slot[enemyChoice].x-50,global.enc_slot[enemyChoice].y-50,-99999,battle_damage)
}