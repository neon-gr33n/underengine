show_debug_message("=== ASYNC_LOAD DEBUG ===");
show_debug_message("Processing async_load in room: " + string(room));

// DEBUG: Show ALL keys in async_load to see what's actually available
show_debug_message("=== ASYNC_LOAD FULL DUMP ===");
var async_keys = ds_map_find_first(async_load);
var key_count = 0;
while (!is_undefined(async_keys)) {
    var key_value = ds_map_find_value(async_load, async_keys);
    show_debug_message("Key: " + string(async_keys) + " = " + string(key_value));
    async_keys = ds_map_find_next(async_load, async_keys);
    key_count++;
}
show_debug_message("Total keys in async_load: " + string(key_count));
show_debug_message("=== END DUMP ===");

var r_id = ds_map_find_value(async_load, "id");
var r_status = ds_map_find_value(async_load, "status");
var r_result = ds_map_find_value(async_load, "result");
var r_url = ds_map_find_value(async_load, "url");

show_debug_message("=== HTTP REQUEST ANALYSIS ===");
show_debug_message("Looking for request ID: " + string(global.__gj_avatar_request));
show_debug_message("Current r_id: " + string(r_id));
show_debug_message("Do they match? " + string(global.__gj_avatar_request == r_id));

if (r_id != undefined) {
    show_debug_message("📡 HTTP REQUEST " + string(r_id) + " COMPLETED");
    show_debug_message("   Status: " + string(r_status));
    show_debug_message("   URL: " + string(r_url));
    
    // Check if this is our avatar request
    if (r_id == global.__gj_avatar_request) {
        show_debug_message("🎯 THIS IS OUR AVATAR REQUEST!");
    } else {
        show_debug_message("❌ This is a different request (not avatar)");
    }
} else {
    show_debug_message("❌ No HTTP request ID in this async event");
}
show_debug_message("=== END HTTP ANALYSIS ===");

show_debug_message("r_id: " + string(r_id));
show_debug_message("r_status: " + string(r_status));
show_debug_message("r_url: " + string(r_url));
show_debug_message("global.network_callback: '" + string(global.network_callback) + "'");
show_debug_message("global.__gj_avatar: " + string(global.__gj_avatar));
show_debug_message("global.__gj_avatar_request: " + string(global.__gj_avatar_request));
show_debug_message("global.__gj_avatar_url: " + string(global.__gj_avatar_url));

// Initialize default avatar if not set
if (!sprite_exists(global.__gj_avatar)) {
    show_debug_message("🔄 Initializing default avatar...");
    global.__gj_avatar = spr_gj_default_avi;
    show_debug_message("✅ Default avatar set: " + string(global.__gj_avatar));
}

if (r_id == undefined || r_status == undefined) {
    show_debug_message("❌ Missing required fields in async_load - returning early");
    return; 
}

