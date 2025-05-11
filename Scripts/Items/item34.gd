extends Item

#Item that does nothing
const ITEM_54_ID : int = 54

func _ready() -> void:
	held = 0
	
func OnPickUp()->void:
	#if there are no other items make a junk item
	if Globals.itemList.get_child_count() == 1:
		var item: Item = load(FullItemList.List[ITEM_54_ID][0]).instantiate()
		Globals.itemList.add_child(item)
	#if there is at least one other item
	else:
		var picked = self
		#pick a random, i dont like how we do it but the alternative is memory expensive
		while picked == self:
			picked = Globals.itemList.get_children().pick_random()
		#make a copy of picked
		var item: Item = load(FullItemList.List[picked.id][0]).instantiate()
		Globals.itemList.add_child(item)


