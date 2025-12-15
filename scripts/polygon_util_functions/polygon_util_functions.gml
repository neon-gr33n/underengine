function polygon_arr_to_triangles(_polygon)
{
	
    var _polygonSize = array_length(_polygon);
    var _triangles = [];
	
	var _ppoint = 0;
	var _p1, _p2, _temp_p, _point, good;
	
	// While it's possible to make more than 1 triangle
    while _polygonSize > 3 {
		_point = _polygon[_ppoint];
		_p1 = _polygon[(_ppoint - 1 + _polygonSize) % _polygonSize];
		_p2 = _polygon[(_ppoint + 1) % _polygonSize];
		
		// Check that the angle is less or equal to 180 deg
		if (_point[0] - _p1[0]) * (_p2[1] - _p1[1]) + (_p1[1] - _point[1]) * (_p2[0] - _p1[0]) < 0 {
			_ppoint = (_ppoint + 1) % _polygonSize;
			continue;
		}
		good = true;
		
		// Check that the triangle is completely contained within the polygon
		for (var i = 1; i < _polygonSize - 2; i++) {
			_temp_p = _polygon[(_ppoint + 1 + i) % _polygonSize];
			if point_in_triangle(_temp_p[0], _temp_p[1], _p1[0], _p1[1], _point[0], _point[1], _p2[0], _p2[1])
			{
				good = false;
				break;
			}
		}
		
		// The triangle is good
		// so delete the centre point to clip off the triangle
		// and add the new triangle to the array
		if good {
			array_delete(_polygon, _ppoint, 1);
			_ppoint %= --_polygonSize;
			_triangles = array_concat(_triangles, [_p1, _point, _p2]);
			continue;
		}
		
		_ppoint = (_ppoint + 1) % _polygonSize;
    }
	// There are only three vertices left, so add the final triangle to the list
	_triangles = array_concat(_triangles, [_polygon[0], _polygon[1], _polygon[2]]);
	
	return _triangles;
}

function point_in_polygon(point, polygon) {
    var num_vertices = array_length(polygon);
    var _x = point[0];
    var _y = point[1];
    var inside = false;
 
    var p1 = polygon[0];
    var p2;
 
    for (var i = 1; i <= num_vertices; i++) {
        p2 = polygon[i % num_vertices];
 
        if (_y > min(p1[1], p2[1])) {
            if (_y <= max(p1[1], p2[1])) {
                if (_x <= max(p1[0], p2[0])) {
                    var x_intersection = ((_y - p1[1]) * (p2[0] - p1[0])) / (p2[1] - p1[1]) + p1[0];
 
                    if (p1[0] == p2[0] || _x <= x_intersection) {
                        inside = !inside;
                    }
                }
            }
        }
 
        p1 = p2;
    }
 
    return inside;
}

//function point_in_triangle_mesh(point, polygon) {
//    for (var i = 0; i < (array_length(polygon) div 3); i++) {
//		if point_in_triangle(point[0], point[1], polygon[i * 3 + 0][0], polygon[i * 3 + 0][1], polygon[i * 3 + 1][0], polygon[i * 3 + 1][1], polygon[i * 3 + 2][0], polygon[i * 3 + 2][1])
			
//			return true;
//	}
//	return false;
//}

//function epicpoint_in_triangle(x0, y0, x1, y1, x2, y2, x3, y3) {
//    var vx0, vy0, vx1, vy1, vx2, vy2, dot00, dot01, dot02, dot11, dot12, invDenom, u, v;
//	vx0 = x3 - x1;
//	vy0 = y3 - y1;
//	vx1 = x2 - x1;
//	vy1 = y2 - y1;
//	vx2 = x0 - x1;
//	vy2 = y0 - y1;
	
//	dot00 = dot_product(vx0, vy0, vx0, vy0);
//	dot01 = dot_product(vx0, vy0, vx1, vy1);
//	dot02 = dot_product(vx0, vy0, vx2, vy2);
//	dot11 = dot_product(vx1, vy1, vx1, vy1);
//	dot12 = dot_product(vx1, vy1, vx2, vy2);
	
//	invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
//	u = (dot11 * dot02 - dot01 * dot12) * invDenom;
//	v = (dot00 * dot12 - dot01 * dot02) * invDenom;
	
//	return (u >= 0) && (v >= 0) && (u + v < 1);
//}