// 🆕 NEW: Handle avatar image download - track by URL pattern (MORE RELIABLE)
if (r_url != undefined && (string_pos("/user-avatar/", r_url) > 0 || string_pos("gj_avatar_temp", string(r_url)) > 0)) {
    show_debug_message("🎯 Handling avatar file download async event (URL DETECTION)...");
    show_debug_message("Status: " + string(r_status));
    show_debug_message("URL: " + string(r_url));
    
    if (r_status == 0) {
        show_debug_message("✅ Avatar download completed successfully");
        
        // Find the temp file that was downloaded
        var temp_file = "";
        if (global.__gj_avatar_file != undefined && file_exists(global.__gj_avatar_file)) {
            temp_file = global.__gj_avatar_file;
        } else {
            // Try to find any recent temp files
            temp_file = "gj_avatar_temp_" + string(r_id) + ".png";
        }
        
        show_debug_message("📁 Looking for temp file: " + temp_file);
        
        if (file_exists(temp_file)) {
            show_debug_message("✅ Temp file found, loading sprite...");
            
            // Delete old sprite if it exists and it's not our default
            if (sprite_exists(global.__gj_avatar) && global.__gj_avatar != spr_gj_default_avi) {
                sprite_delete(global.__gj_avatar);
            }
            
            // Load the sprite from the temporary file
            global.__gj_avatar = sprite_add(working_directory + temp_file, 1, false, false, 0, 0);
            show_debug_message("✅ Sprite load result ID: " + string(global.__gj_avatar));
            
            // Verify the sprite was loaded correctly
            if (sprite_exists(global.__gj_avatar)) {
                var spr_width = sprite_get_width(global.__gj_avatar);
                var spr_height = sprite_get_height(global.__gj_avatar);
                
                if (spr_width > 1 && spr_height > 1) {
                    show_debug_message("🎉 Avatar loaded successfully! Size: " + string(spr_width) + "x" + string(spr_height));
                    file_delete(temp_file);
                    show_debug_message("🗑️ Deleted temporary file");
                } else {
                    show_debug_message("❌ Invalid sprite size");
                    sprite_delete(global.__gj_avatar);
                    file_delete(temp_file);
                    set_default_avatar();
                }
            } else {
                show_debug_message("❌ Failed to load sprite");
                file_delete(temp_file);
                set_default_avatar();
            }
        } else {
            show_debug_message("❌ Temp file not found");
            set_default_avatar();
        }
    } else {
        show_debug_message("❌ Download failed with status: " + string(r_status));
        set_default_avatar();
    }
    
    // Clear the request tracking
    global.__gj_avatar_request = undefined;
    global.__gj_avatar_url = undefined;
    global.__gj_avatar_file = undefined;
    show_debug_message("🔄 Cleared avatar request variables");
    return; // stop further processing this async event
}

