/// @return Nested struct/array data that represents the contents of the "Config JSON" string
/// 
/// @param buffer  Buffer to read data from
/// @param offset  Offset in the buffer to read data from
/// 
/// @jujuadams 2023-04-07

function __VinylBufferReadConfigJSON(_buffer, _inOffset = undefined)
{
    if (_inOffset != undefined)
    {
        var _oldOffset = buffer_tell(_buffer);
        buffer_seek(_buffer, buffer_seek_start, _inOffset);
    }
    
    var _bufferSize = buffer_get_size(_buffer);
    
    var _result = undefined;
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            __VinylBufferReadConfigJSONComment(_buffer, _bufferSize);
        }
        else if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
        {
            __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
        }
        else if (_byte == ord("["))
        {
            _result = __VinylBufferReadConfigJSONArray(_buffer, _bufferSize);
        }
        else if (_byte == ord("{"))
        {
            _result = __VinylBufferReadConfigJSONStruct(_buffer, _bufferSize);
        }
        else if (_byte > 0x20)
        {
            __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting either { or [");
        }
    }
    
    if (_inOffset != undefined)
    {
        buffer_seek(_buffer, buffer_seek_start, _oldOffset);
    }
    
    return _result;
}

function __VinylBufferReadConfigJSONError(_buffer, _message)
{
    var _oldTell = buffer_tell(_buffer);
    var _oldByte = buffer_peek(_buffer, _oldTell-1, buffer_u8);
    buffer_poke(_buffer, _oldTell, buffer_u8, 0x00);
    
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _string = buffer_read(_buffer, buffer_string);
    buffer_poke(_buffer, _oldTell, buffer_u8, _oldByte);
    
    var _row = 1 + string_count("\n", _string);
    var _rowString = (_row == 1)? _string : string_delete(_string, 1, string_last_pos("\n", _string));
    var _column = string_length(_rowString) + 3*string_count(chr(0x09), _rowString);
    
    show_error(_message + "\nLine " + string(_row) + ", column " + string(_column) + "\n ", true);
}

function __VinylBufferReadConfigJSONArray(_buffer, _bufferSize)
{
    var _result = [];
    
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            __VinylBufferReadConfigJSONComment(_buffer, _bufferSize);
        }
        else if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
        {
            __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
        }
        else if (_byte == ord("]"))
        {
            return _result;
        }
        else if ((_byte == ord(":")) || (_byte == ord(",")))
        {
            __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting a value");
        }
        else if (_byte > 0x20)
        {
            var _value = __VinylBufferReadConfigJSONValue(_buffer, _bufferSize, _byte);
            array_push(_result, _value);
            
            //Find a comma, newline, or closing bracket
            while(buffer_tell(_buffer) < _bufferSize)
            {
                var _byte = buffer_read(_buffer, buffer_u8);
                if (_byte == ord("]"))
                {
                    return _result;
                }
                else if ((_byte == ord(",")) || (_byte == ord("\n")) || (_byte == ord("\r")))
                {
                    break;
                }
                else if (_byte > 0x20)
                {
                    __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting comma, newline, or closing bracket");
                }
            }
        }
    }
    
    __VinylBufferReadConfigJSONError(_buffer, "Found unterminated array");
}

