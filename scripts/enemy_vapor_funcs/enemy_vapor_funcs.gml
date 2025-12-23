/// @func load_vapor_data(filename)
/// @returns buffer id
function load_vapor_data(filename){
	var real_f_path = is_android() == true ? "assets/data/tmp/" + filename : "data/tmp/" + filename;
	if (!file_exists(real_f_path)) {
	    show_debug_message("Missing vapor file: " + real_f_path);
	    return -1;
	}

	var buf = buffer_load(real_f_path);
	buffer_seek(buf, buffer_seek_start, 0);

	return buf;
}

// @desc Creates obj_vaporizer fully initialized from an object instance
/// @returns instance id or noone
function create_vaporizer(_source_inst, _filename)
{
    if (!instance_exists(_source_inst)) {
        show_debug_message("Source instance does not exist");
        return noone;
    }

    // Resolve platform-safe path
    var real_path =
        is_android()
        ? "assets/data/tmp/" + _filename
        : "data/tmp/" + _filename;

    if (!file_exists(real_path)) {
        show_debug_message("Missing vapor file: " + real_path);
        return noone;
    }

    // Load buffer
    var buf = buffer_load(real_path);
    buffer_seek(buf, buffer_seek_start, 0);

    // Create vaporizer at source position
    var inst = instance_create_depth(
        _source_inst.x,
        _source_inst.y,
        obj_battle_box.depth + 1,
        obj_vaporizer
    );

    // Inject vapor data
    inst.vapor_buf = buf;
    inst.read_pos = buffer_tell(buf); // right after header
    inst.line = 0;
    inst.finished = false;

    // Pull visual data from the source object
    inst.sprite_index  = _source_inst.sprite_index;
    inst.image_index   = _source_inst.image_index;
    inst.image_xscale  = _source_inst.image_xscale;
    inst.image_yscale  = _source_inst.image_yscale;
    inst.image_angle   = _source_inst.image_angle;
    inst.image_alpha   = _source_inst.image_alpha;
    inst.image_blend   = _source_inst.image_blend;

    // Initialize dimensions (scaled)
    inst.wd = sprite_get_width(inst.sprite_index)  * abs(inst.image_xscale);
    inst.ht = sprite_get_height(inst.sprite_index) * abs(inst.image_yscale);

    return inst;
}
