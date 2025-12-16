# Cutscenes

## `cutscene_choice([_text], [_choice0], [_choice1], [_func0], [_func1], [_text_level], [_preselected])` → `undefined`
Creates a binary choice dialog during cutscenes (Yes/No style)
Note: This function needs revision to make adding new options easier

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`[_text=""]` |String |Prompt text displayed above choices |
|`[_choice0="Yes"]` |String |Text for first choice option (typically "Yes") |
|`[_choice1="No"]` |String |Text for second choice option (typically "No") |
|`[_func0]` |Function |Callback function executed when first choice is selected |
|`[_func1]` |Function |Callback function executed when second choice is selected |
|`[_text_level=0]` |Number |Text display level/priority (affects rendering order) |
|`[_preselected=0]` |Number |Initially selected choice (0 = first choice, 1 = second choice) |
```gml
 // Simple Yes/No choice
 cutscene_choice("Do you want to continue?", "Yes", "No", 
     function() { show_debug_message("Player chose Yes"); },
     function() { show_debug_message("Player chose No"); });
 
```gml
 // Custom choice with preselected option
 cutscene_choice("Which path will you take?", "Left", "Right",
     function() { go_left(); },
     function() { go_right(); },
     0, 1); // Preselects "Right" (index 1)
 
```gml
 // TODO: Revise this function to support:
 // - Variable number of choices (not just binary)
 // - Easier addition of new options
 // - Better callback handling
```
