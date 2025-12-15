if _procs > 0 {
    var time_factor = _procs * 5;
    var spread_progress = 1 - _procs/4.5;
    
    for (i = 0; i < 5; i++) {
        var x_spread = 0;
        var y_float = 0;
        
        // All pieces get minimal spread like piece 4
        if (i == 0) {
            x_spread = sin(time_factor * 0.7) * 3 * spread_progress; // Minimal
            y_float = cos(time_factor * 1.3) * 0.5 * spread_progress; // Minimal
        }
        else if (i == 1) {
            x_spread = cos(time_factor * 1.4) * 3.5 * spread_progress; // Minimal
            y_float = sin(time_factor * 0.9) * 0.6 * spread_progress; // Minimal
        }
        else if (i == 2) {
            x_spread = (i - 2) * (1 - _procs) * 2; // Minimal linear
            y_float = sin(time_factor * 1.5) * 0.5 * spread_progress; // Minimal
        }
        else if (i == 3) {
            x_spread = sin(time_factor * 1.8 + 2.5) * 4 * spread_progress; // Reduced to match
            y_float = cos(time_factor * 1.1 + 1.5) * 0.7 * spread_progress; // Reduced
        }
        else if (i == 4) {
            x_spread = cos(time_factor * 0.6) * 3.5 * spread_progress; // Keep as reference
            y_float = sin(time_factor * 0.8) * 0.5 * spread_progress; // Keep
        }
        
        draw_sprite_part_ext(
            _sprites, 0,
            0,
            sprite_get_height(_sprites) - (_procs + i),
            sprite_get_width(_sprites),
            (1),
            _xs - sprite_get_width(_sprites) * _xscales / 2 + 0.5 * _xscales + x_spread,
            _ys - (_procs + i) * _yscales - (4 * i) - 1 * _yscales + y_float,
            _xscales, _yscales,
            _blends,
            _alphas - (0.2 * i)
        );
    }
    
    draw_sprite_part_ext(
        _sprites, 0,
        0,
        sprite_get_height(_sprites) - (_procs + 1),
        sprite_get_width(_sprites),
        (_procs - 1),
        _xs - sprite_get_width(_sprites) * _xscales / 2 + 0.5 * _xscales,
        _ys - _procs * _yscales - 1 * _yscales,
        _xscales, _yscales,
        _blends,
        _alphas
    );
    
    _procs -= _death_speed;
}