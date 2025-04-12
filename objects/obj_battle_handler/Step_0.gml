if currentState == "menuBegin"
{
	#region PROCESS MENU VISUAL EVENTS
	with obj_text_writer { visible = true } // temporarily re-enable the writer
	switch(battleMenuSelection){
		#region FIGHT SELECTED
		case 0:
			if(battleButtonTweenable){
				if instance_exists(ACT){
					with(ACT){
						image_index = 0;	
						image_blend = c_gray;
					}
					
					execute_tween(ACT,"image_xscale",1,"linear",0.1)
					execute_tween(ACT,"image_yscale",1,"linear",0.1)
					execute_tween(ACT,"x",179,"linear",0.1)
					execute_tween(ACT,"y",416,"linear",0.1)
				}
				if instance_exists(ITEM){
					with(ITEM){
						image_blend = c_gray;	
					}
				}
				if instance_exists(MERCY){
					with(MERCY){
						image_blend = c_gray;
					}
				}
				if instance_exists(FIGHT){
					with(FIGHT){
						image_index = 1;
						image_blend = c_white;
					}
					
					execute_tween(FIGHT,"image_xscale",1.5,"linear",0.1)
					execute_tween(FIGHT,"image_yscale",1.5,"linear",0.1)
					execute_tween(FIGHT,"x",10,"linear",0.1)
					execute_tween(FIGHT,"y",406,"linear",0.1)
				}
				
				if soul_exists() == true && HEART.currentState == "inMenu" {
					execute_tween(HEART,"image_xscale",2,0.1)
					execute_tween(HEART,"image_yscale",2,0.1)
					execute_tween(HEART,"x",20,"linear",0.1)
					execute_tween(HEART,"y",421,"linear",0.1)
				}
			} else {
				if instance_exists(FIGHT){
					with(FIGHT){
						image_index = 1;
					}
				}
				if instance_exists(ACT){
					with(ACT){
						image_index = 0;	
					}
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
				if instance_exists(FIGHT){
					with(FIGHT){
						image_index = 0;
						image_blend = c_gray;
					}
					
					execute_tween(FIGHT,"image_xscale",1,"linear",0.1)
					execute_tween(FIGHT,"image_yscale",1,"linear",0.1)
					execute_tween(FIGHT,"x",20,"linear",0.1)
					execute_tween(FIGHT,"y",416,"linear",0.1)
				}
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 0;
						image_blend = c_gray;
					}
					
					execute_tween(ITEM,"image_xscale",1,"linear",0.1)
					execute_tween(ITEM,"image_yscale",1,"linear",0.1)
					execute_tween(ITEM,"x",339,"linear",0.1)
					execute_tween(ITEM,"y",416,"linear",0.1)
				}
				if instance_exists(MERCY){
					with(MERCY){
						image_blend = c_gray;	
					}
				}
				if instance_exists(ACT){
					with(ACT){
						image_index = 1;	
						image_blend = c_white;
					}
					
					execute_tween(ACT,"image_xscale",1.5,"linear",0.1)
					execute_tween(ACT,"image_yscale",1.5,"linear",0.1)
					execute_tween(ACT,"x",155,"linear",0.1)
					execute_tween(ACT,"y",406,"linear",0.1)
				}
				
				if soul_exists() == true && HEART.currentState == "inMenu" {
					execute_tween(HEART,"image_xscale",2,0.1)
					execute_tween(HEART,"image_yscale",2,0.1)
					execute_tween(HEART,"x",168,"linear",0.1)
					execute_tween(HEART,"y",421,"linear",0.1)
				}	
			} else {
				if instance_exists(FIGHT){
					with(FIGHT){
						image_index = 0;
					}			
				}
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 0;
					}
				}
				if instance_exists(ACT){
					with(ACT){
						image_index = 1;
					}
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
				if instance_exists(ACT){
					with(ACT){
						image_index = 0;	
						image_blend = c_gray;
					}
					
					execute_tween(ACT,"image_xscale",1,"linear",0.1)
					execute_tween(ACT,"image_yscale",1,"linear",0.1)
					execute_tween(ACT,"x",179,"linear",0.1)
					execute_tween(ACT,"y",416,"linear",0.1)
				}
				if instance_exists(MERCY){
					with(MERCY){
						image_index = 0;	
						image_blend = c_gray;
					}
					
					execute_tween(MERCY,"image_xscale",1,"linear",0.1)
					execute_tween(MERCY,"image_yscale",1,"linear",0.1)
					execute_tween(MERCY,"x",512,"linear",0.1)
					execute_tween(MERCY,"y",416,"linear",0.1)
				}
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 1;
						image_blend = c_white;
					}
					
					execute_tween(ITEM,"image_xscale",1.5,"linear",0.1)
					execute_tween(ITEM,"image_yscale",1.5,"linear",0.1)
					execute_tween(ITEM,"x",329,"linear",0.1)
					execute_tween(ITEM,"y",406,"linear",0.1)
				}
				
				if soul_exists() == true && HEART.currentState == "inMenu" {
					execute_tween(HEART,"image_xscale",2,0.1)
					execute_tween(HEART,"image_yscale",2,0.1)
					execute_tween(HEART,"x",337,"linear",0.1)
					execute_tween(HEART,"y",421,"linear",0.1)
				}
			} else {
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 1;
					}
				}
				if instance_exists(ACT){
					with(ACT){
						image_index = 0;	
					}
				}
				if instance_exists(MERCY){
					with(MERCY){
						image_index = 0;	
					}
				}
				if soul_exists() == true && HEART.currentState == "inMenu" {
					with(HEART){
						x = 347;
						y = 429;
					}
				}
			}
		break;	
		#endregion
		#region MERCY SELECTED
		case 3:
			if(battleButtonTweenable){
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 0;	
						image_blend = c_gray;
					}
					
					execute_tween(ITEM,"image_xscale",1,"linear",0.1)
					execute_tween(ITEM,"image_yscale",1,"linear",0.1)
					execute_tween(ITEM,"x",339,"linear",0.1)
					execute_tween(ITEM,"y",416,"linear",0.1)
				}
				if instance_exists(MERCY){
					with(MERCY){
						image_index = 1;
						image_blend = c_white;
					}
														
					execute_tween(MERCY,"image_xscale",1.5,"linear",0.1)
					execute_tween(MERCY,"image_yscale",1.5,"linear",0.1)
					execute_tween(MERCY,"x",458,"linear",0.1)
					execute_tween(MERCY,"y",406,"linear",0.1)
				}

				if soul_exists() == true && HEART.currentState == "inMenu" {
					execute_tween(HEART,"image_xscale",2,"linear",0.1)
					execute_tween(HEART,"image_yscale",2,"linear",0.1)
					execute_tween(HEART,"x",465,"linear",0.1)
					execute_tween(HEART,"y",421,"linear",0.1)
				}
			} else {
				if instance_exists(MERCY){
					with(MERCY){
						image_index = 1;
					}
				}
				if instance_exists(ITEM){
					with(ITEM){
						image_index = 0;	
					}
				}
				if soul_exists() == true && HEART.currentState == "inMenu" {
					with(HEART){
						x = 520;
						y = 429;
					}
				}
			}
		break;	
		#endregion
	}
	#endregion
	if(pressed("left")&&battleMenuSelection!=0){
		battleMenuSelection--;	
	} else if (pressed("right")&&battleMenuSelection!=3){
		battleMenuSelection++;	
	} else if(pressed("action")){
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
	//#region CHECK FOR MISS  - commented out until displaying targets has been implemented
	//var reticle = obj_battle_fight_reticle;
	//if(instance_exists(reticle)){
	//	if(reticle.x > 610){
	//	}
	//}
	//#endregion
	#region IF NOT MISSED, THEN CHECK ACTIVE WEAPON, PROCESS DAMAGE
	
	#endregion
}

if currentState == "frozen" 
{
	// DO NOTHING	
}