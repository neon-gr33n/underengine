///@arg filename
function mus_is_current(fname) 
{
    if (global.currentmus == noone)
        return 0;
    switch fname
    {
        //case "yourgenosonghere":
        //    if (global.currentmus == "yourgenosonghere")
        //        return 1;
        default:
            return global.currentmus== fname;
    }

}