// 🗑️ OLD: Handle avatar image download via HTTP request (request ID tracking) - KEEP AS FALLBACK
if (global.__gj_avatar_request != undefined && r_id == global.__gj_avatar_request) {
    show_debug_message("🎯 Handling avatar HTTP download async event (ID DETECTION)...");
    show_debug_message("Status: " + string(r_status));
    show_debug_message("URL: " + string(global.__gj_avatar_url));

    if (r_status == 0) {
        show_debug_message("✅ Avatar download completed successfully");
        
        if (r_result != undefined && r_result != "") {
            show_debug_message("📊 Download data size: " + string(string_length(r_result)) + " bytes");
            
            // Create a temporary file to save the image data
            var temp_file = "temp_avatar_" + string(global.__gj_avatar_request) + ".png";
            
            // Save the image data to a temporary file using buffer
            if (file_exists(temp_file)) {
                file_delete(temp_file);
            }
            
            var buffer = buffer_create(string_length(r_result), buffer_fixed, 1);
            buffer_write(buffer, buffer_string, r_result);
            buffer_save(buffer, temp_file);
            buffer_delete(buffer);
            
            show_debug_message("💾 Saved image data to: " + temp_file);
            
            // Delete old sprite if it exists and it's not our default
            if (sprite_exists(global.__gj_avatar) && global.__gj_avatar != spr_gj_default_avi) {
                sprite_delete(global.__gj_avatar);
                show_debug_message("🗑️ Deleted previous avatar sprite");
            }
            
            // Load the sprite from the temporary file
            show_debug_message("🖼️ Loading sprite from temporary file...");
            global.__gj_avatar = sprite_add(temp_file, 1, false, false, 0, 0);
            show_debug_message("✅ Sprite load result ID: " + string(global.__gj_avatar));
            
            // Verify the sprite was loaded correctly
            if (sprite_exists(global.__gj_avatar)) {
                var spr_name = sprite_get_name(global.__gj_avatar);
                var spr_width = sprite_get_width(global.__gj_avatar);
                var spr_height = sprite_get_height(global.__gj_avatar);
                
                show_debug_message("📊 Sprite Details:");
                show_debug_message("   Name: " + spr_name);
                show_debug_message("   Size: " + string(spr_width) + "x" + string(spr_height));
                
                if (spr_width > 1 && spr_height > 1 && spr_name != "bkg_sandbox") {
                    show_debug_message("🎉 Avatar loaded successfully!");
                    // Clean up the temporary file
                    file_delete(temp_file);
                    show_debug_message("🗑️ Deleted temporary file");
                } else {
                    show_debug_message("❌ Downloaded sprite is invalid - trying 60px fallback");
                    sprite_delete(global.__gj_avatar);
                    file_delete(temp_file);
                    
                    // Fallback to 60px version if we were trying 200px
                    if (string_pos("/200/", global.__gj_avatar_url) > 0) {
                        var fallback_url = string_replace(global.__gj_avatar_url, "/200/", "/60/");
                        show_debug_message("🔄 Falling back to 60px: " + fallback_url);
                        
                        var fallback_request = http_get(fallback_url);
                        if (fallback_request != -1) {
                            global.__gj_avatar_request = fallback_request;
                            global.__gj_avatar_url = fallback_url;
                            show_debug_message("📡 Started fallback request ID: " + string(fallback_request));
                            return; // Wait for fallback response
                        } else {
                            show_debug_message("❌ Fallback request failed - using default avatar");
                            set_default_avatar();
                        }
                    } else {
                        show_debug_message("❌ No fallback available - using default avatar");
                        set_default_avatar();
                    }
                }
            } else {
                show_debug_message("❌ Failed to load sprite from file - trying 60px fallback");
                file_delete(temp_file);
                
                // Fallback to 60px version if we were trying 200px
                if (string_pos("/200/", global.__gj_avatar_url) > 0) {
                    var fallback_url = string_replace(global.__gj_avatar_url, "/200/", "/60/");
                    show_debug_message("🔄 Falling back to 60px: " + fallback_url);
                    
                    var fallback_request = http_get(fallback_url);
                    if (fallback_request != -1) {
                        global.__gj_avatar_request = fallback_request;
                        global.__gj_avatar_url = fallback_url;
                        show_debug_message("📡 Started fallback request ID: " + string(fallback_request));
                        return; // Wait for fallback response
                    } else {
                        show_debug_message("❌ Fallback request failed - using default avatar");
                        set_default_avatar();
                    }
                } else {
                    show_debug_message("❌ No fallback available - using default avatar");
                    set_default_avatar();
                }
            }
        } else {
            show_debug_message("❌ No image data received - trying 60px fallback");
            
            // Fallback to 60px version if we were trying 200px
            if (string_pos("/200/", global.__gj_avatar_url) > 0) {
                var fallback_url = string_replace(global.__gj_avatar_url, "/200/", "/60/");
                show_debug_message("🔄 Falling back to 60px: " + fallback_url);
                
                var fallback_request = http_get(fallback_url);
                if (fallback_request != -1) {
                    global.__gj_avatar_request = fallback_request;
                    global.__gj_avatar_url = fallback_url;
                    show_debug_message("📡 Started fallback request ID: " + string(fallback_request));
                    return; // Wait for fallback response
                } else {
                    show_debug_message("❌ Fallback request failed - using default avatar");
                    set_default_avatar();
                }
            } else {
                show_debug_message("❌ No fallback available - using default avatar");
                set_default_avatar();
            }
        }
    } else {
        show_debug_message("❌ Avatar download failed with status: " + string(r_status) + " - trying 60px fallback");
        
        // Fallback to 60px version if we were trying 200px
        if (string_pos("/200/", global.__gj_avatar_url) > 0) {
            var fallback_url = string_replace(global.__gj_avatar_url, "/200/", "/60/");
            show_debug_message("🔄 Falling back to 60px: " + fallback_url);
            
            var fallback_request = http_get(fallback_url);
            if (fallback_request != -1) {
                global.__gj_avatar_request = fallback_request;
                global.__gj_avatar_url = fallback_url;
                show_debug_message("📡 Started fallback request ID: " + string(fallback_request));
                return; // Wait for fallback response
            } else {
                show_debug_message("❌ Fallback request failed - using default avatar");
                set_default_avatar();
            }
        } else {
            show_debug_message("❌ No fallback available - using default avatar");
            set_default_avatar();
        }
    }

    // Only clear if we're not waiting for a fallback
    if (global.__gj_avatar == spr_gj_default_avi || sprite_exists(global.__gj_avatar)) {
        global.__gj_avatar_request = undefined;
        global.__gj_avatar_url = undefined;
        show_debug_message("🔄 Cleared avatar request variables");
    }
    return; // stop further processing this async event
}

