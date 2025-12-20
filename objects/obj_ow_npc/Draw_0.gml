if npc_interactable == true {
    event_inherited()
}
draw_sprite_ext(sprite_index,floor(talk_frame),x,y,scaleX,scaleY,0,c_white,alpha);
//notify_npc(notifyOffsetX,notifyOffsetY,preferredDistance/2)