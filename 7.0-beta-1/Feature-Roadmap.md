# Feature Roadmap

There are some features that have yet to be implemented fully, or that need revisions to better improve the users experience when using **underengine**, and in order to remain transparent, below, you'll find a list of features and fixes/revisions we plan to implement 

*This list will be updated as we continue to progress through development of this engine~*

Want to see your idea on this list? [File an issue on Github Issues](https://github.com/neon-gr33n/underengine/issues)! (please label it using the "enhancement" tag, thank you.)

### v8.0-beta-2
#### New Additions
- Improved battle board/battle box!
- Cloud saving (when logged in to GameJolt)
- Dynamic achievement display in trophies hub of **obj_gjmenu**
- Modified "C" Menu with support for easily adding new menu options (up to 5!)

#### Revisions

 - Improve upon the existing ACTing system by allowing users to mix and match different ACTs for different results (think like the Dogamy and Dogaressa fight in UNDERTALE, as an example!)
 - Adjust **obj_ow_cutscenetrigger** such that we can show unique dialog after each reset, like in UNDERTALE! (This is entirely up to the user to use, or not!)
 - Improve upon **cutscene_choice** and **obj_choice_text** to make it easier to add new options 
	 - (up to 4 like in Deltarune!)
- Improve the battlegroup RNG system in **obj_random_encounter_handler** to allow encounters to have a lower or higher chance of occurring, or even not be able to appear until a certain room is reached!
- Improved usability for the shop system (Helper functions, easy configuration, so on)

#### Fixes

 - Fix a bug with the camera zoom functionality where the zoom simply will not trigger on some platforms
	 - In addition to this, add functionality to zoom in on a specific object
- Fix issues with invincibility/I-Frames in obj_battle_soul
- Fix display issues when toggling fullscreen with F4
- Fix stat modification functions for enemies to work with more than one instance of an enemy 
	- (e.g maybe you want to modify an enemy to have lower defense after its ally is spared or slain)
- Fix user profile picture loading via the "users/fetch" endpoint of the GameJolt API in **obj_gj_login**

### v9.0-beta-3
	
*No plans have been discussed yet- check back later!*


### v1.0.0 (full release)
	
*No plans have been discussed yet- check back later!*
