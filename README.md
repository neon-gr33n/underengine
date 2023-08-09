# ![e8e3ddeb7836cc7735487f15e54dfef3](https://github.com/purrception/underengine/assets/41244356/57504c54-da8b-42c9-9d14-268d9c5552c5)
A versatile UNDERTALE fangame engine designed to make creating your dream fangame easier than ever before.

note: this document is a wip, sections may be missing or unfinished

## Contents
- **Getting Started**
- **Features**
- **Documentation**
- **Issue Tracker**
- **Credits**

### Getting Started
Firstly, install GameMaker: Studio 2 if you haven't already, and as a sidenote: you may need a subscription if you didn't previously purchase the software off of steam, or a similar platform
during the era when perpetual licenses were being sold- refer to this page for further information regarding this: https://gamemaker.io/en/get 

After installing GameMaker: Studio 2, you can go ahead and get started! simply download or clone this repo onto your computer, in a folder where it's easily accessible to you, extract the .zip file that you downloaded, and you should have a folder called "underengine-main", if all looks good, then all you really need to do is open the project file! 

![image](https://github.com/neon-gr33n/underengine/assets/41244356/d1ebec89-251e-493d-9e65-dc355cda6d0d)

And just like that, you're good to go! You're now able to go ahead and start making your very own UNDERTALE fangame! Feel free to explore! modify MACROS.gml to suit your needs, and check out the documentation as well (wip)

### Features
UNDERENGINE is a versatile fangame engine with an emphasis on **cutsomization,** accounting for as many of the users needs as possible, as such, it's packed with **plenty of features**, check out the list below!

- **16:9 Aspect Ratio support**, allowing your game to display seamlessly even at 8K!
- Flexible Dialog System, with text writer/typewriter, portraits, voices, dynamic positioning, and an optional argument to execute additional code when dialog is being called!
- Simple and extendable cutscene system
- Easily extendable player character, running off of a state machine for your convenience!
- Easily modifiable overworld "C" Menu
- Basic party system, with support for adding/removing members, and having "followers" in the overworld, like DELTARUNE!
- Versatile audio system, with easy to use effect presets!
- **Full controller support!**
- Easily modifiable battle system

### Documentation
(to be added)

### Issue Tracker
You can either check TODO.md, or UNDERENGINE's own Trello Board for information regarding bugs being fixed, planned features, or just general engine progress
https://trello.com/invite/b/6x4hOU9S/ATTI4c5f90a47259b59eb6e404a719a89a5aB4FC7CF7/underengine

### Credits
UNDERENGINE was created by myself (Neon-Gr33n) for the most part however, credit where credit is due since we do lean on certain third party libraries for the sake of making certain features or tasks easier to pull off, below is a full list of credits

- [@jujuadams](https://github.com/jujuadams) - Creating ["Scribble"](https://github.com/JujuAdams/scribble) and ["Vinyl"](https://github.com/JujuAdams/Vinyl) (among his various other intruiging libraries) as a versatile text engine used for text drawing and setup within UNDERENGINE and a flexible audio engine to allow greater control over sound design within UNDERENGINE.
- [@jack27121](https://github.com/jack27121) - Creating ["STANNCam"](https://github.com/jack27121/STANNcam/) the modular camera engine used in underengine that was modified to support up to 8K
- [@Hyomoto](https://github.com/Hyomoto) - Creating ["FAST (Flexible Assistant Tool Kit"](https://github.com/Hyomoto/FAST) the way we handle seamless upscaling is through FASTs' own Render engine
- [@FriendlyCosmonaut](https://www.youtube.com/@FriendlyCosmonaut/) - Hosts resources which I used in making the cutscene system, as well as introduction to [GameMaker's Sequencer](https://manual.yoyogames.com/The_Asset_Editors/Sequences.htm)
- [@messhof](https://github.com/messhof) - Creating ["InputDog"](https://github.com/messhof/Input-Dog/tree/master) the input library used in UNDERENGINE
- [@8BitWarrior](https://marketplace.gamemaker.io/publishers/30/stephen-loney) - Creating ["TweenGMX"](https://marketplace.gamemaker.io/assets/10871/tweengmx) the animation tweening libary used inside of UNDERENGINE
