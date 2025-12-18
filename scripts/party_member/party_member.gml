/// @category Game
/// @title Party Member Function

/// @function party_get_leader()
/// @description Gets the leader of the current party (first member)
/// @returns {object} The party leader object
function party_get_leader() {
	return party_get_member(0);
}

/// @function party_get_member(index)
/// @description Gets a party member by their index in the party array
/// @param {number} index Position in party (0 for leader)
/// @returns {object} Party member object
function party_get_member(index) {
	return party_get_attribute("MEMBERS")[@ index];
}

/// @function party_get_index(member)
/// @description Finds the index of a specific member in the party
/// @param {object} member Member object to find
/// @returns {number} Index in party, or -1 if not found
function party_get_index(member) {
	return array_get_index(party_get_attribute("MEMBERS"), member);
}

/// @function party_add_member(member, [slot])
/// @description Adds a member to the party
/// @param {object} member Member object to add
/// @param {number} [slot=-1] Position to add (-1 for end)
function party_add_member(member, slot=-1) {
	var party = party_get_attribute("MEMBERS");
	if (array_length(party) < party_get_attribute("MAXPARTYSIZE")) {
		if (slot == -1) {
			array_push(party, member);
		} else {
			array_insert(party, slot, member);
		}
	} else {
		show_debug_message("But the party was full...");
	}
}

/// @function party_remove_index(slot)
/// @description Removes a party member by index
/// @param {number} slot Index to remove (-1 for last)
function party_remove_index(slot) {
	var party = party_get_attribute("MEMBERS");
	if (slot == -1) {
		array_pop(party);
	} else {
		array_delete(party, slot, 1);
	}
}

/// @function party_remove_member(member)
/// @description Removes a specific member from the party
/// @param {object} member Member object to remove
function party_remove_member(member) {
	party_remove_index(party_get_index(member));
}

/// @function party_swap_indices(index1, index2)
/// @description Swaps two party members by their indices
/// @param {number} index1 First index
/// @param {number} index2 Second index
function party_swap_indices(index1, index2) {
	array_swap(party_get_attribute("MEMBERS"), index1, index2);
}

/// @function party_swap_members(member1, member2)
/// @description Swaps two specific party members
/// @param {object} member1 First member
/// @param {object} member2 Second member
function party_swap_members(member1, member2) {
	party_swap_indices(party_get_index(member1), party_get_index(member2));
}

/// @function party_abandon([leader])
/// @description Abandons all party members except the specified leader
/// @param {object} [leader="FRISK"] Leader to keep
function party_abandon(leader="FRISK") {
	party_set_attribute("MEMBERS", [leader]);
}

/// @function member_get_attribute(member, attribute)
/// @description Gets an attribute from a member object
/// @param {object} member Member object
/// @param {string} attribute Attribute name
/// @returns {any} Attribute value
function member_get_attribute(member, attribute) {
	return global.PARTY_INFO[$ member][$ attribute];
}

/// @function member_set_attribute(member, attribute, value)
/// @description Sets an attribute on a member object
/// @param {object} member Member object
/// @param {string} attribute Attribute name
/// @param {any} value New value
function member_set_attribute(member, attribute, value) {
	global.PARTY_INFO[$ member][$ attribute] = value;
}

/// @function member_get_stat(member, stat)
/// @description Gets a specific stat from a member
/// @param {object} member Member object
/// @param {string} stat Stat name ("HP", "MP", etc.)
/// @returns {number} Stat value
function member_get_stat(member, stat) {
	return member_get_attribute(member, "STATS")[$ stat];
}

/// @function member_set_stat(member, stat, value)
/// @description Sets a specific stat for a member
/// @param {object} member Member object
/// @param {string} stat Stat name
/// @param {number} value New stat value
function member_set_stat(member, stat, value) {
	member_get_attribute(member, "STATS")[$ stat] = value;
}

/// @function member_change_stat(member, stat, value)
/// @description Modifies a member's stat by adding/subtracting a value
/// @param {object} member Member object
/// @param {string} stat Stat name
/// @param {number} value Amount to change (positive or negative)
function member_change_stat(member, stat, value) {
	member_get_attribute(member, "STATS")[$ stat] += value;
}

/// @function member_recover_HP(member)
/// @description Fully heals a member's HP
/// @param {object} member Member object
function member_recover_HP(member) {
	member_set_stat(member, "HP", member_get_stat(member, "MAX_HP"));
}

/// @function members_recover_HP()
/// @description Fully heals HP for all party members
function members_recover_HP() {
	array_foreach(party_get_attribute("members"), member_recover_HP);
}