battleMenuSelection = 1; // Set to 1 by default inside of 0 so that ACT is the default option
battleButtonTweenable = false;  // Automatically updated via global.__ute_tween_battle_button
					// Determines whether button selection will appear static, or more alive via tweening
			
enemyChoice = 0;

instance_create_depth(-999,999,-9999,obj_battle_soul);
checkTweenable = function()
{
	if(UTE_TWEEN_BATTLE_BUTTON == true){
		battleButtonTweenable = true;
	} else {
		battleButtonTweenable = false;
	}
}

#region DEFINE MENU BEGIN STATE
stateMenuBegin = function ()
{
	currentState = "menuBegin";
	checkTweenable();
}
#endregion

#region DEFINE FIGHT STATE
stateMenuFight = function ()
{
	currentState = "menuFight"
	instance_create_depth(315,310,-99999,obj_battle_fight_target);
	instance_create_depth(-80,248,-999999,obj_battle_fight_reticle);
}
#endregion

state = stateMenuBegin(); 
currentState = "menuBegin";