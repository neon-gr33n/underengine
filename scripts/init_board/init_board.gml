function init_board_solid(){
	///@arg xPos
	///@arg yPos
	///@arg type
	///@desc Inits a solid for the battle board
	instance_create(argument0,argument1,obj_battle_board_solid)
	with(obj_battle_board_solid){type=argument2}
}