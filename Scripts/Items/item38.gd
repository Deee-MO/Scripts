extends Item

func _ready() -> void:
	held = 0


func OnPickUp()->void:
	#if there are no other items make a junk item
	if Globals.itemList.get_child_count() == 0:
		Globals.currency += 500
	#if there is at least one other item
	else:
		var picked = self
		#pick a random, i dont like how we do it but the alternative is memory expensive
		while picked == self:
			picked = Globals.itemList.get_children().pick_random()
		#remove picked and get money = rarity * 2000
		Globals.currency += FullItemList.List[picked.id][1] * 2000
		FullItemList.RemoveItem(picked)
	if Globals.level != null:
		Globals.level.uiright.setMoneyText()

func CheckFiltration() -> bool:
	if !(FullItemList.FilterList[id] == FullItemList.Filter.Drop):
		FullItemList.FilterList[id] = FullItemList.Filter.Drop
		return 0
	return 1
