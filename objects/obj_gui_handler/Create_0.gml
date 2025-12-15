/**
 *
 * GameMaker Studio 2.3 GUI elements
 *
 * @author	Zack Banack	<zackbanack.com>
 * @version	1.0
 *
 * 
 */

// create controller struct
control = new GUIElementController();

// create button
button = new Button("Click Me!", 16, 16);
// button.destroy(); // destroys the button

// create checkboxes
checkbox1 = new Checkbox("Checkbox A", 16, 64, false);
checkbox2 = new Checkbox("Checkbox B", 16, 112, true);
checkbox3 = new Checkbox("Checkbox C", 16, 160, true);
checkbox4 = new Checkbox("Checkbox D", 16, 208, true);

// create radio buttons in first group
radio_group1 = new RadioGroup("Group A"); // first radio group
radio1a = new Radio("Radio 1a", radio_group1, 300, 16, false);
radio1b = new Radio("Radio 1b", radio_group1, 300, 64, false);
radio1c = new Radio("Radio 1c", radio_group1, 300, 112, false);

// create radio buttons in second group
radio_group2 = new RadioGroup("Group B"); // second radio group
radio2a = new Radio("Radio 2a", radio_group2, 300, 208, false);
radio2b = new Radio("Radio 2b", radio_group2, 300, 256, false);
radio2c = new Radio("Radio 2c", radio_group2, 300, 304, false);
radio2d = new Radio("Radio 2d", radio_group2, 300, 352, false);

// create textfields
textfield1 = new Textfield("Textfield A", 600, 16,  "", "I'm a textfield :)");
textfield2 = new Textfield("Textfield B", 600, 64,  "", "");
textfield3 = new Textfield("Textfield C", 600, 112, "Hello!", "Placeholder text");

// create sliders
slider1 = new Slider("Slider 1", 600, 208, 0, 100, 1, 50);
slider2 = new Slider("Slider 2", 600, 256, 0, 100, 10, 20);
slider3 = new Slider("Slider 3", 600, 304, -100, 100, 25, 0);

// create dropdowns
dropdown1 = new Dropdown("Dropdown A", 16, 304, ["Option 1A", "Option 1B", "Option 1C", "Option 1D", "Option 1E"], 0);
dropdown2 = new Dropdown("Dropdown B", 16, 352, ["Option 2A", "Option 2B", "Option 2C"], 1);