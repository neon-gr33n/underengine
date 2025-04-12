function party_abandon() {
	for(var i = 0; i < array_length(global.partymember) - 1; i++) {
		global.partymember[i] = noone;
	}
}