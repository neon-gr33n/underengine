// Feather disable all
//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

return {
    
    keyboard_and_mouse:
    {
        up:    [input_binding_key(vk_up),    input_binding_key("W")],
        down:  [input_binding_key(vk_down),  input_binding_key("S")],
        left:  [input_binding_key(vk_left),  input_binding_key("A")],
        right: [input_binding_key(vk_right), input_binding_key("D")],
        
		action:  [input_binding_key("Z"), input_binding_key(vk_enter)  ],
        cancel:  [input_binding_key("X"), input_binding_key(vk_shift)  ],
        menu:    [input_binding_key("C"), input_binding_key(vk_control)],
		
		pause: [input_binding_key(vk_escape), input_binding_key("P")],
    },
    
    gamepad:
    {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        action:  [input_binding_gamepad_button(gp_face1), input_binding_gamepad_button(gp_shoulderrb)],
        cancel:  [input_binding_gamepad_button(gp_face2), input_binding_gamepad_button(gp_shoulderlb)],
        menu:	 [input_binding_gamepad_button(gp_face4), input_binding_gamepad_button(gp_shoulderr)],
		
		pause: [input_binding_gamepad_button(gp_start), input_binding_gamepad_button(gp_select)],  
    },
    
    touch:
    {
        up:    input_binding_virtual_button(),
        down:  input_binding_virtual_button(),
        left:  input_binding_virtual_button(),
        right: input_binding_virtual_button(),
        
        action: input_binding_virtual_button(),
        cancel:  input_binding_virtual_button(),
        menu: input_binding_virtual_button(),
		
		pause: input_binding_virtual_button()
    },
	
	onehand_keyboard:
	{
		up:    [input_binding_key("W")],
        down:  [input_binding_key("S")],
        left:  [input_binding_key("A")],
        right: [input_binding_key("D")],
        
		action:  [input_binding_key("Z")],
        cancel:  [input_binding_key("X"),input_binding_key(vk_shift)],
        menu:    [input_binding_key("C"), input_binding_key(vk_control)],
		
		pause: [input_binding_key(vk_escape)],
	},
	
	onehand_gamepad: 
	{
	    up:    [
	        input_binding_gamepad_axis(gp_axislv, true),   // Left stick
	        input_binding_gamepad_axis(gp_axisrv, true)    // Right stick
	    ],
	    down:  [
	        input_binding_gamepad_axis(gp_axislv, false),
	        input_binding_gamepad_axis(gp_axisrv, false)
	    ],
	    left:  [
	        input_binding_gamepad_axis(gp_axislh, true),
	        input_binding_gamepad_axis(gp_axisrh, true)
	    ],
	    right: [
	        input_binding_gamepad_axis(gp_axislh, false),
	        input_binding_gamepad_axis(gp_axisrh, false)
	    ],
    
	    // ACTIONS: All face buttons + stick clicks
	    // Grouped by function, not location
	    action:  [
	        // Primary action buttons
	        input_binding_gamepad_button(gp_face1),  // A/X
	        input_binding_gamepad_button(gp_stickr), // Right stick click
	    ],
    
	    cancel:  [
	        // Secondary/cancel buttons
	        input_binding_gamepad_button(gp_face2),  // B/○
	        input_binding_gamepad_button(gp_select)  // Back/View
	    ],
    
	    menu: [
	        // Menu/navigation buttons
	        input_binding_gamepad_button(gp_face3),  // Y/△
	        input_binding_gamepad_button(gp_start)   // Start/Options
	    ],
    
	    // PAUSE: Every button can pause (critical for accessibility)
	    pause: [
	        input_binding_gamepad_button(gp_start),
	        input_binding_gamepad_button(gp_select),
		],
	}
};
