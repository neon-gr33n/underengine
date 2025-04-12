depth = -9990;
state = -1;							// Current state
stateExecutedOnce = false;			// Is the state executed once?
prevState = state;					// The previous state
subState = 0;						// The sub state

displayText = ""
displayTextPos = ""
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

//funcRunCode = WRITER.dialogue.runcode;

player_freeze()