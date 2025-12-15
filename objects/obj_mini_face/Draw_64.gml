if(live_call()) return live_result;
var spriteWidth;
draw_set_alpha(image_alpha)
draw_sprite_ext(face, image_index/6, x+400, y-45, 1, 1, image_angle, c_white, image_alpha)
spriteWidth = (sprite_get_width(face) + 10)
draw_ftext(_font,c_white,x+sprite_width+440,y-30,1,1,0,_text_comment)

draw_set_alpha(1)
