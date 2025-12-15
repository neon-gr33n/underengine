 ///@arg state
function battle_set_menu_state(){
	var state = argument0;
	
	switch(state){
		#region Entry State
		case "menuBegin":
			with (HEART) {
				visible = true;
				image_alpha = 1;
			}
			HEART.stateMenuSoul();
			with WRITER {
				dialogue.dialogueText = "";
				dialogue.dialogueFont = loc_get_font("fnt_main_bt")
			}
			obj_battle_handler.defended = false;
			obj_battle_handler.currentState = "menuBegin";
			obj_battle_handler.stateMenuBegin();
			break;
		#endregion
		
		#region Fight States
		case "menuFightSelect":
			obj_battle_handler.currentState = "menuFightSelect";
			stateMenuFight();
			break;
			
		case "menuFightEye":
			obj_battle_handler.currentState = "menuFightEye";
			break;
			
		case "menuFightAnim":
			obj_battle_handler.currentState = "menuFightAnim";
			break;
			
		case "menuViolentWin":
			obj_battle_handler.currentState = "menuViolentWin";
			break;
			
		#endregion
		
		#region Act States
		case "menuActSelect":
			obj_battle_handler.currentState = "menuActSelect";
			stateMenuAct();
			break;
		case "menuActCall":
			obj_battle_handler.currentState = "menuActCall";
			break;
		case "menuActResponse":
			obj_battle_handler.currentState = "menuActResponse";
			break;
		#endregion
		
		#region Item States
			case "menuItemSelect":
				obj_battle_handler.currentState = "menuItemSelect";
				stateMenuItem();
				break;
			case "menuItemUse":
				obj_battle_handler.currentState = "menuItemUse";
			break;
		#endregion
		
		#region Mercy States
			case "menuMercySelect":
				obj_battle_handler.currentState = "menuMercySelect";
				stateMenuMercy();
				break;
			case "menuMercyDefend":
				obj_battle_handler.currentState = "menuMercyDefend";
				break;
			case "menuMercyFlee":
				obj_battle_handler.currentState = "menuMercyFlee";
				break;
			case "menuMercySpareSelect":
				obj_battle_handler.currentState = "menuMercySpareSelect";
				break;
			case "menuMercySparing":
				obj_battle_handler.currentState = "menuMercySparing";
				break;
		#endregion
		
		#region Enemy Turn
		case "enemyTurn":
		obj_battle_handler.defended = false;
	    obj_battle_handler.currentState = "enemyTurn";
		HEART.visible = true;
	    WRITER.dialogue.dialogueText = "";
    
	    // Call event_user(3) on ALL living enemies
	    for (var i = 0; i < 3; i++) {
	        var enemy_instance = global.enc_slot[i];
	        var enemy_id = global.ENEMY_INFO[$ "__ENEMY__"][$ "ENEMIES"][i];
        
	        // Check if enemy exists in this slot
	        if (enemy_id != noone && instance_exists(enemy_instance)) {
	            // Call event_user(3) on this enemy
	            with (enemy_instance) {
	                event_user(3);
	            }
	            show_debug_message("Called event_user(3) on enemy in slot " + string(i));
	        }
	    }
    
		if(!speech_bubble_exists()){
			HEART.currentState = "soulMoving"
		    HEART.stateSoulMovement();
		}
	    HEART.x = BOARD.x;
		HEART.y = BOARD.y;
	    break;
		#endregion
		
		#region State Doesn't Exist
		default:
			return false;
			break;
		#endregion
	}
}