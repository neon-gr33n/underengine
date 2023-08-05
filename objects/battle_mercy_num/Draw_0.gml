if(live_call()) return live_result;
var STR=string(mercy_perc);
var LEN=string_length(STR);
var SPR_W=sprite_get_width(spr_battle_text_num_core);
var draw_x=x;
	
if(LEN%2!=0){
		draw_x-=(LEN-1)*((SPR_W)/2);
	}else{
		draw_x-=((SPR_W)/2)+(LEN/2-1)*(SPR_W);
	}
	var proc=1;
	repeat(LEN){
		draw_sprite_ext(spr_battle_text_num_core,real(string_char_at(STR,proc)),draw_x,y,1,1,0,color,1);
		draw_x+=SPR_W+1;
		proc+=1;
}
draw_sprite_ext(spr_battle_text_num_addins,0,draw_x+10,y+-15,1,1,0,color,1);