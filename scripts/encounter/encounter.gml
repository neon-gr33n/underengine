function encounter_setup(){
	/// @desc used to initialize an encounter, or setup a random encounter battlegroup
	///@arg enemy0
	///@arg enemy1
	///@arg enemy2
	global.enc_slot = [noone,noone,noone];
	global.enc_name = ["","",""];

	if argument_count == 0 {
		global.enc_slot[0] = argument0;
			
	} else if argument_count == 1 {
		global.enc_slot[0] = argument0;
		global.enc_slot[1] = argument1;
		
	} else if argument_count == 2 {
		global.enc_slot[0] = argument0;
		global.enc_slot[1] = argument1;
		global.enc_slot[1] = argument2;
	}
}

function encounter_set_menu_text() {
		// @arg menuText
		if instance_exists(obj_text_writer){
			dialogue.dialogueText = argument0;
		}
}

function encounter_create(){
	if(global.enc_slot[0]!=noone){
		instance_create_depth(96,224,-100,global.enc_slot[0], {
			drawXPos: x,
			drawYPos: y
		})	
	}
	if(global.enc_slot[1]!=noone){
		instance_create_depth(320,224,-100,global.enc_slot[1], {
			drawXPos: x,
			drawYPos: y
		})	
	}
	if(global.enc_slot[2]!=noone){
		instance_create_depth(554,224,-100,global.enc_slot[2], {
			drawXPos: x,
			drawYPos: y
		})	
	}
}

function encounter_adjust_name(){
	///@arg enemyName
	///@arg target
	var name = argument0;
	var target = argument1;
	global.enc_name[target] = name;
}

function encounter_adjust_visiblity(){
	///@desc Allows us to control the visibility of an enemy object
	///(best used for creative attacks that in involve the enemy directly going into the box e.g rolling, jumping on it, etc.)
	///@arg target
	///@arg visible
	var target = argument0;
	var visibleState = argument1;
	with(target){
		visible = visibleState;
	}
}

function encounter_adjust_pos() {
	///@desc Centers the enemy on the screen (optional lerpSmooth argument for smooth centering transition)
	///@arg target
	///@arg x
	///@arg lerpSmooth* 
	///@arg duration*
	
	// (we're omitting Y because that should almost ALWAYS remain consistent)
	// (Provided an optional "duration" argument for lerping in the event that 
	//we wish to have an enemy take longer to center)
	
	var target = argument0;
	var xPos = argument1;
	var lerpSmooth = argument2;
	var duration = argument3;
	
	if !lerpSmooth {
		with(target){
				drawXPos = xPos; // Center the object on the battle screen
		}
	} else if lerpSmooth == true {
		with(target){
			TweenFire(target,EaseLinear,0,0,0,duration,"x",x,xPos);
		}
	}
}