// ✅ Process GameJolt API JSON responses - PROCESS ALL SUCCESSFUL REQUESTS!
if (r_status == 0 && r_result != undefined && r_result != "") {
    show_debug_message("🔄 Processing GameJolt API response...");
    
    try {
        var r_j = json_parse(r_result);
        if (r_j == undefined) {
            show_debug_message("❌ Failed to parse JSON");
            return; 
        }
        
        show_debug_message("✅ JSON parsed successfully");
        
        if (variable_struct_exists(r_j, "response")) {
            var response = variable_struct_get(r_j, "response");
            var response_keys = struct_get_names(response);
            show_debug_message("Response keys: " + string(response_keys));
            var r_s = variable_struct_exists(response, "success") ? variable_struct_get(response, "success") : false;
            
            show_debug_message("Callback type: " + global.network_callback);
            show_debug_message("Success value: " + string(r_s));
            
            // DETERMINE THE CALLBACK TYPE BASED ON URL CONTENT
            var detected_callback = global.network_callback; // Start with current callback
            
            // Auto-detect callback type from URL if current callback doesn't match
            if (r_url != undefined) {
                show_debug_message("🔍 Analyzing URL: " + r_url);
                if (string_pos("/users/auth", r_url) > 0) {
                    detected_callback = "users/auth";
                    show_debug_message("🔍 Detected callback: users/auth from URL");
                } else if (string_pos("/users/", r_url) > 0 && string_pos("username=", r_url) > 0) {
                    detected_callback = "users/fetch"; 
                    show_debug_message("🔍 Detected callback: users/fetch from URL");
                } else if (string_pos("/sessions/open", r_url) > 0) {
                    detected_callback = "sessions/open";
                    show_debug_message("🔍 Detected callback: sessions/open from URL");
                } else if (string_pos("/sessions/ping", r_url) > 0) {
                    detected_callback = "sessions/ping";
                    show_debug_message("🔍 Detected callback: sessions/ping from URL");
                }
            }
            
            // Update global callback if we detected a different one
            if (detected_callback != global.network_callback) {
                show_debug_message("🔄 Updating callback from '" + global.network_callback + "' to '" + detected_callback + "'");
                global.network_callback = detected_callback;
            }
            
            switch (global.network_callback) {
                #region User Auth
                case "users/auth":
                    show_debug_message("🔄 Processing users/auth callback...");
        
                    if (r_s == true || r_s == "true") {
                        show_debug_message("✅ Authentication SUCCESS in room: " + string(room));
                        show_debug_message("Username confirmed: " + global.gj_username);
            
                        // Proceed with users/fetch for avatar info
                        show_debug_message("🔄 Starting users/fetch to get avatar URL...");
                        global.network_callback = "users/fetch"; // Set this BEFORE making the request
                        var fetch_request = gj_user_fetch(global.gj_username);
                        show_debug_message("users/fetch request ID: " + string(fetch_request));

                        // Open the session in parallel
                        show_debug_message("🔄 Opening session for: " + global.gj_username);
                        gj_session_open(global.gj_username, global.gj_token);
                        global.__gj_authorized = true;
                    } else {
                        global.__gj_authorized = false;
                        show_debug_message("❌ Authentication failed in room " + string(room) + ": Invalid credentials");
                        set_default_avatar();
                    }
                    break;
                #endregion
                
                #region Fetch User Information - SAFE AVATAR HANDLING
                case "users/fetch":
                    show_debug_message("🔄 Processing users/fetch callback...");
                    show_debug_message("📊 Response structure: " + json_stringify(response));

                    if (r_s == true || r_s == "true") {
                        show_debug_message("✅ User profile fetched successfully");

                        if (variable_struct_exists(response, "users")) {
                            show_debug_message("✅ 'users' key exists in response");
                            var users = variable_struct_get(response, "users");
                            show_debug_message("📊 Users type: " + string(typeof(users)));
                            show_debug_message("📊 Users value: " + string(users));
            
                            if (is_array(users) && array_length(users) > 0) {
                                show_debug_message("✅ 'users' is array with length: " + string(array_length(users)));
                                var user_data = users[0];
                                show_debug_message("📊 User_data type: " + string(typeof(user_data)));
                
                                if (variable_struct_exists(user_data, "avatar_url")) {
                                    var avatar_url = variable_struct_get(user_data, "avatar_url");
                                    show_debug_message("🎯 Raw avatar_url: " + avatar_url);
                                    show_debug_message("🎯 avatar_url length: " + string(string_length(avatar_url)));
                                    show_debug_message("🎯 avatar_url is 'false': " + string(avatar_url == "false"));
                                    show_debug_message("🎯 avatar_url is 'null': " + string(avatar_url == "null"));
                    
                                    if (string_length(avatar_url) > 0 && avatar_url != "false" && avatar_url != "null") {
                                        show_debug_message("✅ Valid avatar URL found!");
                                        show_debug_message("🎯 GameJolt avatar URL: " + avatar_url);

                                        // Begin async image download - load_gj_avatar will handle 200px upgrade
                                        show_debug_message("📥 Starting avatar download...");
                                        var download_id = load_gj_avatar(avatar_url);
                                        show_debug_message("📥 Avatar download started with ID: " + string(download_id));
                                    } else {
                                        show_debug_message("❌ Avatar URL invalid - conditions failed:");
                                        show_debug_message("   - Length > 0: " + string(string_length(avatar_url) > 0));
                                        show_debug_message("   - Not 'false': " + string(avatar_url != "false")); 
                                        show_debug_message("   - Not 'null': " + string(avatar_url != "null"));
                                        show_debug_message("❌ No valid avatar URL found - using default avatar");
                                        set_default_avatar();
                                    }
                                } else {
                                    show_debug_message("❌ 'avatar_url' key does not exist in user_data");
                                    show_debug_message("📊 Available user_data keys: " + string(struct_get_names(user_data)));
                                    set_default_avatar();
                                }

                                // Store user info
                                if (variable_struct_exists(user_data, "username")) {
                                    global.gj_username = variable_struct_get(user_data, "username");
                                    show_debug_message("✅ Updated username: " + global.gj_username);
                                }
                                if (variable_struct_exists(user_data, "id")) {
                                    global.gj_userid = variable_struct_get(user_data, "id");
                                    show_debug_message("✅ Updated user ID: " + string(global.gj_userid));
                                }

                            } else {
                                show_debug_message("❌ 'users' array is empty or invalid");
                                show_debug_message("   - Is array: " + string(is_array(users)));
                                if (is_array(users)) {
                                    show_debug_message("   - Array length: " + string(array_length(users)));
                                }
                                set_default_avatar();
                            }
                        } else {
                            show_debug_message("❌ No 'users' key in response");
                            show_debug_message("📊 Available response keys: " + string(struct_get_names(response)));
                            set_default_avatar();
                        }
                    } else {
                        show_debug_message("❌ User profile fetch failed - success was false");
                        set_default_avatar();
                    }
                    break;
                #endregion
                    
                #region Open Session
                case "sessions/open":
                    if (r_s == true || r_s == "true") {
                        global.__gj_authorized = true;
                        show_debug_message("✅ Session opened successfully in room: " + string(room));
                    } else {
                        global.__gj_authorized = false;
                        show_debug_message("❌ Session opening failed in room: " + string(room));
                    }
                    break;
                #endregion
                    
                #region Ping Session
                case "sessions/ping":
                    if (!sessionClosing && (r_s == true || r_s == "true")) {
                        global.__gj_authorized = true;
                        show_debug_message("✅ Session ping successful in room: " + string(room));
                    } else {
                        global.__gj_authorized = false;
                        show_debug_message("❌ Session ping failed in room: " + string(room));
                    }
                    break;
                #endregion
                    
                default:
                    show_debug_message("❓ Unknown callback type: " + global.network_callback);
                    break;
            }        
        } else {
            show_debug_message("❌ No 'response' key found in JSON");
        }
    } catch (e) {
        show_debug_message("❌ Error parsing JSON: " + string(e));
    }
} else if (r_status != 0) {
    show_debug_message("❌ HTTP request failed with status: " + string(r_status));
}

show_debug_message("=== FINAL STATE ===");
show_debug_message("Current Avatar ID: " + string(global.__gj_avatar));
show_debug_message("Is sprite valid: " + string(sprite_exists(global.__gj_avatar)));
show_debug_message("Callback: " + global.network_callback);
show_debug_message("Room: " + string(room));
show_debug_message("-----------------------------------------------------------------------");