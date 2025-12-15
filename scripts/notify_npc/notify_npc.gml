///@desc Creates an "interact" notifier above an NPC
function notify_npc(offset_y,offset_x,range){
	var _range, _dist, _offs;
	if(instance_exists(PLAYER1)){
		_range=range;
		_dist = max(min(abs(bbox_left-PLAYER1.x),abs(bbox_right-PLAYER1.x)),min(abs(bbox_top-PLAYER1.y),abs(bbox_bottom-PLAYER1.y)));
		if(_dist <= _range) {draw_sprite(spr_interactnotif, 0, (bbox_right+bbox_left)/2+offset_x, (bbox_top - 2)+offset_y)}
	}
}