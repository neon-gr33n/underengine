/// @desc Soul Collision
if (!has_hit) {
    // First, check if we're actually touching the soul
    var soul = instance_place(x, y, HEART);
    
    if (soul != noone) {
        has_hit = true;
        
        // Apply damage if HP > 0
        if (global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"] > 0) {
            global.PARTY_INFO[$ global.PARTY_INFO[$ "__PARTY__"][$ "MEMBERS"][0]][$ "STATS"][$ "HP"] -= round(id._damage);
        }
        
        // Wait 1 frame before destroying to ensure collision is processed
        alarm[0] = 1;
    }
}

// In Alarm 0 event:
instance_destroy();