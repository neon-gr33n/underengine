function party_data_init()
{
		global.partyname[0] = "";
		global.partyhp[0] = {_curr: 20, _full: 20};
		global.partylv[0] = 1;
		global.partymoney[0] = 0;
		
		global.maxpartysize = 2; 
		global.currentpartysize = 1;
		
		global.partymember[0] = noone;
		global.partymember[1] = noone;
		global.partymember[2] = noone;
		global.partymember[3] = noone;
}

function party_add_member(_slot = 0, _member = noone){
	///@arg slot
	///@arg member
	if(global.currentpartysize < global.maxpartysize){
		global.partymember[_slot] = _member;
		global.currentpartysize += 1;
	}
}

function party_remove_member(){
	///@arg slot
	global.partymember[argument0] = noone;
}

function party_update_max_size(){
	///@arg newSize
	global.maxpartysize = argument0;
}

function party_abandon() {
	for(var i = 0; i < array_length(global.partymember) - 1; i++) {
		global.partymember[i] = noone;
	}
}