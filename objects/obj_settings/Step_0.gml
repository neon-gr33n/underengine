if(live_call()) return live_result;
seconds = obj_game_handler.seconds;
minutes = obj_game_handler.minutes;
hours = obj_game_handler.hours;

HEART.x = 30;
HEART.y = -GAME_RES.h / 480 * 20 + GAME_RES.h / 4 * (1.3 + _menued * 0.3); //136 + _menued * 39;

