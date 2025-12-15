function cutscene_instance_create() {
    /// @description cutscene_instance_create
    /// @arg x
    /// @arg y
    /// @arg layer_id
    /// @arg obj
    /// @arg struct (optional) - var_struct for instance_create_layer
    
    // Check if we have the optional struct argument
    var _struct = noone;
    if (argument_count >= 5) {
        _struct = argument[4];
    }
    
    var inst = noone;
    
    // Create instance with or without struct based on argument count
    if (argument_count >= 5 && !is_undefined(_struct)) {
        inst = instance_create_layer(argument0, argument1, argument2, argument3, _struct);
    } else {
        inst = instance_create_layer(argument0, argument1, argument2, argument3);
    }
    
    // Check if instance was successfully created before calling end action
    if (instance_exists(inst)) {
        cutscene_end_action();
    } else {
        // Optional: Handle the case where instance creation failed
        show_debug_message("cutscene_instance_create: Failed to create instance of " + object_get_name(argument3));
    }
    
    return inst;
}
