/// @desc Authorizes access to a Game Jolt User's Information. This should be called before any other user related GJ Functions are called.
/// @arg {string} _username The game jolt user's username
/// @arg {string} _token The user's unique Game Token
function gj_user_authorize(_username, _token)
{
	network_gj_request_start("users/auth",_username,_token);
}

/// @desc Fetches information about a Game Jolt User's Account.
/// @arg {string} _username The game jolt user's username
/// @desc Fetches information about a Game Jolt User's Account.
/// @arg {string} _username The game jolt user's username
function gj_user_fetch(_username)
{
    show_debug_message("🔧 gj_user_fetch() called for username: " + _username);
    
    if global.gj_isoccupied == false
    {
        // Build the base URL without signature first
        var base_url = "https://api.gamejolt.com/api/game/v1_2/users/?game_id=" + string(global.gameid) + "&username=" + string(_username);
        
        // Create signature string (URL + private key)
        var signature_string = base_url + global.key; // global.key should be your private key
        var hashed = md5_string_utf8(signature_string);
        
        // Build final URL with signature
        var final_url = base_url + "&signature=" + hashed;
        
        show_debug_message("📡 Making users/fetch request to: " + final_url);
        
        // Make the HTTP request
        var response = http_get(final_url);
        
        show_debug_message("✅ gj_user_fetch request ID: " + string(response));
        
        // RETURN the response ID, not the debug message!
        return response;
    }
    else 
    {
        show_debug_message("❌ gj_user_fetch failed - GJ system is occupied");
        return undefined;
    }
}