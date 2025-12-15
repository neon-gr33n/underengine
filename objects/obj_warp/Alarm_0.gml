var landmarked = landmark
with (obj_landmark) {
	if num=landmarked {
		PLAYER1.x=x+10*image_xscale;
		PLAYER1.y=y+10*image_yscale;
	}
}
for (i=0;i<=75;i++) {
	PLAYER1.remdir[i]=dir;
}

instance_destroy(id)
