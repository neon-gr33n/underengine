# Encounter Start

## `encounter_start(_battlegroup_id, [_mus_id], [_mus_pitch], [_exclaim], [_quick], [_boss])` → `undefined`
Starts a battle encounter with specified parameters

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`_battlegroup_id` |string |Identifier for the enemy battlegroup to encounter |
|`[_mus_id="battle"]` |string |Music track to play during battle |
|`[_mus_pitch=0.95]` |number |Pitch adjustment for battle music |
|`[_exclaim=true]` |boolean |Show exclamation animation in overworld |
|`[_quick=false]` |boolean |Make exclamation animation quick |
|`[_boss=false]` |boolean |Mark as boss battle |

