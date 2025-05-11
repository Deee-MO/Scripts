extends Item

func OnShopEntered() -> void:
	Globals.ChangeLife(Globals.playerMaxHealth - Globals.playerHealth)

func CheckFiltration() -> bool:
	for item in Globals.itemList.get_children():
		if item.id == id:
			FullItemList.FilterList[id] = FullItemList.Filter.None
			return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
