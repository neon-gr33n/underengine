__draw_black=true;
__draw_player=true;
__draw_soul_x = (PLAYER1.x - camera_get_view_x(view_camera[0])) * 2;
__draw_soul_y = (PLAYER1.y - PLAYER1.sprite_height + 17 - camera_get_view_y(view_camera[0])) * 2;
alarm[2]=1;