function __VinylBufferReadConfigJSONStruct(_buffer, _bufferSize)
{
    var _result = {};
    
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("/")))
        {
            __VinylBufferReadConfigJSONComment(_buffer, _bufferSize);
        }
        else if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
        {
            __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
        }
        else if (_byte == ord("}"))
        {
            //Handle empty structs
            if (array_length(_result) <= 0) array_push(_result, {});
            
            return _result;
        }
        else if ((_byte == ord(":")) || (_byte == ord(",")))
        {
            __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting a key");
        }
        else if (_byte > 0x20)
        {
            var _key = __VinylBufferReadConfigJSONValue(_buffer, _bufferSize, _byte);
            
            if (!is_string(_key))
            {
                if (is_array(_key))
                {
                    var _keyArray = _key;
                    var _keyArrayLength = array_length(_keyArray);
                    
                    if (_keyArrayLength <= 0)
                    {
                        __VinylBufferReadConfigJSONError(_buffer, "Struct key arrays must have at least one element");
                    }
                    else if (_keyArrayLength <= 1)
                    {
                        if (!is_string(_keyArray[0])) __VinylBufferReadConfigJSONError(_buffer, "Struct keys must be strings (key was " + string(_keyArray[0]) + ", typeof=" + typeof(_keyArray[0]) + ")");
                    }
                }
                else
                {
                    __VinylBufferReadConfigJSONError(_buffer, "Struct keys must be strings (key was " + string(_key) + ", typeof=" + typeof(_key) + ")");
                }
            }
            
            //Find a colon
            while(buffer_tell(_buffer) < _bufferSize)
            {
                var _byte = buffer_read(_buffer, buffer_u8);
                
                if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
                {
                    __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
                }
                else if (_byte == ord(":"))
                {
                    break;
                }
                else if (_byte > 0x20)
                {
                    __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting a colon");
                }
            }
            
            //Find the start of a value
            var _byte = 0x00;
            while(buffer_tell(_buffer) < _bufferSize)
            {
                var _byte = buffer_read(_buffer, buffer_u8);
                
                if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
                {
                    __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
                }
                else if (_byte > 0x20)
                {
                    break;
                }
            }
            if (_byte <= 0x20) __VinylBufferReadConfigJSONError(_buffer, "Could not find start of value for key \"" + _key + "\"");
            
            //Read a value and store it in the struct
            var _value = __VinylBufferReadConfigJSONValue(_buffer, _bufferSize, _byte);
            
            if (is_string(_key))
            {
                __VinylBufferReadConfigJSONStructMerge(_result, _key, _value);
            }
            else //Is an array
            {
                //Use the original return value to set the first key
                __VinylBufferReadConfigJSONStructMerge(_result, _keyArray[0], _value);
                
                //Use duplicate return values for subsequent keys
                var _i = 1;
                repeat(_keyArrayLength-1)
                {
                    var _key = _keyArray[_i];
                    if (!is_string(_key)) __VinylBufferReadConfigJSONError(_buffer, "Struct keys must be strings (key was " + string(_key) + ", typeof=" + typeof(_key) + ")");
                    __VinylBufferReadConfigJSONStructMerge(_result, _key, __VinylBufferReadConfigJSONDeepCopyInner(_value, self, self));
                    ++_i;
                }
            }
            
            //Find a comma, newline, or closing bracket
            while(buffer_tell(_buffer) < _bufferSize)
            {
                var _byte = buffer_read(_buffer, buffer_u8);
                
                if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
                {
                    __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
                }
                else if (_byte == ord("}"))
                {
                    return _result;
                }
                else if ((_byte == ord(",")) || (_byte == ord("\n")) || (_byte == ord("\r")))
                {
                    break;
                }
                else if (_byte > 0x20)
                {
                    __VinylBufferReadConfigJSONError(_buffer, "Found unexpected character " + chr(_byte) + " (decimal=" + string(_byte) + ")\nWas expecting comma, newline, or closing bracket");
                }
            }
        }
    }
    
    __VinylBufferReadConfigJSONError(_buffer, "Found unterminated struct");
}

function __VinylBufferReadConfigJSONStructMerge(_rootStruct, _key, _newValue)
{
    if (variable_struct_exists(_rootStruct, _key))
    {
        var _oldValue = _rootStruct[$ _key];
        if (is_array(_oldValue))
        {
            if (is_array(_newValue))
            {
                //Merge the new values into the old values
                var _i = 0;
                repeat(array_length(_newValue))
                {
                    array_push(_oldValue, _newValue[_i]);
                    ++_i;
                }
                
                return;
            }
        }
        else if (is_struct(_oldValue))
        {
            if (is_struct(_newValue))
            {
                //Merge the new values into the old values
                var _variableNameArray = variable_struct_get_names(_newValue);
                var _i = 0;
                repeat(array_length(_variableNameArray))
                {
                    var _variableName = _variableNameArray[_i];
                    __VinylBufferReadConfigJSONStructMerge(_oldValue, _variableName, _newValue[$ _variableName]);
                    ++_i;
                }
                
                return;
            }
        }
    }
    
    _rootStruct[$ _key] = _newValue;
}

