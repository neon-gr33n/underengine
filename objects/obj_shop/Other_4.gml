objCAM.following = noone;
with (CAM) {
    x = 0;
    y = 0;
}

// Reset menu selection
_menuSelection = 0;

// Play shop music (if not already set by ShopSetMusic)
var shop = ShopGetCurrent();
if (shop && shop.MUSIC != "") {
    mus_playx(mus_load(shop.MUSIC), true, , , 0.95);
} else {
    // Fallback to default shop music
    mus_playx(mus_load("shop"), true, , , 0.95);
}