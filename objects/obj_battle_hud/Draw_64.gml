if(live_call()) return live_result;

draw_ftext(fnt_mars,c_white,x+30,y+373,1.3,1.3,0, string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "NAME"]))
draw_ftext(fnt_mars,c_white,x+117,y+373,1.3,1.3,0,"LV: " +  string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "LV"]))

draw_sprite_ext(spr_battle_ui_hp,0,x+240,y+375,1.3,1.3,0,c_white,1)

draw_sprite_ext(spr_px,0,x+275,y+373,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_HP"]*1.25,18.5,0,c_red,1)
draw_sprite_ext(spr_px,0,x+275,y+373,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "HP"] * 1.25,18.5,0,c_yellow,1)

if  global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "LV"] == 19 {
draw_sprite_ext(spr_battle_ui_kr,0,x+405,y+369,1.5,1.5,0,c_white,1)
}

draw_ftext(fnt_mars,c_white,x+314,y+371.5,1.5,1.5,0, string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "HP"])) + " / " +  string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_HP"])))
