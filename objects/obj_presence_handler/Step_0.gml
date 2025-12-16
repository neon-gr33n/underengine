if (!unsupport)
{
    if ((!is_android()))
    {
        if (global.presence)
        {
            np_update()
            if runonce
            {
                np_setpresence_more("Small icon", "Large icon", 0)
                switch room
                {
                    case rm_battle:
                        np_setpresence(("HP: " + (string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"]) ) + "/ ") + (string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "MAX_HP"])), "Engaging in combat!", "bigicon", "")
                        break
                    default:
						//var __room=get_room_name(room)
                       // np_setpresence(string_split(__room," - ")[1], string_split(__room," - ")[0], "bigicon", "")
                }

                runonce = 0
            }
        }
        else if (global.presence == false)
        {
            if (!runonce)
            {
                np_clearpresence()
                runonce = 1
            }
        }
    }
}
