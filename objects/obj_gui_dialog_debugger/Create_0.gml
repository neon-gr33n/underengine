newText = "";  // Leave empty by default
newPrefix = "*" // Asterisk by default

currentInput = ""
copiedString = "" 

pressed = false

availableFonts =
[
	"fnt_main_small",
	"fnt_main_small_jp",
	"fnt_sans"
]

availableSpeakers =
[
	"gen",
	"sans"
]

speakersProperties  =
{
	generic: {
		font: loc_get_font("fnt_main"),
		port: spr_blank,
		voice: snd_soft_v
	},
	sans : {
		font: loc_get_font("fnt_sans"),
		port: [spr_port_sans_gen,
					spr_port_sans_sass,
					spr_port_sans_chuckle,
					spr_port_sans_side_l,
					spr_port_sans_closed_eyes,
					spr_port_sans_wink,
					spr_port_sans_badtime],
		voice: snd_sans_v
	}
}

currentPortCharIndex = 0;
currentSpeaker = availableSpeakers[0];
currentPortExpressionIndex = 0;
currentPortExpression = spr_blank; // Cache the current expression for later use

assignDialogueText = function() {
		WRITER.dialogue.dialogueText = "" 
		switch(currentSpeaker){
			case "gen":
				WRITER.dialogue.dialoguePortrait = speakersProperties.generic.port;
				obj_text_box.displayFace = WRITER.dialogue.dialoguePortrait
				WRITER.dialogue.dialogueVoice = speakersProperties.generic.voice;
				WRITER.dialogue.dialogueFont = speakersProperties.generic.font;
				WRITER.dialogue.dialogueText = currentInput
			break;
			case "sans":
				WRITER.dialogue.dialoguePortrait = speakersProperties.sans.port[currentPortExpressionIndex];
				obj_text_box.displayFace = WRITER.dialogue.dialoguePortrait
				WRITER.dialogue.dialogueVoice = speakersProperties.sans.voice;
				WRITER.dialogue.dialogueFont = speakersProperties.sans.font;
				WRITER.dialogue.dialogueText = currentInput
			break;
	}
}

clearDialogueText = function() {
	keyboard_string = "";
	WRITER.dialogue.dialoguePortrait = speakersProperties.generic.port;
	obj_text_box.displayFace = WRITER.dialogue.dialoguePortrait
	WRITER.dialogue.dialogueVoice = speakersProperties.generic.voice;
	WRITER.dialogue.dialogueFont = speakersProperties.generic.font;
	WRITER.dialogue.dialogueText = "";
	
	t_scene_info2=
	[
		[cutscene_dialogue,"gen",spr_blank, "* (But nobody came.)",0.55,true,"dynamic"],
		[cutscene_end]
	]

create_cutscene(t_scene_info2)
}

copyTextToClipboard = function(){
	clipboard_set_text(keyboard_string);
}

pasteTextFromClipbaord = function(){
	keyboard_string = clipboard_get_text();
}

t_scene_info =
[
	[cutscene_dialogue,"gen",spr_blank, "* (But nobody came.)",0.55,true,"dynamic"],
	[cutscene_end]
]

create_cutscene(t_scene_info)