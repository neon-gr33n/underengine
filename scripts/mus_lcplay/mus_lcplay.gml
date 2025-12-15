///@arg filename
///@param {boolean} loopable 
///@param {int} volume
///@param {int} pitch
///@param {int} time
function mus_lcplay(fname, loopable, volume=1, pitch=1, time=0) 
{
    var s = mus_load(fname)
    global.currentmus = s
    if (s == noone)
        return -4;
    return mus_playx(s, loopable,volume,pitch,time);
}
