depth = -9990;
state = -1;							// Current state
stateExecutedOnce = false;			// Is the state executed once?
prevState = state;					// The previous state
subState = 0;						// The sub state

speaker = undefined;
dialogueSpeaker = "";

talk_frame = 0;
talk_speed = 0.2/2; // Adjust for animation speed

displayText = ""
displayTextPos = ""
displayName = ""
displaySpeed = 0.55;
displayFace = spr_blank;
displayFaceIndex = 0;
displayFaceSpeed = 0;
voiceSound = undefined;
displayedDialogue = false;
//displayFont = WRITER.dialogue.dialogueFont;
displayOnTop = undefined;
textWritten = false;
displayAlignWriterY = 0;
_speed = 0;
_stay = false;
siner2 = 0;
cursor_xyscale = 0;
showCursor = true;
_scene = instance_exists(obj_cutscene_handler) ? obj_cutscene_handler.scene : noone;

d_height = window_get_fullscreen() ? window_get_height() : global._windowed_height
//funcRunCode = WRITER.dialogue.runcode;

player_freeze()