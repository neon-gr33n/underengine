function party_add_member(_slot = 0, _member = noone){
	///@arg slot
	///@arg member
	if(global.currentpartysize < global.maxpartysize){
		global.partymember[_slot] = _member;
		global.currentpartysize += 1;
	}
}
