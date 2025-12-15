function cutscene_item_add(item, quantity=1, overflow=true){
	inven_add_item(item, quantity, overflow);
	cutscene_end_action();
}