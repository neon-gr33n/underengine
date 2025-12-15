function gj_util_determinesuccess()
{
	if global.response.response.success
	{
		return "SUCCESS";		
	} else if global.response.response.message == "The Game ID you passed in does not point to a valid game."
	{
		return "INVALID GAME ID";
	} else if global.response.response.message == "No such user with the credentials passed in could be found."
	{
		return "INVALID CREDENTIALS";
	} else if !gj_util_checkformessage()
	{
		return "SERVER PROVIDED NO MESSAGE, REFER TO FULL RESPONSE";	
	}
}

function gj_util_checkformessage()
{
	// Feather ignore GM1041
	if struct_exists(global.response.response, "message")
	{
		return true;
	} else return false;
}

global.popupcount = 0;

function gj_util_createpopup(ttl, cont)
{
	if extension_get_option_value("ext_frostjolt", "GJ_ENABLEPOPUPS") == false exit;
	instance_create_layer(0, 0, "Instances", obj_gj_corner_popup, 
	{
		title : ttl,
		txt : cont
	});
	global.popupcount += 1;

}

function gj_util_createdebugpopup(ttl, cont)
{
	if extension_get_option_value("ext_frostjolt", "GJ_DEBUGPOPUPS") == false exit;
	instance_create_layer(0, 0, "Instances", obj_gj_corner_debugpopup, 
	{
		title : ttl,
		txt : cont
	});
	global.popupcount += 1;

}

function gj_util_createtrophypopup(ttl, cont, trophy)
{
	if extension_get_option_value("ext_frostjolt", "GJ_ENABLEPOPUPS") == false exit;
	instance_create_layer(0, 0, "Instances", obj_gj_corner_trophypopup, 
	{
		title : ttl,
		txt : cont,
		trophy_sprite : trophy
	});
	global.popupcount += 1;

}

function gj_util_storecredentials(username, token)
{
    show_debug_message("Storing credentials for: " + string(username));
    
    var map = ds_map_create()
    
    // Debug the encoding process
    var encoded_username = base64_encode(username);
    var encoded_token = base64_encode(token);
    
    show_debug_message("Encoded username: " + string(encoded_username));
    show_debug_message("Encoded token: " + string(encoded_token));
    
    ds_map_set(map, "username", encoded_username)
    ds_map_set(map, "token", encoded_token)
    
    var buff = buffer_create(128, buffer_grow, 1)
    ds_map_secure_save_buffer(map, buff)
    ds_map_destroy(map)
    
    // Save directly without custom encryption/compression
    buffer_save(buff, "gamejolt_cred.bin")
    buffer_delete(buff)
    
    show_debug_message("✓ Credentials saved successfully");
    return true;
}

function gj_util_loadcredentials()
{
    if file_exists("gamejolt_cred.bin")
    {
        show_debug_message("✓ Credentials file found: gamejolt_cred.bin");
        
        var buff = buffer_load("gamejolt_cred.bin")
        if (buff == -1)
        {
            show_debug_message("✗ Failed to load buffer from file");
            return 0;
        }
        
        show_debug_message("✓ Buffer loaded successfully, size: " + string(buffer_get_size(buff)) + " bytes");
        
        var map = ds_map_secure_load_buffer(buff)
        buffer_delete(buff)
        
        if ds_exists(map, 1)
        {
            show_debug_message("✓ DS Map loaded successfully");
            
            // Debug: Show all keys and their raw values
            var key = ds_map_find_first(map);
            var i = 0;
            while (!is_undefined(key)) {
                var value = ds_map_find_value(map, key);
                show_debug_message("Key[" + string(i) + "]: '" + string(key) + "' = '" + string(value) + "'");
                show_debug_message("Value type: " + typeof(value));
                show_debug_message("Value length: " + string(string_length(value)));
                key = ds_map_find_next(map, key);
                i++;
            }
            
            var username_exists = ds_map_exists(map, "username");
            var token_exists = ds_map_exists(map, "token");
            
            show_debug_message("Username key exists: " + string(username_exists));
            show_debug_message("Token key exists: " + string(token_exists));
            
            if (username_exists && token_exists) {
                var encoded_username = ds_map_find_value(map, "username");
                var encoded_token = ds_map_find_value(map, "token");
                
                show_debug_message("Raw encoded username: '" + string(encoded_username) + "'");
                show_debug_message("Raw encoded token: '" + string(encoded_token) + "'");
                
                // Test base64 decoding
                var test_decode_username = base64_decode(encoded_username);
                var test_decode_token = base64_decode(encoded_token);
                
                show_debug_message("Base64 decode result - username: " + string(test_decode_username));
                show_debug_message("Base64 decode result - token: " + string(test_decode_token));
                
                // Try alternative decoding approach
                if (is_undefined(test_decode_username)) {
                    show_debug_message("Base64 decode failed for username, trying string conversion...");
                    encoded_username = string(encoded_username);
                    test_decode_username = base64_decode(encoded_username);
                    show_debug_message("After string conversion: " + string(test_decode_username));
                }
                
                global.gj_username = test_decode_username;
                global.gj_token = test_decode_token;
                
                ds_map_destroy(map)
                
                if (!is_undefined(global.gj_username) && !is_undefined(global.gj_token)) {
                    show_debug_message("✓ Successfully loaded credentials");
                    return 1;
                } else {
                    show_debug_message("✗ Credentials are undefined after decoding");
                    return 0;
                }
            }
        }
        
        show_debug_message("✗ Failed to load credentials from map");
        if (ds_exists(map, 1)) {
            ds_map_destroy(map)
        }
        return 0;
    }
    else
    {
        show_debug_message("✗ Credentials file not found");
        return 0;
    }
}