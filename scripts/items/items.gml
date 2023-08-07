function Item () constructor {
	longName = "";
	shortName = "";
	seriousName = "";
	checkText = "";
	buyPrice = 0;
	sellPrice = 0;
}

function HealingItem () : Item () constructor {
	longName = ""
	shortName = "";
	seriousName = "";
	checkText = ""
	buyPrice = 0;
	sellPrice = 0;
	
	hpGain  = 0;
}

function Test () : HealingItem () constructor {
	longName = "TestItem"
	shortName = "";
	seriousName = "Test";
	checkText = "Test Item!#Heals 10 HP."
	buyPrice = 0;
	sellPrice = 0;
	
	hpGain  = 10;
}