function __VinylBufferReadConfigJSONStructMergeNoOverwrite(_rootStruct, _key, _newValue)
{
    if (variable_struct_exists(_rootStruct, _key))
    {
        var _oldValue = _rootStruct[$ _key];
        if (is_array(_oldValue))
        {
            if (is_array(_newValue))
            {
                //Merge the new values into the old values
                var _i = 0;
                repeat(array_length(_newValue))
                {
                    array_push(_oldValue, _newValue[_i]);
                    ++_i;
                }
            }
            else
            {
                __VinylError("Error when merging arrays");
            }
        }
        else if (is_struct(_oldValue))
        {
            if (is_struct(_newValue))
            {
                //Merge the new values into the old values
                var _variableNameArray = variable_struct_get_names(_newValue);
                var _i = 0;
                repeat(array_length(_variableNameArray))
                {
                    var _variableName = _variableNameArray[_i];
                    __VinylBufferReadConfigJSONStructMergeNoOverwrite(_oldValue, _variableName, _newValue[$ _variableName]);
                    ++_i;
                }
            }
            else
            {
                __VinylError("Error when merging structs");
            }
        }
        
        return;
    }
    
    _rootStruct[$ _key] = _newValue;
}

function __VinylBufferReadConfigJSONValue(_buffer, _bufferSize, _firstByte)
{
    if (_firstByte == ord("["))
    {
        return __VinylBufferReadConfigJSONArray(_buffer, _bufferSize);
    }
    else if (_firstByte == ord("{"))
    {
        return __VinylBufferReadConfigJSONStruct(_buffer, _bufferSize);
    }
    else if (_firstByte == ord("\""))
    {
        return __VinylBufferReadConfigJSONDelimitedString(_buffer, _bufferSize);
    }
    else
    {
        return __VinylBufferReadConfigJSONString(_buffer, _bufferSize);
    }
}

function __VinylBufferReadConfigJSONDelimitedString(_buffer, _bufferSize)
{
    static _cacheBuffer = buffer_create(1024, buffer_grow, 1);
    buffer_seek(_cacheBuffer, buffer_seek_start, 0);
    
    var _start = buffer_tell(_buffer);
    var _stringUsesCache = false;
    
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if (_byte == ord("\""))
        {
            if (_stringUsesCache)
            {
                var _size = buffer_tell(_buffer) - _start-1;
                if (_size > 0)
                {
                    buffer_copy(_buffer, _start, _size, _cacheBuffer, buffer_tell(_cacheBuffer));
                    buffer_seek(_cacheBuffer, buffer_seek_relative, _size);
                }
                
                buffer_write(_cacheBuffer, buffer_u8, 0x00);
                buffer_seek(_cacheBuffer, buffer_seek_start, 0);
                var _result = buffer_read(_cacheBuffer, buffer_string);
            }
            else
            {
                var _end = buffer_tell(_buffer)-1;
                var _oldByte = buffer_peek(_buffer, _end, buffer_u8);
                buffer_poke(_buffer, _end, buffer_u8, 0x00);
                var _result = buffer_peek(_buffer, _start, buffer_string);
                buffer_poke(_buffer, _end, buffer_u8, _oldByte);
            }
            
            return _result;
        }
        else if (_byte == ord("\\"))
        {
            _stringUsesCache = true;
            
            var _size = buffer_tell(_buffer) - _start-1;
            if (_size > 0)
            {
                buffer_copy(_buffer, _start, _size, _cacheBuffer, buffer_tell(_cacheBuffer));
                buffer_seek(_cacheBuffer, buffer_seek_relative, _size);
            }
            
            var _byte = buffer_read(_buffer, buffer_u8);
            switch(_byte)
            {
                case ord("n"): buffer_write(_cacheBuffer, buffer_u8, ord("\n")); break;
                case ord("r"): buffer_write(_cacheBuffer, buffer_u8, ord("\r")); break;
                case ord("t"): buffer_write(_cacheBuffer, buffer_u8, ord("\t")); break;
                
                case ord("u"):
                    var _oldByte = buffer_peek(_buffer, buffer_tell(_buffer)+4, buffer_u8);
                    buffer_poke(_buffer, buffer_tell(_buffer)+4, buffer_u8, 0x00);
                    var _hex = buffer_read(_buffer, buffer_string);
                    buffer_seek(_buffer, buffer_seek_relative, -1);
                    buffer_poke(_buffer, buffer_tell(_buffer), buffer_u8, _oldByte);
                    
                    var _value = int64(ptr(_hex));
                    if (_value <= 0x7F) //0xxxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, _value);
                    }
                    else if (_value <= 0x07FF) //110xxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ((_value >> 6) & 0x1F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ( _value       & 0x3F));
                    }
                    else if (_value <= 0xFFFF) //1110xxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ( _value        & 0x0F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  4) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >> 10) & 0x3F));
                    }
                    else if (_value <= 0x10000) //11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ( _value        & 0x07));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  3) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  9) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >> 15) & 0x3F));
                    }
                break;
                
                default:
                    if ((_byte & $E0) == $C0) //110xxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 1, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 1);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 1);
                    }
                    else if ((_byte & $F0) == $E0) //1110xxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 2, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 2);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 2);
                    }
                    else if ((_byte & $F8) == $F0) //11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 3, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 3);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 3);
                    }
                    else
                    {
                        buffer_write(_cacheBuffer, buffer_u8, _byte);
                    }
                break;
            }
            
            _start = buffer_tell(_buffer);
        }
    }
    
    __VinylBufferReadConfigJSONError(_buffer, "Found unterminated string");
}

