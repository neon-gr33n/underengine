/// @description Updates view vars
if surface_exists(application_surface) surface_set_target(application_surface)
view_xx = camera_get_view_x(view);
view_yy = camera_get_view_y(view);
view_hh = camera_get_view_height(view);
view_ww = camera_get_view_width(view);
view_center_x = view_xx + view_ww / 2;
view_center_y = view_yy + view_hh / 2;
