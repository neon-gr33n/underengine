if currentState == "menuFightEye" || currentState == "menuFightAnim"
{
	draw_sprite_ext(spr_battle_fight_target_eye,0,320,300,target_xs,1,0,c_white,fightAlpha)
	for (i=0;i<array_length(bar_info[$ "INFO"]);i++)
		draw_sprite_ext(spr_battle_fight_target_reticle,rec_img[i],(rec_side[i]=="LEFT" ? rec_x[i] : 640-rec_x[i]),300,1,1,0,c_white,rec_alpha[i])
	if fight_anim_i >= 0 && fight_anim_i < 6 && dmg>0 {
		draw_sprite_ext(spr_battle_target_slice,fight_anim_i,global.enc_slot[enemyChoice].x,global.enc_slot[enemyChoice].y,1,1,0,c_white,1)
	}
}

draw_text(10,90,mercyChoice)
draw_text(10,110,HEART.currentState)
draw_text(10,130,currentState)