function __VinylBufferReadConfigJSONString(_buffer, _bufferSize)
{
    static _cacheBuffer = buffer_create(1024, buffer_grow, 1);
    buffer_seek(_cacheBuffer, buffer_seek_start, 0);
    
    var _result = undefined;
    
    var _start = buffer_tell(_buffer)-1;
    var _end   = _start+1;
    
    var _stringUsesCache = false;
    
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        
        if ((_byte == ord(":"))
         || (_byte == ord(","))
         || (_byte == ord("}"))
         || (_byte == ord("]"))
         || (_byte == ord("\n"))
         || (_byte == ord("\r"))
         || ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*"))))
        {
            if (_stringUsesCache)
            {
                var _size = _end - _start;
                if (_size > 0)
                {
                    buffer_copy(_buffer, _start, _size, _cacheBuffer, buffer_tell(_cacheBuffer));
                    buffer_seek(_cacheBuffer, buffer_seek_relative, _size);
                }
                
                buffer_write(_cacheBuffer, buffer_u8, 0x00);
                buffer_seek(_cacheBuffer, buffer_seek_start, 0);
                var _result = buffer_read(_cacheBuffer, buffer_string);
            }
            else
            {
                var _oldByte = buffer_peek(_buffer, _end, buffer_u8);
                buffer_poke(_buffer, _end, buffer_u8, 0x00);
                var _result = buffer_peek(_buffer, _start, buffer_string);
                buffer_poke(_buffer, _end, buffer_u8, _oldByte);
                
                if (_result == "true")
                {
                    _result = true;
                }
                else if (_result == "false")
                {
                    _result = false;
                }
                else if (_result == "null")
                {
                    _result = undefined;
                }
                else
                {
                    try
                    {
                        _result = real(_result);
                    }
                    catch(_error)
                    {
                        //Not a number apparently
                    }
                }
            }
            
            buffer_seek(_buffer, buffer_seek_relative, -1);
            
            if ((_byte == ord("/")) && (buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8) == ord("*")))
            {
                __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize);
            }
            
            return _result;
        }
        else if (_byte == ord("\\"))
        {
            _stringUsesCache = true;
            
            var _size = buffer_tell(_buffer) - _start-1;
            if (_size > 0)
            {
                buffer_copy(_buffer, _start, _size, _cacheBuffer, buffer_tell(_cacheBuffer));
                buffer_seek(_cacheBuffer, buffer_seek_relative, _size);
            }
            
            var _byte = buffer_read(_buffer, buffer_u8);
            switch(_byte)
            {
                case ord("n"): buffer_write(_cacheBuffer, buffer_u8, ord("\n")); break;
                case ord("r"): buffer_write(_cacheBuffer, buffer_u8, ord("\r")); break;
                case ord("t"): buffer_write(_cacheBuffer, buffer_u8, ord("\t")); break;
                
                case ord("u"):
                    var _oldByte = buffer_peek(_buffer, buffer_tell(_buffer)+4, buffer_u8);
                    buffer_poke(_buffer, buffer_tell(_buffer)+4, buffer_u8, 0x00);
                    var _hex = buffer_read(_buffer, buffer_string);
                    buffer_seek(_buffer, buffer_seek_relative, -1);
                    buffer_poke(_buffer, buffer_tell(_buffer), buffer_u8, _oldByte);
                    
                    var _value = int64(ptr(_hex));
                    if (_value <= 0x7F) //0xxxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, _value);
                    }
                    else if (_value <= 0x07FF) //110xxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ((_value >> 6) & 0x1F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ( _value       & 0x3F));
                    }
                    else if (_value <= 0xFFFF) //1110xxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ( _value        & 0x0F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  4) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >> 10) & 0x3F));
                    }
                    else if (_value <= 0x10000) //11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_write(_cacheBuffer, buffer_u8, 0xC0 | ( _value        & 0x07));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  3) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >>  9) & 0x3F));
                        buffer_write(_cacheBuffer, buffer_u8, 0x80 | ((_value >> 15) & 0x3F));
                    }
                break;
                
                default:
                    if ((_byte & $E0) == $C0) //110xxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 1, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 1);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 1);
                    }
                    else if ((_byte & $F0) == $E0) //1110xxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 2, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 2);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 2);
                    }
                    else if ((_byte & $F8) == $F0) //11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
                    {
                        buffer_copy(_buffer, buffer_tell(_buffer)+1, 3, _cacheBuffer, buffer_tell(_cacheBuffer));
                        buffer_seek(_buffer, buffer_seek_relative, 3);
                        buffer_seek(_cacheBuffer, buffer_seek_relative, 3);
                    }
                    else
                    {
                        buffer_write(_cacheBuffer, buffer_u8, _byte);
                    }
                break;
            }
            
            _start = buffer_tell(_buffer);
        }
        else if (_byte > 0x20)
        {
            _end = buffer_tell(_buffer);
        }
    }
    
    __VinylBufferReadConfigJSONError(_buffer, "Found unterminated value");
}

