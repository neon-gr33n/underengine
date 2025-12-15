appid = "1181888168790872064"
unsupport = 0
if ((!is_android()))
{
    if (!(np_initdiscord(appid, 1, 0)))
    {
        show_error("NekoPresence init fail. Rich Presence isn't supported for this PC.", 0)
        global.presence = 0
        unsupport = 1
    }
}
runonce = 0
location = ""
