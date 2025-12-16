# Overworld

## Room setup

First, create a room, and name it, don't worry about enabling viewports, <b>**obj_master_camera**</b> will handle that for you.
Now that we have a room, let's add it to <b>**room_data_init**</b>

In this example, we have a room called **rm_area_0** assigned to an area called **"FALLEN"**

Let's start editing **room_data_init()**

### Adding new rooms

In this function, you'll see global.room_data, which is a [struct]([Structs &amp; Constructors](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Overview/Structs.htm)) used to initialize data for ALL rooms. you'll see **ROOM, AREAS**, and **ROOMS**, for this example, we will only be modifying the **ROOM** and **ROOMS** variables, but if you need to add a new area, it's fairly self explanatory, add a new entry to **ROOM** like this

`"rm_area_0" : "FALLEN"`

Doesn't really matter where in the struct you place it, but if there is an entry below , remember to add a comma at the end, now then, double check **ROOMS **prior to running to ensure you named "FALLEN" correctly, should look something like this

```gml
FALLEN : {
 NAME : "Cave",
 AREA : "RUINS",
 THEME : noone,
 },
```

*(Read further to the section "Adding new areas" to find out how to add more areas to your game)*

### Adding new areas

To add a new area in room_data_init, simply go to the `AREAS : {}` struct within globa.room_data, and add a new entry, for example, let's say you want to have a SNOWDIN area, you'd do the following

```gml
SNOWDIN : {
 NAME : "Snowdin", 
}
```

Don't forget to add obj_ow_party into your new room, that'll serve as your initial "spawn point", such to speak!

It's really that simple, and you can do this as many times as you need!

## Collisions

This part is straightforward, to add collisions, all you need to do is place obj_solid, or obj_solid_slope (or even a custom object that is parented to obj_solid!) on your map, and stretch it's X or Y scale as needed! The game will automatically handle collision for you!

## Backgrounds / Foregrounds

You can draw backgrounds and foregrounds either by using the room's background [layer]([Layer Properties](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Room_Properties/Layer_Properties.htm)) or creating an object to manually draw the background.

## BGM (Background Music)

Music is without a doubt one of the most important aspects of a game, we have created
an easy-to-use system for you to play your own BGM in the overworld.

Firstly, if you defined a THEME during your room setup, the music will automatically begin playing when you enter the room,
else, if you defined the theme as noone, you can alternatively run 
```gml
mus_playx(mus_load("example"),true,global.mus_volume,0,1,0) // Where "example" is the external assets file name, must be in data/mus/ in the included files and exported in the .ogg file format
```
in the room's creation code, see "mus_playx" for further details

## Cutscenes
Cutscenes are vital in games that contain a full overworld, and we do offer built-in support for this!
Just use `cutscene` functions that are built into the engine, to achieve a cutscene upon collision with a trigger, 
use `obj_ow_cutscenetrigger` simply put your scene info in the creation code

Example - Basic dialogue interaction
```gml
scene_info = [
	[cutscene_dialogue,"sans", spr_port_sans_gen, "hey kid. long time no see."],
	[cutscene_wait_for_dialogue],
]
```
This example will trigger an interaction, in this case, with sans, upon colliding with `obj_ow_cutscene_trigger` (this assumes you already have sans sprites, which should come included with the engine)

You can also apply the same logic to NPCs, as they are designed to support cutscenes from the get-go, simply set `npc_interactable` to true 
in the NPCs instance creation code, all NPCs are a child of obj_ow_npc, and can have unique sprites, talk sprites, so on.

This is just a barebones example, please review the cutscene_* scripts and their respective documentation to get a better understanding of how to use this system
