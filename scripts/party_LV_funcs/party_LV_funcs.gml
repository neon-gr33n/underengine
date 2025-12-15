///@desc Fetches the exp needed to level up
///@arg index
function LV_get_exp_needed(LV) {
	switch(LV) {
		case 2:
			return 10;
		case 3:
			return 30;
		case 4:
			return 70;
		case 5:
			return 120;
		case 6:
			return 200;
		case 7:
			return 300;
		case 8:
			return 500;
		case 9:
			return 800;
		case 10:
			return 1200;
		case 11:
			return 1700;
		case 12:
			return 2500;
		case 13:
			return 3500;
		case 14:
			return 5000;
		case 15:
			return 7000;
		case 16:
			return 10000;
		case 17:
			return 15000;
		case 18:
			return 25000;
		case 19:
			return 50000;
		case 20:
			return 99999;
		default:
			return -1;
	}
}

///@desc Updates stats depending on level
///@arg index
function member_update_stats(member)
{
    var currentLV = member_get_stat(member, "LV");
    var totalEXP = member_get_stat(member, "EXP");
    
    // Handle multiple level-ups
    while (totalEXP >= LV_get_exp_needed(currentLV + 1) && currentLV < 20) {
        // Increase level
        member_change_stat(member, "LV", 1);
        currentLV = member_get_stat(member, "LV"); // Update currentLV
        
        #region update mana and HP depending on LV
        if (currentLV < 20) {
            member_set_stat(member, "MAX_HP", 20 + 6 * (currentLV - 1));
            member_set_stat(member, "MAX_MP", 20 + 2 * (currentLV - 1));
        } else {
            member_set_stat(member, "MAX_HP", 150);
            member_set_stat(member, "MAX_MP", 100);
        }
        member_recover_HP(member);
        member_recover_MP(member);
        #endregion
    }
}

function party_update_stats() {
	array_foreach(party_get_attribute("members"), member_update_stats);
}