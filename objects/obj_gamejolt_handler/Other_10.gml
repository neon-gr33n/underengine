switch (global.network_callback) {
            case "users/auth":
                if (variable_struct_get(r_j, "success") == "true") {
                    gj_session_open(global.gj_username, global.gj_token);
                } else {
                    if (!instance_exists(obj_gj_login)) {
                        instance_destroy();
                    }
                }
                break;

            case "sessions/open":
            case "sessions/ping":
                if (sessionClosing) {
                    break;
                }
                if (variable_struct_get(r_j, "success") == "true") {
                    global.__gj_authorized = true;    
                }
               break;
}		