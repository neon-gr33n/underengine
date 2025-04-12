function party_data_init()
{
		global.partyname[0] = "Chara";
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

