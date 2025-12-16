#macro CAM obj_master_camera
#macro WRITER obj_text_writer

#macro PLAYER1 obj_ow_party

#macro FIGHT 0
#macro ACT 2
#macro ITEM 6
#macro MERCY 8

#macro BOARD obj_battle_box
#macro HEART obj_battle_soul

#macro TEST_ENC "test"

enum easetype{
		none,
		linear,
		percent,
		easeInQuad,
		easeOutQuad,
		easeInOutQuad,
		easeInCubic,
		easeOutCubic,
		easeInOutCubic,
		easeInQuart,
		easeOutQuart,
		easeInOutQuart,
		easeInQuint,
		easeOutQuint,
		easeInOutQuint,
		easeInSine,
		easeOutSine,
		easeInOutSine,
		easeInCirc,
		easeOutCirc,
		easeInOutCirc,
		easeInExpo,
		easeOutExpo,
		easeInOutExpo,
		easeInElastic,
		easeOutElastic,
		easeInOutElastic,
		easeInBack,
		easeOutBack,
		easeInOutBack,
		easeInBounce,
		easeOutBounce,
		easeInOutBounce,
	}
	
#macro START_ROOM rm_fallen 
#macro instance_place place_meeting

#macro camx camera_get_view_x(view_camera[0])
#macro camy camera_get_view_y(view_camera[0])