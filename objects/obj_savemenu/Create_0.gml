depth=-400;

_state=-1;
_choice=0;
_swapping = -1;

seconds=-1;
minutes=-1;
hours=-1;

player_freeze()

global.seconds_prev = -1;  // If you're wondering why the minutes, seconds and hours_prev variables are being defined as Global, it's because we're re-using it in the save/load menu
global.minutes_prev = -1;
global.hours_prev = -1;

savecount="";

_saved=0;

_time=string(global.time);
minute=0;
second=0;

actuallySaved=false;

with(PLAYER1){
		state = stateCutsceneStasis();
}

__col0=noone
__col1=noone
__col2=noone

if !instance_exists(HEART) instance_create(0,0,HEART)
HEART.returning=0