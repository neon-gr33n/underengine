if currentState == "menuBegin"
{
	#region PROCESS MENU VISUAL EVENTS
	with obj_text_writer { visible = true } // temporarily re-enable the writer
	switch(battleMenuSelection){
		#region FIGHT SELECTED
		case 0:
			if(battleButtonTweenable){
				with(ACT){
					image_index = 0;	
					image_blend = c_gray;
				}
				with(ITEM){
					image_blend = c_gray;	
				}
				with(MERCY){
					image_blend = c_gray;
				}
				with(FIGHT){
					image_index = 1;
					image_blend = c_white;
				}
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"y",FIGHT.y,406);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"x",FIGHT.x,10);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"image_xscale",FIGHT.image_xscale,1.5);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"image_yscale",FIGHT.image_yscale,1.5);
				
				TweenFire(HEART,EaseLinear,0,0,0,15,"y",HEART.y,421);
				TweenFire(HEART,EaseLinear,0,0,0,15,"x",HEART.x,20);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_xscale",HEART.image_xscale,2);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_yscale",HEART.image_yscale,2);
				
				TweenFire(ACT,EaseLinear,0,0,0,15,"y",ACT.y,416);
				TweenFire(ACT,EaseLinear,0,0,0,15,"x",ACT.x,179);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_xscale",ACT.image_xscale,1);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_yscale",ACT.image_yscale,1);
			} else {
				with(FIGHT){
					image_index = 1;
				}
				with(ACT){
					image_index = 0;	
				}
				with(HEART){
					x = 28;
					y = 429;
				}
			}
		break;
		#endregion
		#region ACT SELECTED
		case 1:
			if(battleButtonTweenable){
				with(FIGHT){
					image_index = 0;
					image_blend = c_gray;
				}
				with(ITEM){
					image_index = 0;
					image_blend = c_gray;
				}
				with(MERCY){
					image_blend = c_gray;	
				}
				with(ACT){
					image_index = 1;	
					image_blend = c_white;
				}
				TweenFire(ACT,EaseLinear,0,0,0,15,"y",ACT.y,406);
				TweenFire(ACT,EaseLinear,0,0,0,15,"x",ACT.x,155);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_xscale",ACT.image_xscale,1.5);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_yscale",ACT.image_yscale,1.5);
				
				TweenFire(HEART,EaseLinear,0,0,0,15,"y",HEART.y,421);
				TweenFire(HEART,EaseLinear,0,0,0,15,"x",HEART.x,168);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_xscale",HEART.image_xscale,2);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_yscale",HEART.image_yscale,2);
				
				#region FREE DESELECTED BUTTONS FROM TWEENING
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"y",FIGHT.y,416);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"x",FIGHT.x,20);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"image_xscale",FIGHT.image_xscale,1);
				TweenFire(FIGHT,EaseLinear,0,0,0,15,"image_yscale",FIGHT.image_yscale,1);
				
				TweenFire(ITEM,EaseLinear,0,0,0,15,"y",ITEM.y,416);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"x",ITEM.x,339);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_xscale",ITEM.image_xscale,1);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_yscale",ITEM.image_yscale,1);
				#endregion
			} else {
				with(FIGHT){
					image_index = 0;
				}			
				with(ITEM){
					image_index = 0;
				}
				with(ACT){
					image_index = 1;
				}
				with(HEART){
					x = 190;
					y = 429;
				}
			}
		break;
		#endregion
		#region ITEM SELECTED
		case 2:
			if(battleButtonTweenable){
				with(ACT){
					image_index = 0;	
					image_blend = c_gray;
				}
				with(MERCY){
					image_index = 0;	
					image_blend = c_gray;
				}
				with(ITEM){
					image_index = 1;
					image_blend = c_white;
				}
				TweenFire(ITEM,EaseLinear,0,0,0,15,"y",ITEM.y,406);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"x",ITEM.x,329);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_xscale",ITEM.image_xscale,1.5);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_yscale",ITEM.image_yscale,1.5);
				
				TweenFire(HEART,EaseLinear,0,0,0,15,"y",HEART.y,421);
				TweenFire(HEART,EaseLinear,0,0,0,15,"x",HEART.x,337);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_xscale",HEART.image_xscale,2);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_yscale",HEART.image_yscale,2);
				
				#region FREE DESELCTED BUTTONS FROM TWEENING
				TweenFire(ACT,EaseLinear,0,0,0,15,"y",ACT.y,416);
				TweenFire(ACT,EaseLinear,0,0,0,15,"x",ACT.x,179);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_xscale",ACT.image_xscale,1);
				TweenFire(ACT,EaseLinear,0,0,0,15,"image_yscale",ACT.image_yscale,1);
				
				TweenFire(MERCY,EaseLinear,0,0,0,15,"y",MERCY.y,416);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"x",MERCY.x,512);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"image_xscale",MERCY.image_xscale,1);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"image_yscale",MERCY.image_yscale,1);
				#endregion
			} else {
				with(ITEM){
					image_index = 1;
				}
				with(ACT){
					image_index = 0;	
				}
				with(MERCY){
					image_index = 0;	
				}
				with(HEART){
					x = 347;
					y = 429;
				}
			}
		break;	
		#endregion
		#region MERCY SELECTED
		case 3:
			if(battleButtonTweenable){
				with(ITEM){
					image_index = 0;	
					image_blend = c_gray;
				}
				with(MERCY){
					image_index = 1;
					image_blend = c_white;
				}
				
				TweenFire(MERCY,EaseLinear,0,0,0,15,"y",MERCY.y,406);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"x",MERCY.x,458);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"image_xscale",MERCY.image_xscale,1.5);
				TweenFire(MERCY,EaseLinear,0,0,0,15,"image_yscale",MERCY.image_yscale,1.5);
				
				TweenFire(HEART,EaseLinear,0,0,0,15,"y",HEART.y,421);
				TweenFire(HEART,EaseLinear,0,0,0,15,"x",HEART.x,465);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_xscale",HEART.image_xscale,2);
				TweenFire(HEART,EaseLinear,0,0,0,15,"image_yscale",HEART.image_yscale,2);
				
				#region FREE DESELCTED BUTTON FROM TWEENING
				TweenFire(ITEM,EaseLinear,0,0,0,15,"y",ITEM.y,416);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"x",ITEM.x,339);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_xscale",ITEM.image_xscale,1);
				TweenFire(ITEM,EaseLinear,0,0,0,15,"image_yscale",ITEM.image_yscale,1);
				#endregion
			} else {
				with(MERCY){
					image_index = 1;
				}
				with(ITEM){
					image_index = 0;	
				}
				with(HEART){
					x = 520;
					y = 429;
				}
			}
		break;	
		#endregion
	}
	#endregion
	if(inputdog_pressed("left")&&battleMenuSelection!=0){
		battleMenuSelection--;	
	} else if (inputdog_pressed("right")&&battleMenuSelection!=3){
		battleMenuSelection++;	
	} else if(inputdog_pressed("select")){
		switch(battleMenuSelection){
			case 0:
			HEART.image_alpha = 0;
			 state = stateMenuFight();
			break;
			case 1:
			break;
			case 2:
			
			break;
			
			case 3:
			
			break;
		}
	}	
}

if currentState == "menuFight"
{
	with obj_text_writer { visible = false } // temporarily hide the writer
	#region CHECK FOR MISS
	var reticle = obj_battle_fight_reticle;
	if(instance_exists(reticle)){
		if(reticle.x > 610){
		}
	}
	#endregion
	#region IF NOT MISSED, THEN CHECK ACTIVE WEAPON, PROCESS DAMAGE
	
	#endregion
}

if(instance_exists(obj_battle_fight_reticle)){
	show_debug_message(string(obj_battle_fight_reticle.x));	
}