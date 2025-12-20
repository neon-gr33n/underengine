idleSprite = undefined;
moveSprite = undefined;
talkSprite = undefined;

local_frame = 0;
talk_frame = 0;     // Current frame of the talking animation
talk_speed = 0.1; // Adjust for animation speed
npc_moving = false; // Is the NPC moving?
npc_talking = false; // Is the NPC talking?
npc_turnable = false; // Can NPC turn?
npc_interactable = false; // Is the NPC interactable?
needs_portrait = false; // Does the NPC need a portrait sprite for talking animations?

scaleX = 1;
scaleY = 1;
alpha = 1;
global._interacting = noone;

event_inherited();

dir = "down";