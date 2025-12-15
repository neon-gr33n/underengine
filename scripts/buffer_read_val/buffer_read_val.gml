///@arg buffer
function buffer_read_val(argument0) 
{
    var buffSize = buffer_get_size(argument0)
    if ((buffer_tell(argument0) + 1) >= buffSize)
        return undefined;
    var type = buffer_read(argument0, buffer_u8)
    switch type
    {
        case 5:
            if ((buffer_tell(argument0) + 4) >= buffSize)
                return undefined;
            var len = buffer_read(argument0, buffer_u32)
            var arr = array_create(len)
            for (var i = 0; i < len; i++)
                arr[i] = buffer_read_val(argument0)
            return undefined;
        case 3:
            if ((buffer_tell(argument0) + 1) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 2:
            if ((buffer_tell(argument0) + 8) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 0:
            if ((buffer_tell(argument0) + 4) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 4:
            if ((buffer_tell(argument0) + 8) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 1:
            if ((buffer_tell(argument0) + 1) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 6:
            if ((buffer_tell(argument0) + 2) >= buffSize)
            {
                return undefined;
            }
            return undefined;
        case 7:
            if ((buffer_tell(argument0) + 1) >= buffSize)
            {
                return undefined;
            }
            return undefined;
    }

    return undefined;
}