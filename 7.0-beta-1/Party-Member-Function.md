# Party Member Function

## `party_get_leader()` → *object*
Gets the leader of the current party (first member)

**Returns:** The party leader object

## `party_get_member(index)` → *object*
Gets a party member by their index in the party array

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`index` |number |Position in party (0 for leader) |

**Returns:** Party member object

## `party_get_index(member)` → *number*
Finds the index of a specific member in the party

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object to find |

**Returns:** Index in party, or -1 if not found

## `party_add_member(member, [slot])` → `undefined`
Adds a member to the party

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object to add |
|`[slot=-1]` |number |Position to add (-1 for end) |














## `party_remove_index(slot)` → `undefined`
Removes a party member by index

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`slot` |number |Index to remove (-1 for last) |










## `party_remove_member(member)` → `undefined`
Removes a specific member from the party

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object to remove |





## `party_swap_indices(index1, index2)` → `undefined`
Swaps two party members by their indices

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`index1` |number |First index |
|`index2` |number |Second index |





## `party_swap_members(member1, member2)` → `undefined`
Swaps two specific party members

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member1` |object |First member |
|`member2` |object |Second member |





## `party_abandon([leader])` → `undefined`
Abandons all party members except the specified leader

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[leader="FRISK"]` |object |Leader to keep |





## `member_get_attribute(member, attribute)` → *any*
Gets an attribute from a member object

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |
|`attribute` |string |Attribute name |

**Returns:** Attribute value

## `member_set_attribute(member, attribute, value)` → `undefined`
Sets an attribute on a member object

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |
|`attribute` |string |Attribute name |
|`value` |any |New value |





## `member_get_stat(member, stat)` → *number*
Gets a specific stat from a member

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |
|`stat` |string |Stat name ("HP", "MP", etc.) |

**Returns:** Stat value

## `member_set_stat(member, stat, value)` → `undefined`
Sets a specific stat for a member

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |
|`stat` |string |Stat name |
|`value` |number |New stat value |





## `member_change_stat(member, stat, value)` → `undefined`
Modifies a member's stat by adding/subtracting a value

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |
|`stat` |string |Stat name |
|`value` |number |Amount to change (positive or negative) |





## `member_recover_HP(member)` → `undefined`
Fully heals a member's HP

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`member` |object |Member object |





## `members_recover_HP()` → `undefined`
Fully heals HP for all party members
