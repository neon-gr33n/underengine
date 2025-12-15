function loadgame_unserialize(pBuff, pGoto)
{
    global.currentroom = buffer_read(pBuff, buffer_u16)
    global.time = buffer_read(pBuff, buffer_u32)
    global.fun = buffer_read(pBuff, buffer_u8)
    global.currentarea = buffer_read(pBuff, buffer_u8)
    s = buffer_read(pBuff, buffer_u16)
    for (i = 0; i < s; i++)
    {
        var key = buffer_read(pBuff, buffer_string)
        var val = buffer_read(pBuff, buffer_s8)
        ds_map_set(global.flags, key, val)
    }
    return;
}