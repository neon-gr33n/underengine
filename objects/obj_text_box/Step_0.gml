if (instance_exists(WRITER) && WRITER.typewriter_state != 1){
				 talk_frame += talk_speed;
		    if (talk_frame >= sprite_get_number(displayFace)) {
		        talk_frame = 0;
		    }	
} else {
	talk_frame = 0;	
}

siner2++;
var pulse = frac(siner2 * 0.02); // 0.02 controls speed
cursor_xyscale = 1.5 + 0.5 * (pulse < 0.3 ? sin(pulse * 10.47) : exp(-5 * (pulse - 0.3)));