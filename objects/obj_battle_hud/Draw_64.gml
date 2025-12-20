if(live_call()) return live_result;

// Store the current party member data in a variable for cleaner access
var member_id = global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][activePartyMember];
var member_data = global.PARTY_INFO[$ member_id];
var member_stats = member_data[$ "STATS"];

// Calculate health bar widths
var hp_width = member_stats[$ "HP"] * 1.25;
var max_hp_width = member_stats[$ "MAX_HP"] * 1.25;

// Draw character name
draw_ftext(fnt_mars, c_white, x+30, y+373, 1.3, 1.3, 0, 
    string(global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "NAME"]));

// Draw level
draw_ftext(fnt_mars, c_white, x+117, y+373, 1.3, 1.3, 0, 
    "LV: " + string(member_stats[$ "LV"]));

// Draw HP label
draw_sprite_ext(spr_battle_ui_hp, 0, x+200, y+378, 1, 1, 0, c_white, 1);

// Draw health bars (background and foreground)
draw_sprite_ext(spr_px, 0, x+230, y+373, max_hp_width, 18.5, 0, c_red, 1);
draw_sprite_ext(spr_px, 0, x+230, y+373, hp_width, 18.5, 0, c_yellow, 1);

// Draw KR icon at level 19 (if applicable)
if member_stats[$ "LV"] == 19 {
    draw_sprite_ext(spr_battle_ui_kr, 0, x+400, y+378, 1, 1, 0, c_white, 1);
		// Calculate HP text position based on health bar width
	var hp_text_x = x + 275 + max_hp_width + 55; 
} else {
	// Calculate HP text position based on health bar width
	var hp_text_x = x + 275 + max_hp_width - 35; // Position 5 pixels to the right of the bar
}



// Draw HP/MAX_HP text
draw_ftext(fnt_mars, c_white, hp_text_x, y+373, 1.3, 1.3, 0, 
    string(member_stats[$ "HP"]) + " / " + string(member_stats[$ "MAX_HP"]));