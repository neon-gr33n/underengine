if(live_call()) return live_result;

draw_ftext(fnt_mars,c_white,x+100,y+380,1,1,0, string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "NAME"]))
draw_ftext(fnt_mars,c_white,x+100,y+395,1,1,0,"LV:   " +  string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "LV"]))
draw_ftext(fnt_mars,c_white,x+100,y+410,1,1,0, "FEELS:\n"+string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "EMOTION"]))

draw_sprite_ext(spr_battle_ui_hp,0,x+540,y+375,1,1,0,c_white,1)
draw_sprite_ext(spr_battle_soul_core,0,x+515,y+390,2,2,0,c_red,1)
draw_sprite_ext(spr_battle_ui_mp_icon,0,x+515,y+425,2,2,0,c_fuchsia,1)


draw_sprite_ext(spr_battle_ui_chara_emotes_neutral,image_index/6,x+30,y+380,1,1,0,c_white,1)

draw_sprite_ext(spr_battle_ui_mp,0,x+540,y+410,1,1,0,c_white,1)

if  global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "LV"] == 19 {
draw_sprite_ext(spr_battle_ui_kr,0,x+405,y+369,1.5,1.5,0,c_white,1)
}

draw_sprite_ext(spr_px,0,x+540,y+390,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_HP"],12,0,c_red,1)
draw_sprite_ext(spr_px,0,x+540,y+390,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "HP"],12,0,c_lime,1)

draw_ftext(fnt_mars,c_white,x+585,y+376,0.8,0.8,0, string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "HP"])) + "/" +  string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_HP"])))

draw_sprite_ext(spr_px,0,x+540,y+425,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_MP"],12,0,c_red,1)
draw_sprite_ext(spr_px,0,x+540,y+425,global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MP"],12,0,c_fuchsia,1)

draw_ftext(fnt_mars,c_white,x+585,y+411,0.8,0.8,0, string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MP"])) + "/" +  string((global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember]][$ "STATS"][$ "MAX_MP"])))
