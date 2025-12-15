/**
 * Gets the leader of the current party (first member).
 * @example
 * var leader = party_get_leader();
 * @returns {object} The party leader object
 */
function party_get_leader() {
	return party_get_member(0);
}

/**
 * Gets a party member by their index in the party array.
 * @example
 * // Get second party member (index 1)
 * var member = party_get_member(1);
 * @param {number} index - Position in party (0 for leader)
 * @returns {object} Party member object
 */
function party_get_member(index) {
	return party_get_attribute("MEMBERS")[@ index];
}

/**
 * Finds the index of a specific member in the party.
 * @example
 * var index = party_get_index(memberObject);
 * @param {object} member - Member object to find
 * @returns {number} Index in party, or -1 if not found
 */
function party_get_index(member) {
	return array_get_index(party_get_attribute("MEMBERS"), member);
}

/**
 * Adds a member to the party.
 * @example
 * // Add to next available slot
 * party_add_member(newMember);
 * 
 * @example
 * // Insert at specific position (slot 2)
 * party_add_member(newMember, 2);
 * 
 * @param {object} member - Member object to add
 * @param {number} slot - Position to add (-1 for end, default)
 */
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

/**
 * Removes a party member by index.
 * @example
 * // Remove third member (index 2)
 * party_remove_index(2);
 * 
 * @example
 * // Remove last member
 * party_remove_index(-1);
 * 
 * @param {number} slot - Index to remove (-1 for last)
 */
function party_remove_index(slot) {
	var party = party_get_attribute("MEMBERS");
	if (slot == -1) {
		array_pop(party);
	} else {
		array_delete(party, slot, 1);
	}
}

/**
 * Removes a specific member from the party.
 * @example
 * party_remove_member(memberObject);
 * @param {object} member - Member object to remove
 */
function party_remove_member(member) {
	party_remove_index(party_get_index(member));
}

/**
 * Swaps two party members by their indices.
 * @example
 * // Swap first and second members
 * party_swap_indices(0, 1);
 * @param {number} index1 - First index
 * @param {number} index2 - Second index
 */
function party_swap_indices(index1, index2) {
	array_swap(party_get_attribute("MEMBERS"), index1, index2);
}

/**
 * Swaps two specific party members.
 * @example
 * party_swap_members(member1, member2);
 * @param {object} member1 - First member
 * @param {object} member2 - Second member
 */
function party_swap_members(member1, member2) {
	party_swap_indices(party_get_index(member1), party_get_index(member2));
}

/**
 * Abandons all party members except the specified leader.
 * @example
 * // Keep only CHARA
 * party_abandon();
 * 
 * @example
 * // Keep only a specific leader
 * party_abandon(someLeader);
 * 
 * @param {object} leader - Leader to keep (default "CHARA")
 */
function party_abandon(leader="CHARA") {
	party_set_attribute("MEMBERS", [leader]);
}

/**
 * Gets an attribute from a member object.
 * @example
 * var name = member_get_attribute(member, "NAME");
 * @param {object} member - Member object
 * @param {string} attribute - Attribute name
 * @returns {any} Attribute value
 */
function member_get_attribute(member, attribute) {
	return global.PARTY_INFO[$ member][$ attribute];
}

/**
 * Sets an attribute on a member object.
 * @example
 * member_set_attribute(member, "NAME", "New Name");
 * @param {object} member - Member object
 * @param {string} attribute - Attribute name
 * @param {any} value - New value
 */
function member_set_attribute(member, attribute, value) {
	global.PARTY_INFO[$ member][$ attribute] = value;
}

/**
 * Gets a specific stat from a member.
 * @example
 * var hp = member_get_stat(member, "HP");
 * @param {object} member - Member object
 * @param {string} stat - Stat name ("HP", "MP", etc.)
 * @returns {number} Stat value
 */
function member_get_stat(member, stat) {
	return member_get_attribute(member, "STATS")[$ stat];
}

/**
 * Sets a specific stat for a member.
 * @example
 * member_set_stat(member, "HP", 100);
 * @param {object} member - Member object
 * @param {string} stat - Stat name
 * @param {number} value - New stat value
 */
function member_set_stat(member, stat, value) {
	member_get_attribute(member, "STATS")[$ stat] = value;
}

/**
 * Modifies a member's stat by adding/subtracting a value.
 * @example
 * // Heal 50 HP
 * member_change_stat(member, "HP", 50);
 * 
 * @example
 * // Take 20 damage
 * member_change_stat(member, "HP", -20);
 * 
 * @param {object} member - Member object
 * @param {string} stat - Stat name
 * @param {number} value - Amount to change (positive or negative)
 */
function member_change_stat(member, stat, value) {
	member_get_attribute(member, "STATS")[$ stat] += value;
}

/**
 * Fully heals a member's HP.
 * @example
 * member_recover_HP(member);
 * @param {object} member - Member object
 */
function member_recover_HP(member) {
	member_set_stat(member, "HP", member_get_stat(member, "MAX_HP"));
}

/**
 * Fully restores a member's MP.
 * @example
 * member_recover_MP(member);
 * @param {object} member - Member object
 */
function member_recover_MP(member) {
	member_set_stat(member, "MP", member_get_stat(member, "MAX_MP"));
}

/**
 * Fully heals HP for all party members.
 * @example
 * members_recover_HP();
 */
function members_recover_HP() {
	array_foreach(party_get_attribute("members"), member_recover_HP);
}

/**
 * Fully restores MP for all party members.
 * @example
 * members_recover_MP();
 */
function members_recover_MP() {
	array_foreach(party_get_attribute("members"), member_recover_MP);
}