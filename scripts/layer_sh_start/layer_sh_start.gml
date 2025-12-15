function layer_sh_uni(){
	if event_type == ev_draw
	{
		if event_number == ev_draw_normal
		{
	        shader_set(Shader8);
			var outlineColor = shader_get_uniform(Shader8,"outlineColor")
			shader_set_uniform_f(outlineColor, 1,0,0,1 )
			var outlineW = shader_get_uniform(Shader8,"pixelW")
			shader_set_uniform_f(outlineW, texture_get_texel_width(sprite_get_texture(obj_ow_party.sprite_index,(obj_ow_party.sprite_index==obj_ow_party.spriteIdle ? floor(obj_ow_party.remdir[0]/4) : obj_ow_party.remdir[0]))))
			var outlineH = shader_get_uniform(Shader8,"pixelH")
			shader_set_uniform_f(outlineH, texture_get_texel_height(sprite_get_texture(obj_ow_party.sprite_index,(obj_ow_party.sprite_index==obj_ow_party.spriteIdle ? floor(obj_ow_party.remdir[0]/4) : obj_ow_party.remdir[0]))))
		}
	}
}