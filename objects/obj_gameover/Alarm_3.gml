///@desc Show GameOver Text
TweenFire(id,EaseInOutCubic,0,0,0,45,"_up",-190,100)
TweenFire(id,EaseInOutCubic,0,0,0,45,"_down",-190,180)
TweenFire(id,EaseInOutCubic,0,0,0,60,"_alpha",0, 1)

// todo: finish "Determination" equivalent (using the one from Undertale as a placeholder)
 mus_playx(mus_load("determination"),true,1,0,0.95,2)

get_gameover_message()
alarm[4]= 60