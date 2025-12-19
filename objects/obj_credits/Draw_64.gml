if(live_call()) return live_result; 
    draw_set_halign(fa_center)
    draw_text_scribble(x-100,y-15, "["+loc_get_font("fnt_main_bt")+"]"+"[scale,1][c_white] Credits[/c]")
    draw_text_scribble(x-100,y+25, "["+loc_get_font("fnt_main_bt")+"]"+"[scale,1][c_yellow] GameMaker (YoYo Games)[/c]")
    draw_text_scribble(x-100,y+65, "["+loc_get_font("fnt_main_bt")+"]"+"[scale,1][c_white] Toby Fox & Co[/c]")
    draw_text_scribble(x-100,y+110, "["+loc_get_font("fnt_main_bt")+"]"+"[scale,1][c_white] This guy created UNDERTALE.#How neat is that?[/c]")

    // Draw instructions
    draw_text_scribble(x-100,y+400, "["+loc_get_font("fnt_outline")+"]"+"[scale,1.8][c_gray] Press X/Shift to go back! [/c]")