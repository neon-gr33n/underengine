choiceSelection = clamp(choiceSelection,0,1);
global.soulChosen = clamp(global.soulChosen,0,1);
if inputdog_pressed("right")
{
		choiceSelection += 1;
		global.soulChosen += 1;
}
if inputdog_pressed("left")
{
		choiceSelection -= 1;
		global.soulChosen -= 1;
}