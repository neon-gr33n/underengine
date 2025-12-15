///@desc Initialize
_menuSelection = 0;  // 0 - New Game 1 - Continue  2 - Extras  3 - Settings  4 - Exit
_menuCursorYOffset = 0;

state = "menuPre";
logoPosX = 142;
logoPosY = 126;

alpha = 0;

HEART.returning=0;
HEART._spritex=30;
HEART._spritey=160+_menuSelection*40;
HEART.x=30;
HEART.y=165+_menuSelection*40;
HEART.visible=true;
HEART.image_alpha=0;