extends Item

func OnPickUp()->void:
	Globals.ballAcceleration *= 0.9

func OnRemoval()->void:
	Globals.ballAcceleration *= 1./0.9

func CheckFiltration() -> bool:
	var count : int = 0
	for item in Globals.itemList.get_children():
		if item.id == id:
			count = count + 1
	if count >= 5:
		FullItemList.FilterList[id]  = FullItemList.Filter.None
		return 0
	FullItemList.FilterList[id]  = FullItemList.Filter.All
	return 1
