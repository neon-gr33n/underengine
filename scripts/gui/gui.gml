function GUIElement() constructor {
	// int, string or bool depending on type
	value = undefined;
	
	name = undefined; // Unique identifier
	
	// dimensions
	static width = 200;
	static height = 32;
	static padding = 16;
	
	// focus related
    /// @function   has_focus()
    static has_focus = function() {
        return controller.element_in_focus == self;
    }

    /// @function   set_focus()
    static set_focus = function() {
        controller.element_in_focus = self; 
    }

    /// @function   remove_focus()
    static remove_focus = function() {
        controller.element_in_focus = undefined;
    }
	
	// value setter and getter
	static get = function() { return value; }
	static set = function(_value) { value = _value; }
	
	// interaction
    /// @function   step()
    static step = function() {

        // check for mouse click inside bounding box AND ensure no click already happened this gamestep
        if (mouse_check_button_pressed(mb_left) && controller.can_click &&
            point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height)) {

            // tell controller we clicked on an input this step
            controller.can_click = false;

            click();

        }

        // if the element has focus, listen for input
        if (has_focus()) listen();
    }
	static click = function() {}
	static listen = function() {}
	
	// drawing
	static draw = function() {}
	
	   // a reference to the controller
      controller    = global.__ElementController;

      // add to controller's list of elements
    ds_list_add(controller.elements, self); 

    /// @function   destroy()
    static destroy = function() {
        // remove from controller's list of elements
        ds_list_delete(controller.elements,
            ds_list_find_index(controller.elements, self)
        );
    }
	
}
	
function GUIElementController() constructor {
	global.__ElementController = self;
	
	// list of all GUI elements
	elements = ds_list_create();
	
	element_in_focus = undefined;
	
	// prevents click throughs on overlapping elements
	can_click = true;
	
	///@function step()
	static step = function() {
		if (mouse_check_button_pressed(mb_left)) element_in_focus = undefined;
		can_click = true;
		
		// call 'step' function in all elements
		var count = ds_list_size(elements);
		for(var i =0; i<count; i++) elements[| i].step();
	}
	
	///@function draw()
	static draw = function() {
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		
		// call 'draw' function on all elements in reverse-creation order
		for(i=ds_list_size(elements)-1; i>=0; i--)
			elements[|i].draw();
	}
	
	/// @function   destroy()
    static destroy = function() {

        // free all elements from memory
        for(var i = ds_list_size(elements)-1; i>=0; i--)
            elements[| i].destroy();
        ds_list_destroy(elements);

        // remove global reference
        delete global.__ElementController;
        global.__ElementController = undefined;

    }
	
}
	
/// @function   Checkbox(string:name, real:x, real:y, bool:checked)
function Checkbox(_name, _x, _y, _checked) : GUIElement() constructor {

    // passed-in vars
    x           = _x;
    y           = _y;
    name              = _name;

    /// @function   click()
    static click = function() {
        set_focus();
        set(!get());    
        show_debug_message("You " + (get() ? "checked" : "unchecked") + " the Checkbox named `" + string(name) + "`!"); 
    }

    /// @function   draw()
    static draw = function() {
        draw_rectangle(x, y, x + height, y + height, !get()); // box
        draw_text(x + height + padding, y + (height * 0.5), name); // name  
    }

    // set value
    set(_checked);

}

/// @function   Textfield(string:name, real:x, real:y, string:value)
function Textfield(_name, _x, _y, _value) : GUIElement() constructor {

    // passed-in vars
    name        = _name;
    x       = _x;
    y       = _y;

    /// @function   set(string:str)
    static set = function(str) {

        // value hasn't changed; quit
        if (value == str) return;

        value = str;

        show_debug_message("You set the Textfield named `" + string(name) + "` to the value `" + string(value) + "`");  

    }

    /// @function   click()
    static click = function() {
        set_focus();
        keyboard_string = get();    
    }

    /// @function   listen()
    static listen = function() {
        set(keyboard_string);   
        if (keyboard_check_pressed(vk_enter)) remove_focus();
    }

    /// @function   draw()
    static draw = function() {

        draw_set_alpha(has_focus() ? 1 : 0.5);

        // bounding box
        draw_rectangle(x, y, x + width, y + height, true);

    // draw input text
    draw_text(x + padding, y + (height * 0.5), get());

    draw_set_alpha(1);

    }


    // set value
    set(_value);
}
