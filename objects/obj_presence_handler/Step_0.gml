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
                np_setpresence_buttons(0, "SWAPPED MYTH on GameJolt", "https://gamejolt.com/games/swappedmyth/857058")
                switch room
                {
                    //case "beginning":
                    //    np_setpresence("Entering the Underground", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "ruins":
                    //    np_setpresence("Exploring the Lucent Caverns", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "title":
                    //    np_setpresence("The begininng of your story", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "settings":
                    //    np_setpresence("Tinkering with settings", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "gameover":
                    //    np_setpresence("Game Over..?", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "intro":
                    //    np_setpresence("Listening to their tale.", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    case rm_battle:
                        np_setpresence(("HP: " + (string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"]) ) + "/ ") + (string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "MAX_HP"])), "Engaging in combat!", "bigicon", "")
                        break
                    //case "shop":
                    //    np_setpresence("Stocking up on items.", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    //case "init":
                    //    np_setpresence("Starting up..!", "SWAPPED MYTH", "bigicon", "")
                    //    break
                    default:
						var __room=get_room_name(room)
                        np_setpresence(string_split(__room," - ")[1], string_split(__room," - ")[0], "bigicon", "")
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