function __VinylBufferReadConfigJSONComment(_buffer, _bufferSize)
{
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if ((_byte == ord("\n")) || (_byte == ord("\r")))
        {
            buffer_seek(_buffer, buffer_seek_relative, -1);
            break;
        }
    }
}

function __VinylBufferReadConfigJSONMultilineComment(_buffer, _bufferSize)
{
    while(buffer_tell(_buffer) < _bufferSize)
    {
        var _byte = buffer_read(_buffer, buffer_u8);
        if (_byte == ord("*"))
        {
            _byte = buffer_read(_buffer, buffer_u8);
            if (_byte == ord("/")) break;
        }
    }
}

function __VinylBufferReadConfigJSONDeepCopyInner(_value, _oldStruct, _newStruct)
{
    var _copy = _value;
    
    if (is_method(_value))
    {
        var _self = method_get_self(_value);
        if (_self == _oldStruct)
        {
            //If this method is bound to the source struct, create a new method bound to the new struct
            _value = method(_newStruct, method_get_index(_value));
        }
        else if (_self != undefined)
        {
            //If the scope of the method isn't <undefined> (global) then spit out a warning
            show_debug_message("SnapDeepCopy(): Warning! Deep copy found a method reference that could not be appropriately handled");
        }
    }
    else if (is_struct(_value))
    {
        var _namesArray = variable_struct_get_names(_value);
        var _copy = {};
        var _i = 0;
        repeat(array_length(_namesArray))
        {
            var _name = _namesArray[_i];
            _copy[$ _name] = __VinylBufferReadConfigJSONDeepCopyInner(_value[$ _name], _value, _copy);
            ++_i;
        }
    }
    else if (is_array(_value))
    {
        var _count = array_length(_value);
        var _copy = array_create(_count);
        var _i = 0;
        repeat(_count)
        {
            _copy[@ _i] = __VinylBufferReadConfigJSONDeepCopyInner(_value[_i], _oldStruct, _newStruct);
            ++_i;
        }
    }
    
    return _copy;
}